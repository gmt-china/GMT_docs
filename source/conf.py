#!/usr/bin/env python
# -*- coding: utf-8 -*-
# GMT 参考手册配置文件
#
# 1. http://www.sphinx-doc.org/en/stable/config.html
# 2. http://www.sphinx-doc.org/en/stable/latex.html

import os
import sys
import datetime
sys.path.insert(0, os.path.abspath('_extension'))

# -- General configuration ------------------------------------------------
needs_sphinx = '1.5.0'
source_suffix = '.rst'
source_encoding = 'utf-8-sig'
nitpicky = True
numfig = True
language = 'zh_CN'
today_fmt = u'%Y年%m月%d日'
exclude_patterns = []

highlight_language = 'bash'
pygments_style = 'sphinx'
show_authors = False
todo_include_todos = True

extensions = [
    'sphinx.ext.intersphinx',
    'sphinx.ext.todo',
    'sphinx.ext.mathjax',
    'sphinx.ext.ifconfig',
    'sphinx.ext.githubpages',
    'sphinx_cjkspace.cjkspace',
    'gmtsphinxext.gmtplot'
]
mathjax_path = 'https://cdn.bootcss.com/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML'

# -- Project configuration ------------------------------------------------
master_doc = 'index'
project = u'GMT参考手册'
copyright = '2014 - {}, GMT中文社区'.format(datetime.date.today().year)
author = u'GMT中文社区'
version = '5.4.5'
release = version
rst_prolog = '''
.. |GMT5_latest_release| replace:: 5.4.5
.. |GMT5_latest_release_date| replace:: 2019-01-04
'''

# -- Options for HTML output ----------------------------------------------
import sphinx_rtd_theme
html_theme = 'sphinx_rtd_theme'
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
templates_path = ['_templates']
html_title = project
html_logo = None
html_favicon = "_static/favicon.ico"
html_static_path = ['_static']
html_extra_path = ['CNAME']
html_last_updated_fmt = u'%Y年%m月%d日'
html_secnumber_suffix = ' '  # default is '.'
html_search_language = 'zh'
html_theme_options = {
    'prev_next_buttons_location': 'both',
}
html_context = {
    'display_github': True,
    'github_user': 'gmt-china',
    'github_repo': 'GMT_Docs',
    'github_version': 'master',
    'conf_py_path': '/source/',
    'theme_vcs_pageview_mode': 'blob',

    "menu_links": [
        (
            '<i class="fa fa-github fa-fw"></i> 源代码',
            "https://github.com/gmt-china/GMT_Docs",
        ),
        (
            '<i class="fa fa-book fa-fw"></i> 模块手册',
            "https://modules.gmt-china.org",
        ),
        (
            '<i class="fa fa-globe fa-fw"></i> GMT 中文社区',
            "https://gmt-china.org",
        ),
        (
            '<i class="fa fa-envelope fa-fw"></i> 联系我们',
            "mailto:admin@gmt-china.org",
        ),
    ],
}

# -- Options for LaTeX output ---------------------------------------------
latex_engine = "xelatex"
latex_documents = [
    (master_doc, 'GMT_docs.tex', "{} v{}".format(project, version), author, 'ctexbook'),
]
latex_logo = None
latex_toplevel_sectioning = 'chapter'
latex_additional_files = ['GMT_style.sty']
latex_elements = {
    'papersize' : 'a4paper',
    'pointsize' : '11pt',
    'extraclassoptions' : 'UTF8,twoside,punct=CCT',
    'preamble'  : r'\input{GMT_style.sty}',
    'figure_align' : 'H',
    'geometry'  : r'\usepackage[top=3.0cm, bottom=2.0cm, left=3.5cm, right=2.5cm]{geometry}',
    # customized tableofcontents
    'tableofcontents' : r'''\pdfbookmark[0]{\contentsname}{contents}
                            \tableofcontents
                            \cleardoublepage
                            \pdfbookmark[0]{\listfigurename}{lof}
                            \listoffigures
                            \cleardoublepage
                            \pdfbookmark[0]{\listtablename}{lot}
                            \listoftables
                            \cleardoublepage''',
    'passoptionstopackages': r'\PassOptionsToPackage{dvipsnames, svgnames}{xcolor}',
    'sphinxsetup': r'''VerbatimColor={named}{Lavender},
                       VerbatimBorderColor={named}{Silver},
                       ''',
    'fncychap'  : '',   # use default chapter style from ctex
    'babel'     : '',
    'polyglossia': '',
    'fontpkg'   : '',
    'cmappkg'   : '',
    'fontenc'   : '',
    'maketitle' : '\\maketitle',
}
