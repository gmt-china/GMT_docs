"""
A directive for including a GMT plot in a Sphinx document.

Options
-------

The ``gmtplot`` directive supports the following options:

show-code
    Whether to show the source code. The default can be changed by the
    ``gmtplot_show_code`` variable in ``conf.py``.

language
    Specify the language of the source code: either "bash" or "python".

caption
    Caption of the rendered figure.

Additionally, this directive also supports options of the standard ``figure``
and ``literalinclude`` directives.

Configuration options
---------------------

The following options can be set in ``conf.py`` and will apply globally:

gmtplot_show_code
    Default value for the ``show-code`` option. Default is ``True``.

gmtplot_basedir
    Base directory, to which ``gmtplot`` file names are relative to. If None or
    empty, file names are relative to the directory where the file containing the
    directive is. However, if it is absolute (starting with ``/``), it is relative
    to the top source directory. Default is ``None``.

gmtplot_figure_align
    The figure alignment. Default is ``"center"``.

gmtplot_gmt_config
    A dict of GMT settings that are applied to all GMT scripts.
    Default is ``{"GMT_GRAPHICS_FORMAT": "ps"}``.

"""

import ast
import os
import shutil
import subprocess
import sys
import tempfile
import textwrap
from contextlib import contextmanager
from pathlib import Path

import jinja2
from docutils.parsers.rst import Directive, directives
from sphinx.util import md5

TEMPLATE = """
{%- if show_code -%}
.. literalinclude:: {{ code }}
    {% for option in code_opts -%}
    {{ option }}
    {% endfor %}
{%- else %}
:download:`Source Code <{{ code }}>`
{%- endif %}

.. figure:: {{ image }}
    :name: {{ label }}
    {% for option in image_opts -%}
    {{ option }}
    {% endfor %}

    {{ caption }}

"""


def _option_language(arg):
    """
    Check language option.
    """
    return directives.choice(arg, ("bash", "python"))


def _option_boolean(arg):
    """
    Check boolean options.
    """
    if not arg or not arg.strip():  # no argument given, assume used as a flag
        return True
    if arg.strip().lower() in ("no", "0", "false"):
        return False
    if arg.strip().lower() in ("yes", "1", "true"):
        return True
    raise ValueError('f"{arg}" unknown boolean')


def _option_align(arg):
    """
    Check align option.
    """
    return directives.choice(
        arg, ("top", "middle", "bottom", "left", "center", "right")
    )


def _updated_gmt_datadir(code_dir):
    """
    Add the code's current directory to evirionment variable GMT_DATADIR
    so that script can access its data files.
    """
    if os.environ.get("GMT_DATADIR") is not None:
        sep = ";" if sys.platform == "win32" else ":"
        return f"{sep}".join([str(code_dir), os.environ["GMT_DATADIR"]])
    return str(code_dir)


@contextmanager
def environ(env):
    """
    Temporarily set environment variables inside the context manager and
    fully restore previous environment afterwards.
    """
    original_env = {key: os.getenv(key) for key in env}
    os.environ.update(env)
    try:
        yield
    finally:
        for key, value in original_env.items():
            if value is None:
                del os.environ[key]
            else:
                os.environ[key] = value


def _write_gmt_config(gmt_config, cwd):
    """
    Write GMT settings to a gmt.conf file in the current directory.
    """
    if not gmt_config:
        return
    with open(Path(cwd, "gmt.conf"), "w", encoding="utf-8") as fconf:
        for key, value in gmt_config.items():
            fconf.write(f"{key} = {value}")


def _search_images(cwd):
    # pylint: disable=no-else-return,no-else-raise
    """
    Search images in PNG and PDF format in a specified directory.
    If .png and .pdf files are not found and .ps file is found, then
    convert .ps file to PNG and PDF format.
    """
    cwd = Path(cwd)
    png_images = list(cwd.glob("*.png"))

    if len(png_images) > 1:
        raise ValueError("More than one figure generated in one GMT plot.")
    elif len(png_images) == 1:
        pdf_images = list(cwd.glob("*.pdf"))
        if len(pdf_images) == 1:
            return [png_images[0], pdf_images[0]]
        else:
            return [png_images[0]]
    else:  # no PNG found
        ps_images = list(cwd.glob("*.ps"))
        if len(ps_images) > 1:
            raise ValueError("More than one figure generated in one GMT plot.")
        elif len(ps_images) == 1:  # PS found
            cmd = "gmt psconvert -A -P -T{} {}"
            subprocess.run(cmd.format("g", ps_images[0]), shell=True, check=False)
            subprocess.run(cmd.format("f", ps_images[0]), shell=True, check=False)
            png_images = list(cwd.glob("*.png"))
            pdf_images = list(cwd.glob("*.pdf"))

            if len(png_images) == 1 and len(pdf_images) == 1:
                return [png_images[0], pdf_images[0]]
            else:
                return []
        else:  # No PNG and PS found
            return []


