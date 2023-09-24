import codecs
import csv
import json
import mimetypes
from collections import defaultdict

import defusedxml.ElementTree as ET
import yaml
from docutils import nodes
from docutils.parsers import rst
from docutils.statemachine import ViewList
from sphinx.jinja2glue import BuiltinTemplateLoader
from sphinx.util import logging
from sphinx.util.nodes import nested_parse_with_titles
from sphinxcontrib.datatemplates import helpers, loaders

LOG = logging.getLogger(__name__)
_default_templates = None


def _templates(builder):
    global _default_templates

    # Some builders have no templates manager at all, and some
    # have the attribute set to None.
    templates = getattr(builder, 'templates', None)

    if not templates:
        if not _default_templates:
            # Initialize default templates manager once
            _default_templates = BuiltinTemplateLoader()
            _default_templates.init(builder)

        templates = _default_templates

    return templates


def flag_true(argument):
    """
    Check for a valid flag option (no argument) and return ``True``.
    (Directive option conversion function.)
    Raise ``ValueError`` if an argument is found.
    """
    if argument and argument.strip():
        raise ValueError('no argument is allowed; "%s" supplied' % argument)
    else:
        return True


def unknown_option(argument):
    """
    Check for a valid flag option (no argument) and return ``True``,
    else return argument stripped.
    (Directive option conversion function.)

    For unknown options we cannot know if they should be
    passed to the loader as flags or strings.
    We could pass ``None`` if the option string contains nothing
    except whitespace but this would not be intuitive for
    keyword argument flags as ``bool(None) is False``.
    """
    if argument:
        stripped = argument.strip()
        if stripped:
            return stripped
    return True


def unchanged_factory():
    return unknown_option


class DataTemplateBase(rst.Directive):

    optional_arguments = 1
    final_argument_whitespace = True
    option_spec = defaultdict(unchanged_factory, {
        'source': rst.directives.path,
        'template': rst.directives.path,
    })
    has_content = True

    @staticmethod
    def loader():
        return NotImplemented

    def _make_context(self, data, config, env):
        return {
            'make_list_table': helpers.make_list_table,
            'make_list_table_from_mappings':
            helpers.make_list_table_from_mappings,
            'escape_rst': helpers.escape_rst,
            'escape_rst_url': helpers.escape_rst_url,
            'data': data,
            'config': config,
            'options': self.options,
            'env': env,
            'load': self._dynamic_load,
        }

    def _dynamic_load(self, source, data_format=None, **input_loader_options):
        # FIXME: This does not work for dbm or other databases because
        # the handle is closed.
        env = self.state.document.settings.env
        relative_resolved_path, absolute_resolved_path = env.relfn2path(source)
        # Only add a dependency if we were given an explicit
        # source. Otherwise, we end up adding a directory as a
        # dependency, which is illegal. See
        # https://github.com/sphinx-contrib/datatemplates/pull/83
        if source:
            env.note_dependency(absolute_resolved_path)

        if data_format is not None:
            loader = loaders.loader_by_name(data_format)
            if loader is None:
                raise ValueError('Could not find loader named {!r}'.format(
                    data_format))
        else:
            loader = loaders.loader_for_source(source, default=self.loader)

        loader_options = {
            "source": source,
            "relative_resolved_path": relative_resolved_path,
            "absolute_resolved_path": absolute_resolved_path,
        }

        if loader == self.loader:
            for k, v in self.options.items():
                # make identifier-compatible if trivially possible
                k = k.lower().replace(
                    "-", "_")
                loader_options.setdefault(k, v)  # do not overwrite

        loader_options.update(input_loader_options)

        with loader(**loader_options) as data:
            return data

    def run(self):
        env = self.state.document.settings.env
        app = env.app
        builder = app.builder

        if 'source' in self.options:
            source = self.options['source']
        elif self.arguments:
            source = self.arguments[0]
        else:
            source = ""

        relative_resolved_path, absolute_resolved_path = env.relfn2path(source)

        # Only add a dependency if we were given an explicit
        # source. Otherwise, we end up adding a directory as a
        # dependency, which is illegal. See
        # https://github.com/sphinx-contrib/datatemplates/pull/83
        if source:
            env.note_dependency(absolute_resolved_path)

        if 'template' in self.options:
            template = self.options['template']
            render_function = _templates(builder).render
        else:
            template = '\n'.join(self.content)
            render_function = _templates(builder).render_string

        loader_options = {
            "source": source,
            "relative_resolved_path": relative_resolved_path,
            "absolute_resolved_path": absolute_resolved_path,
        }
        for k, v in self.options.items():
            k = k.lower().replace(
                "-", "_")  # make identifier-compatible if trivially possible
            loader_options.setdefault(k, v)  # do not overwrite

        with self.loader(**loader_options) as data:
            context = self._make_context(data, app.config, env)
            rendered_template = render_function(
                template,
                context,
            )

        result = ViewList()
        for line in rendered_template.splitlines():
            result.append(line, source)
        node = nodes.section()
        node.document = self.state.document
        nested_parse_with_titles(self.state, result, node)
        return node.children

    @classmethod
    def usage(cls):
        _, sep, doc = cls.__doc__.partition(".. rst:directive::")
        return sep + doc


