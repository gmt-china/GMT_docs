#!/usr/bin/env python
# -*- coding: utf-8 -*-
# GMT 中文手册配置文件
#
# 1. http://www.sphinx-doc.org/en/stable/config.html
# 2. http://www.sphinx-doc.org/en/stable/latex.html

import os
import datetime

# -- Project configuration ------------------------------------------------
master_doc = "index"
project = "GMT中文手册"
author = "GMT中文社区"
copyright = "2014-{}, {}".format(datetime.date.today().year, author)
github_user = "gmt-china"
github_repo = "GMT_docs"
github_url = f"https://github.com/{github_user}/{github_repo}"
version = "6.2"
release = version

# -- Contributor information ---------------------------------------------
rst_prolog = """
.. |田冬冬| replace:: `田冬冬 <https://me.seisman.info/>`__
.. |姚家园| replace:: `姚家园 <https://github.com/core-man>`__
.. |陈箫翰| replace:: `陈箫翰 <https://github.com/CovMat>`__
.. |刘珠妹| replace:: `刘珠妹 <https://github.com/liuzhumei>`__
.. |徐弥坚| replace:: `徐弥坚 <https://xumijian.me/>`__
.. |邓山泉| replace:: `邓山泉 <https://github.com/sqdeng/>`__
"""

# -- General configuration ------------------------------------------------
needs_sphinx = "2.4"
source_suffix = ".rst"
source_encoding = "utf-8-sig"
nitpicky = True
language = "zh_CN"
today_fmt = "%Y年%m月%d日"
exclude_patterns = []

highlight_language = "bash"
pygments_style = "sphinx"
show_authors = True

extensions = [
    "sphinx.ext.duration",
    "sphinx.ext.intersphinx",
    "sphinx.ext.mathjax",
    "sphinx_cjkspace.cjkspace",
    "sphinx_copybutton",
    "sphinx_gmt.gmtplot",
]
mathjax_path = "https://cdn.bootcss.com/mathjax/2.7.7/MathJax.js?config=TeX-AMS-MML_HTMLorMML"

# Set smartquotes_action to "qe" to disable Smart Quotes transform of -- and ---
smartquotes_action = "qe"

# Cross-refering other projects
# https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html
intersphinx_mapping = {
    "gmt": ("https://docs.generic-mapping-tools.org/6.2/", None),
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
templates_path = ["_templates"]
html_title = project
html_logo = None
html_favicon = "favicon.ico"
html_static_path = ["_static"]
html_extra_path = ["CNAME"]
html_last_updated_fmt = "%Y年%m月%d日"
html_search_language = "zh"
html_theme_options = {
    "prev_next_buttons_location": "bottom",
    "sticky_navigation": False,
}
html_context = {
    "display_github": True,
    "github_user": github_user,
    "github_repo": github_repo,
    "github_version": "master",
    "conf_py_path": "/source/",
    "theme_vcs_pageview_mode": "blob",
    "metatags": '<meta name="msvalidate.01" content="C8D87DC3FFCED00C7F2FC8FD35051386" />',
    # Enable version switch on GitHub Actions
    "enable_versions_switch": True if os.getenv("GITHUB_ACTIONS") else False,

    "menu_links": [
        (
            '<i class="fa fa-globe fa-fw"></i> GMT 中文社区',
            "https://gmt-china.org",
        ),
        (
            '<i class="fa fa-github fa-fw"></i> 手册源码',
            github_url,
        ),
        (
            '<i class="fa fa-book fa-fw"></i> 手册 PDF',
            "https://docs.gmt-china.org/{}/GMT_docs.pdf".format(version),
        ),
        (
            '<i class="fa fa-comments fa-fw"></i> 参与讨论',
            f"{github_url}/discussions",
        ),
    ],
}

html_css_files = [
    "custom.css",
]

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
latex_documents = [
    (master_doc, "GMT_docs.tex", project, author, "ctexbook"),
]
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
