#!/usr/bin/env python
# -*- coding: utf-8 -*-
# GMT 中文手册配置文件
#
# 1. http://www.sphinx-doc.org/en/stable/config.html
# 2. http://www.sphinx-doc.org/en/stable/latex.html

import os
import sys
import datetime

# -- Project configuration ------------------------------------------------
master_doc = "index"
project = "GMT 中文手册"
author = "GMT 中文社区"
copyright = "2014–{}, {}".format(datetime.date.today().year, author)
github_user = "gmt-china"
github_repo = "GMT_docs"
github_url = f"https://github.com/{github_user}/{github_repo}"
version = "6.5"
release = version

# -- Contributor information ---------------------------------------------
rst_prolog = """
.. |田冬冬| replace:: `田冬冬 <https://me.seisman.info/>`__
.. |姚家园| replace:: `姚家园 <https://github.com/core-man>`__
.. |陈箫翰| replace:: `陈箫翰 <https://github.com/CovMat>`__
.. |刘珠妹| replace:: `刘珠妹 <https://github.com/liuzhumei>`__
.. |徐弥坚| replace:: `徐弥坚 <https://xumijian.me/>`__
.. |邓山泉| replace:: `邓山泉 <https://github.com/sqdeng/>`__
.. |周茂| replace:: `周茂 <https://github.com/ZMAlt>`__
.. |王亮| replace:: `王亮 <https://github.com/wangliang1989>`__
.. |朱邓达| replace:: `朱邓达 <https://github.com/Dengda98>`__
"""

# -- General configuration ------------------------------------------------
needs_sphinx = "2.4"
source_suffix = ".rst"
source_encoding = "utf-8-sig"
nitpicky = True
language = "zh_CN"
today_fmt = "%Y 年 %m 月 %d 日"
exclude_patterns = []

highlight_language = "bash"
pygments_style = "sphinx"
show_authors = True

sys.path.append(os.path.abspath("_extensions"))
extensions = [
    "myst_parser",
    "sphinx_rtd_theme",  # add the theme as an extension so that translation works
    "sphinx.ext.duration",
    "sphinx.ext.extlinks",
    "sphinx.ext.intersphinx",
    "sphinx.ext.mathjax",
    "sphinx_copybutton",
    "sphinx_design",
    "gmtplot",
    "sphinxcontrib.datatemplates",
]
# use custom templater bridge defined in _extensions/templatebridge.py
template_bridge = "templatebridge.MyTemplateBridge"
#mathjax_path = "https://cdn.bootcss.com/mathjax/2.7.7/MathJax.js?config=TeX-AMS-MML_HTMLorMML"

# Set smartquotes_action to "qe" to disable Smart Quotes transform of -- and ---
smartquotes_action = "qe"

# MyST configurations.
# Reference: https://myst-parser.readthedocs.io/en/latest/syntax/optional.html
myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "dollarmath",
    "fieldlist",
    "substitution",
]

myst_substitutions = {
    "田冬冬": "[田冬冬](https://me.seisman.info/)",
    "姚家园": "[姚家园](https://github.com/core-man)",
    "陈箫翰": "[陈箫翰](https://github.com/CovMat)",
    "刘珠妹": "[刘珠妹](https://github.com/liuzhumei)",
    "徐弥坚": "[徐弥坚](https://xumijian.me/)",
    "邓山泉": "[邓山泉](https://github.com/sqdeng/)",
    "周茂": "[周茂](https://github.com/ZMAlt)",
    "王亮": "[王亮](https://github.com/wangliang1989)",
    "朱邓达": "[朱邓达](https://github.com/Dengda98)",
}

# Cross-refering other projects
# https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
intersphinx_mapping = {
    "gmt": (f"https://docs.generic-mapping-tools.org/{version}/", None),
}

# Configure links to GMT docs
extlinks = {
    "gmt-docs": (f"https://docs.generic-mapping-tools.org/{version}/%s", None),
}

# options for sphinx-copybutton
# https://sphinx-copybutton.readthedocs.io
copybutton_prompt_text = r">>> |\.\.\. |\$ |In \[\d*\]: | {2,5}\.\.\.: | {5,8}: "
copybutton_prompt_is_regexp = True
copybutton_only_copy_prompt_lines = True
copybutton_remove_prompts = True

# -- Options for HTML output ----------------------------------------------
import sphinx_rtd_theme