class DataTemplateWithEncoding(DataTemplateBase):
    option_spec = defaultdict(unchanged_factory, DataTemplateBase.option_spec,
                              **{
                                  'encoding': rst.directives.encoding,
                              })


class DataTemplateNoData(DataTemplateBase):
    """
    .. rst:directive:: .. datatemplate:nodata::

        Load ``None`` as ``data`` and render
        using ``template`` given in directive body.

        .. rst:directive:option:: template: template name, optional

            The name of a template file on the Sphinx template search path.
            Overrides directive body.
    """

    loader = staticmethod(loaders.load_nodata)


class DataTemplateJSON(DataTemplateWithEncoding):
    """
    .. rst:directive:: .. datatemplate:json:: source-path

        Load file at ``source-path`` (relative to the documentation
        build directory) via :py:func:`json.load` and render using
        ``template`` given in directive body.

        .. rst:directive:option:: template: template name, optional

            The name of a template file on the Sphinx template search path.
            Overrides directive body.

        .. rst:directive:option:: encoding: optional, defaults to ``utf-8-sig``

            The text encoding that will be used to read the source file.
            See :any:`standard-encodings`
    """

    loader = staticmethod(loaders.load_json)


def _handle_dialect_option(argument):
    return rst.directives.choice(argument, ["auto"] + csv.list_dialects())


class DataTemplateCSV(DataTemplateWithEncoding):
    """
    .. rst:directive:: .. datatemplate:csv:: source-path

        Load file at ``source-path`` (relative to the documentation
        build directory) via :py:func:`csv.reader` or
        :py:class:`csv.DictReader` depending on ``header``
        and render using ``template`` given in directive body.

        .. rst:directive:option:: template: template name, optional

            The name of a template file on the Sphinx template search path.
            Overrides directive body.

        .. rst:directive:option:: encoding: optional, defaults to ``utf-8-sig``

            The text encoding that will be used to read the source file.
            See :any:`standard-encodings`

        .. rst:directive:option:: header: flag, optional

                Set to use :py:class:`csv.DictReader` for reading the file.
                If not set :py:func:`csv.reader` is used.

        .. rst:directive:option:: dialect: optional

                Set to select a specific :py:class:`csv.Dialect`.
                Set to ``auto``, to try autodetection.
                If not set the default dialect is used.
    """

    option_spec = defaultdict(
        unchanged_factory, DataTemplateBase.option_spec, **{
            'headers': flag_true,
            'dialect': _handle_dialect_option,
        })

    loader = staticmethod(loaders.load_csv)


class DataTemplateYAML(DataTemplateWithEncoding):
    """
    .. rst:directive:: .. datatemplate:yaml:: source-path

        Load file at ``source-path`` (relative to the documentation build
        directory)  via PyYAML_ (:py:func:`yaml.safe_load`) and render
        using ``template`` given in directive body.

        .. _PyYAML: https://pyyaml.org

        .. rst:directive:option:: template: template name, optional

            The name of a template file on the Sphinx template search path.
            Overrides directive body.

        .. rst:directive:option:: encoding: optional, defaults to ``utf-8-sig``

            The text encoding that will be used to read the source file.
            See :any:`standard-encodings`

        .. rst:directive:option:: multiple-documents: flag, optional

            Set to read multiple documents from the file into
            a :py:class:`list`
    """

    option_spec = defaultdict(unchanged_factory, DataTemplateBase.option_spec,
                              **{
                                  'multiple-documents': flag_true,
                              })

    loader = staticmethod(loaders.load_yaml)