def eval_bash(code, code_dir, output_dir, output_base, config=None):
    """
    Execute a multi-line block of bash code and copy the generated image files
    to specified output directory.
    """
    with environ(
        {"GMT_END_SHOW": "off", "GMT_DATADIR": _updated_gmt_datadir(code_dir)}
    ), tempfile.TemporaryDirectory() as tmpdir:
        Path(tmpdir, "gmtplot-script.sh").write_text(code, encoding="utf-8")
        if config.gmtplot_gmt_config:
            _write_gmt_config(config.gmtplot_gmt_config, cwd=tmpdir)
        proc = subprocess.run(
            ["bash", "-e", Path(tmpdir, "gmtplot-script.sh")],
            check=False,
            cwd=tmpdir,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if proc.returncode != 0:
            raise RuntimeError(
                "\nGMT bash failed:\n"
                f"{code}"
                f"STDOUT: {proc.stdout.decode('utf-8')}"
                f"STDERR: {proc.stderr.decode('utf-8')}"
            )
        for image in _search_images(tmpdir):
            shutil.move(image, Path(output_dir, output_base).with_suffix(image.suffix))
        return f"{output_base}.*"


class _CatchDisplay:
    "Class to temporarily catch sys.displayhook"
    # pylint: disable=too-few-public-methods
    # pylint: disable=attribute-defined-outside-init

    def __init__(self):
        self.output = None

    def __enter__(self):
        self.old_hook = sys.displayhook
        sys.displayhook = self
        return self

    def __exit__(self, dtype, value, traceback):
        sys.displayhook = self.old_hook
        # Returning False will cause exceptions to propagate
        return False

    def __call__(self, output):
        self.output = output


def eval_python(
    code, code_dir, output_dir, output_base, filename="<string>", config=None
):
    # pylint: disable=exec-used,too-many-arguments
    """
    Execute a multi-line block of Python code and copy the generated image files
    to specified output directory.
    """
    tree = ast.parse(code, filename="<ast>", mode="exec")
    if (
        isinstance(tree.body[-1], ast.Expr) and tree.body[-1].value.func.attr == "show"
    ):  # last statement is `fig.show()` in pygmt
        to_exec, to_eval = tree.body[:-1], tree.body[-1:]
    else:
        to_exec, to_eval = tree.body, []

    cwd = os.getcwd()
    with environ(
        {"GMT_END_SHOW": "off", "GMT_DATADIR": _updated_gmt_datadir(code_dir)}
    ), tempfile.TemporaryDirectory() as tmpdir:
        os.chdir(tmpdir)
        if config.gmtplot_gmt_config:
            _write_gmt_config(config.gmtplot_gmt_config, cwd=".")
        for node in to_exec:
            exec(
                compile(
                    ast.Module([node], type_ignores=[]), filename=filename, mode="exec"
                )
            )
        images = _search_images(tmpdir)
        if images:
            for image in images:
                shutil.move(
                    image, Path(output_dir, output_base).with_suffix(image.suffix)
                )
        else:
            catch_display = _CatchDisplay()
            with catch_display:
                for node in to_eval:
                    exec(
                        compile(
                            ast.Interactive([node]), filename=filename, mode="single"
                        )
                    )
            Path(output_dir, output_base).with_suffix(".png").write_bytes(
                catch_display.output.data
            )
    os.chdir(cwd)
    return f"{output_base}.*"


def render_figure(code, code_dir, language, output_dir, output_base, config=None):
    """
    Run a GMT code and save the images in *output_dir* with file names
    derived from *output_base*.
    """
    # pylint: disable=too-many-arguments
    if language == "bash":
        figname = eval_bash(code, code_dir, output_dir, output_base, config=config)
    elif language == "python":
        figname = eval_python(code, code_dir, output_dir, output_base, config=config)
    return figname


def guess_language(filename):
    """
    Guess language from suffix of the script.
    """
    suffix = Path(filename).suffix
    if suffix in [".sh", ".bash"]:
        return "bash"
    if suffix == ".py":
        return "python"
    raise ValueError(f"Cannot guess language for file {filename}.")


def get_suffix_from_language(language):
    """
    Determine suffix from language.
    """
    if language == "bash":
        return "sh"
    if language == "python":
        return "py"
    raise ValueError(f"Unrecognized language {language}.")


class GMTPlotDirective(Directive):
    """
    The gmtplot directive implementation.
    """

    has_content = True
    required_arguments = 0
    optional_arguments = 1
    final_argument_whitespace = False

    # options for the literalinclude directive
    options_code = {
        "dedent": int,
        "linenos": directives.flag,
        "lineno-start": int,
        "lineno-match": directives.flag,
        "tab-width": int,
        "language": _option_language,
        "encoding": directives.encoding,
        "lines": directives.unchanged_required,
        "start-after": directives.unchanged_required,
        "end-before": directives.unchanged_required,
        "start-at": directives.unchanged_required,
        "end-at": directives.unchanged_required,
        "prepend": directives.unchanged_required,
        "append": directives.unchanged_required,
        "emphasize-lines": directives.unchanged_required,
        "name": directives.unchanged,
    }
    # options for the figure directive
    options_figure = {
        "alt": directives.unchanged,
        "height": directives.length_or_unitless,
        "width": directives.length_or_percentage_or_unitless,
        "scale": directives.nonnegative_int,
        "align": _option_align,
        "class": directives.class_option,
    }
    # options for the gmtplot directive
    option_spec = {
        "show-code": _option_boolean,
        "caption": directives.unchanged,
        **options_code,
        **options_figure,
    }

    def run(self):
        # pylint: disable=too-many-locals
        document = self.state_machine.document
        env = self.state_machine.document.settings.env
        config = self.state_machine.document.settings.env.config

        # set options to default values if not specified
        self.options.setdefault("show-code", config.gmtplot_show_code)
        self.options.setdefault("align", config.gmtplot_figure_align)

        # Get the name of the rst source file we are currently processing
        rst_file = Path(document["source"])
        # current working directory of the rst source file
        cwd = rst_file.parent

        if self.arguments:  # load codes from a file
            # Guess language from suffix of the script
            if "language" not in self.options:
                self.options["language"] = guess_language(self.arguments[0])

            # Get absolute path of the script
            if config.gmtplot_basedir:  # relative to gmtplot_basedir
                code_file = Path(
                    env.app.srcdir, config.gmtplot_basedir, self.arguments[0]
                )
            elif self.arguments[0].startswith("/"):  # relative to source directory
                code_file = Path(env.app.srcdir, self.arguments[0][1:])
            else:  # relative to current rst file's path
                code_file = Path(cwd, self.arguments[0])
            code_basedir = code_file.absolute().parent
            code = code_file.read_text(encoding="utf-8")
            # If there is content, it will be passed as a caption.
            caption = "\n".join(self.content)
        else:  # inline codes
            if "language" not in self.options:
                self.options["language"] = config.highlight_language
            code_basedir = cwd
            code = textwrap.dedent("\n".join(map(str, self.content)))
            caption = self.options["caption"] if "caption" in self.options else ""

        # use the md5sum value of the code as the basename of script and image files
        output_base = md5(code.encode()).hexdigest()

        # determine unique code filename under current working directory
        suffix = get_suffix_from_language(self.options["language"])
        code_file = Path(cwd, f"{output_base}.{suffix}")

        code_opts = ""
        if self.options["show-code"]:
            code_opts = []
            for key, val in self.options.items():
                if key == "linenos":
                    code_opts.append(f":{key}:")
                elif key in self.options_code:
                    code_opts.append(f":{key}: {val}")

        image_opts = [
            f":{key}: {val}"
            for key, val in self.options.items()
            if key in self.options_figure
        ]

        # builddir: where to place output files (temporarily)
        builddir = Path(env.app.doctreedir).parent / "gmtplot_directive"
        # determine how to link to files in builddir from the RST file
        # use os.path.relpath rather than relative_to!
        builddir_link = Path("/", os.path.relpath(str(builddir), env.app.srcdir))

        # copy script to builddir
        builddir.mkdir(parents=True, exist_ok=True)
        Path(builddir, code_file.name).write_text(code, encoding="utf-8")

        # make figures
        image = render_figure(
            code, code_basedir, self.options["language"], builddir, output_base, config
        )

        gmtplot_block = (
            jinja2.Template(TEMPLATE)
            .render(
                label="gmtplot-" + output_base,
                show_code=self.options["show-code"],
                code=builddir_link / code_file.name,
                code_opts=code_opts,
                image=builddir_link / image,
                image_opts=image_opts,
                caption=caption,
            )
            .split("\n")
        )
        gmtplot_block.extend("\n")
        self.state_machine.insert_input(gmtplot_block, source=str(rst_file))

        return []


def setup(app):
    """
    Add the gmtplot directive to the sphinx app.
    """
    setup.app = app
    setup.config = app.config
    setup.confdir = app.confdir

    app.add_directive("gmtplot", GMTPlotDirective)
    app.add_config_value("gmtplot_basedir", None, True)
    app.add_config_value("gmtplot_show_code", True, True)
    app.add_config_value("gmtplot_figure_align", "center", True)
    app.add_config_value("gmtplot_gmt_config", {"GMT_GRAPHICS_FORMAT": "ps"}, True)
    metadata = {
        "version": "0.3.0",
        "parallel_read_safe": True,
        "parallel_write_safe": True,
    }
    return metadata