html_theme = "sphinx_rtd_theme"
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_theme_options = {
    "prev_next_buttons_location": "bottom",
    "sticky_navigation": False,
}
html_css_files = ["custom.css"]
templates_path = ["_templates"]
html_static_path = ["_static"]
html_extra_path = []
html_last_updated_fmt = "%Y 年 %m 月 %d 日"
html_search_language = "zh"
html_title = project

# set site url of the image gallery for different use cases
if os.getenv("GITHUB_ACTIONS"):  # Build by GitHub Actions
    siteurl_for_gallery = f"https://docs.gmt-china.org/{version}"
    basedir_for_gallery = "source/"
elif os.getenv("READTHEDOCS"):  # Preview PRs powered by ReadTheDocs
    siteurl_for_gallery = os.getenv("READTHEDOCS_CANONICAL_URL")
    basedir_for_gallery = "./"
else:  # build locally
    siteurl_for_gallery = ""
    basedir_for_gallery = "source/"

html_context = {
    "favicon": "favicon.ico",
    "display_github": True,
    "github_user": github_user,
    "github_repo": github_repo,
    "github_version": "main",
    "conf_py_path": "/source/",
    "theme_vcs_pageview_mode": "edit",
    "metatags": '<meta name="msvalidate.01" content="C8D87DC3FFCED00C7F2FC8FD35051386" />',
    # Passed to sphinxcontrib.datatemplates
    "siteurl": siteurl_for_gallery,
    "basedir": basedir_for_gallery,
    # Enable version switch on GitHub Actions
    "enable_versions_switch": True if os.getenv("GITHUB_ACTIONS") else False,

    "menu_links": [
        (
            '<i class="fa fa-globe fa-fw"></i> GMT 中文社区',
            "https://gmt-china.org",
        ),
        (
            '<i class="fa fa-comments fa-fw"></i> 参与讨论',
            f"{github_url}/discussions",
        ),
    ],
    "contributors": {
        "田冬冬": "https://me.seisman.info/",
        "姚家园": "https://github.com/core-man",
        "陈箫翰": "https://github.com/CovMat",
        "刘珠妹": "https://github.com/liuzhumei",
        "徐弥坚": "https://xumijian.me/",
        "邓山泉": "https://github.com/sqdeng/",
        "周茂": "https://github.com/ZMAlt",
        "王亮": "https://github.com/wangliang1989",
        "朱邓达": "https://github.com/Dengda98",
    }
}

# See https://github.com/rtfd/sphinx_rtd_theme/issues/761
# Load custom stylesheets to support Algolia search.
# html_css_files = [
#  'algolia.css',
#  'https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.css'
# ]

# Load custom javascript to support Algolia search. Note that the sequence
# defined below (external first) is intentional!
# html_js_files = [
#  ('https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.js', {'defer': 'defer'}),
#  ('algolia.js', {'defer': 'defer'})
# ]

# -- Options for LaTeX output ---------------------------------------------
latex_engine = "xelatex"
latex_documents = [(master_doc, "GMT_docs.tex", project, author, "ctexbook")]
latex_logo = None
latex_toplevel_sectioning = "chapter"
latex_additional_files = ["GMT_style.sty"]
latex_elements = {
    "papersize": "b4paper",
    "pointsize": "12pt",
    "extraclassoptions": "UTF8,oneside,punct=CCT",
    "preamble": r"\input{GMT_style.sty}",
    "figure_align": "H",
    "geometry": r"\usepackage[top=3.0cm, bottom=2.5cm, left=2.5cm, right=2.5cm]{geometry}",
    # customized tableofcontents
    "tableofcontents" : r'''\pdfbookmark[0]{\contentsname}{contents}
                            \tableofcontents
                            \cleardoublepage
                            \pdfbookmark[0]{\listfigurename}{lof}
                            \listoffigures
                            \cleardoublepage
                            \pdfbookmark[0]{\listtablename}{lot}
                            \listoftables
                            \cleardoublepage''',
    "passoptionstopackages": r"\PassOptionsToPackage{dvipsnames, svgnames}{xcolor}",
    "sphinxsetup": r'''VerbatimColor = {named}{Lavender},
                       VerbatimBorderColor = {named}{Silver},
                       ''',
    "fncychap"  : "",  # use default chapter style from ctex
    "babel"     : "",
    "polyglossia": "",
    "fontpkg"   : "",
    "cmappkg"   : "",
    "fontenc"   : "",
    "maketitle" : "\\maketitle",
    "releasename": "v",  # the default is "Release" or "发布"
}
