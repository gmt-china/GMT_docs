#!/usr/bin/env python
# -*- coding: utf-8 -*-
# GMT 参考手册配置文件
#
# 1. http://www.sphinx-doc.org/en/stable/config.html
# 2. http://www.sphinx-doc.org/en/stable/latex.html

import os
import sys
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
]
mathjax_path = 'http://cdn.bootcss.com/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML'

# -- Project configuration ------------------------------------------------
master_doc = 'index'
project = u'GMT参考手册'
copyright = u'2014-2017, GMT中文社区'
author = u'GMT中文社区'
version = '5.4.2'
release = version
rst_prolog = '''
.. |GMT4_latest_release| replace:: 4.5.16
.. |GMT4_latest_release_date| replace:: 2017-06-25
.. |GMT5_latest_release| replace:: 5.4.2
.. |GMT5_latest_release_date| replace:: 2017-06-25
'''

# -- Options for HTML output ----------------------------------------------
import sphinx_rtd_theme
html_theme = 'sphinx_rtd_theme'
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
templates_path = ['_templates']
html_title = project
html_logo = None
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
}

# -- Options for LaTeX output ---------------------------------------------
latex_engine = "xelatex"
latex_documents = [
    (master_doc, 'GMT_docs.tex', project, author, 'gmt-docs'),
]
latex_logo = None
latex_toplevel_sectioning = 'chapter'
latex_show_urls = 'no'
latex_additional_files = ['gmt-docs.cls']
latex_elements = {
        'papersize'  : 'a4paper',
        'utf8extra'  : '',
        'inputenc'   : '',
        'cmappkg'    : '',
        'fontenc'    : '',
        'releasename': '',
        'babel'      : '',
        'figure_align': 'htp',
        'fontpkg'    : '',
        'fncychap'   : '',
        'preamble'   : '',
}