class DataTemplateXML(DataTemplateBase):
    """
    .. rst:directive:: .. datatemplate:xml:: source-path

        Load file at ``source-path`` (relative to the documentation
        build directory)  via :py:func:`xml.etree.ElementTree.parse`
        (actually using ``defusedxml``) and render using ``template``
        given in directive body.

        .. rst:directive:option:: template: template name, optional

            The name of a template file on the Sphinx template search path.
            Overrides directive body.
    """

    loader = staticmethod(loaders.load_xml)


class DataTemplateDBM(DataTemplateBase):
    """
    .. rst:directive:: datatemplate:dbm:: source-path

        Load DB at ``source-path`` (relative to the documentation
        build directory)  via :py:func:`dbm.open` and render using
        ``template`` given in directive body.

        .. rst:directive:option:: template: template name, optional

                The name of a template file on the Sphinx template search path.
                Overrides directive body.
    """

    loader = staticmethod(loaders.load_dbm)


class DataTemplateImportModule(DataTemplateBase):
    """
    .. rst:directive:: .. datatemplate:import-module:: module-name

        Load module ``module-name`` (must be importable in ``conf.py``)
        via :py:func:`importlib.import_module` and render using
        ``template`` given in directive body.

        .. rst:directive:option:: template: template name, optional

                The name of a template file on the Sphinx template search path.
                Overrides directive body.
    """

    loader = staticmethod(loaders.load_import_module)


class DataTemplateLegacy(rst.Directive):

    option_spec = {
        'source': rst.directives.path,
        'template': rst.directives.path,
        'csvheaders': rst.directives.flag,
        'csvdialect': _handle_dialect_option,
        'encoding': rst.directives.encoding,
    }
    has_content = False

    def _load_csv(self, filename, encoding):
        try:
            if encoding is None:
                f = open(filename, 'r', newline='')
            else:
                f = codecs.open(filename, 'r', newline='', encoding=encoding)
            dialect = self.options.get('csvdialect')
            if dialect == "auto":
                sample = f.read(8192)
                f.seek(0)
                sniffer = csv.Sniffer()
                dialect = sniffer.sniff(sample)
            if 'csvheaders' in self.options:
                if dialect is None:
                    r = csv.DictReader(f)
                else:
                    r = csv.DictReader(f, dialect=dialect)
            else:
                if dialect is None:
                    r = csv.reader(f)
                else:
                    r = csv.reader(f, dialect=dialect)
            return list(r)
        finally:
            f.close()

    def _load_json(self, filename, encoding):
        try:
            if encoding is None:
                f = open(filename, 'r')
            else:
                f = codecs.open(filename, 'r', encoding=encoding)
            return json.load(f)
        finally:
            f.close()

    def _load_yaml(self, filename, encoding):
        try:
            if encoding is None:
                f = open(filename, 'r')
            else:
                f = codecs.open(filename, 'r', encoding=encoding)
            return yaml.safe_load(f)
        finally:
            f.close()

    def _load_data(self, env, data_source, encoding):
        rel_filename, filename = env.relfn2path(data_source)
        if data_source.endswith('.yaml'):
            return self._load_yaml(filename, encoding)
        elif data_source.endswith('.json'):
            return self._load_json(filename, encoding)
        elif data_source.endswith('.csv'):
            return self._load_csv(filename, encoding)
        elif "xml" in mimetypes.guess_type(data_source)[0]:
            # there are many XML based formats
            return ET.parse(filename).getroot()
        else:
            raise NotImplementedError('cannot load file type of %s' %
                                      data_source)

    def run(self):
        env = self.state.document.settings.env
        app = env.app
        builder = app.builder

        try:
            data_source = self.options['source']
        except KeyError:
            error = self.state_machine.reporter.error(
                'No source set for datatemplate directive',
                nodes.literal_block(self.block_text, self.block_text),
                line=self.lineno)
            return [error]

        try:
            template_name = self.options['template']
        except KeyError:
            error = self.state_machine.reporter.error(
                'No template set for datatemplate directive',
                nodes.literal_block(self.block_text, self.block_text),
                line=self.lineno)
            return [error]

        encoding = self.options.get('encoding', None)

        data = self._load_data(env, data_source, encoding)

        context = {
            'make_list_table': helpers.make_list_table,
            'make_list_table_from_mappings':
            helpers.make_list_table_from_mappings,
            'data': data,
        }
        rendered_template = _templates(builder).render(
            template_name,
            context,
        )

        result = ViewList()
        for line in rendered_template.splitlines():
            result.append(line, data_source)
        node = nodes.section()
        node.document = self.state.document
        nested_parse_with_titles(self.state, result, node)
        return node.children
