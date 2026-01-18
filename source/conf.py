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
version = "6.6"
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
.. |何星辰| replace:: `何星辰 <https://github.com/Chuan1937>`__
"""

# -- General configuration ------------------------------------------------
needs_sphinx = "8.0"
source_suffix = {
    '.rst': 'restructuredtext',  # 遇到 .rst 用默认解析器
    '.md': 'markdown',           # 遇到 .md 用 MyST 解析器
}
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
    "gmtplot",  # _extensions/gmtplot.py
    "sphinxcontrib.datatemplates",
    "hide_options",  # _extensions/hide_options.py
]
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

html_theme = 'sphinx_rtd_theme'
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
    # 强制使用相对路径，避免绝对路径导致的根目录错位问题
    # 因为 gallery 页面在二级目录 (gallery/index.html)，所以用 ".." 回到根目录
    siteurl_for_gallery = ".."
    basedir_for_gallery = "./"
else:  # build locally
    # 修改说明：使用 ".." 表示上一级目录，这样路径会变成 "../_images/xxx.png"
    # 这允许在 build/html/gallery/index.html 中通过相对路径找到 build/html/_images/ 下的图片
    siteurl_for_gallery = ".."
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
        "何星辰": "https://github.com/Chuan1937",
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

import hashlib
import os
import requests
from PIL import Image
from io import BytesIO
from sphinx.jinja2glue import BuiltinTemplateLoader

def _filemd5(file):
    """
    计算文件内容的 MD5 hash (兼容 RTD 和本地路径)
    """
    # Sphinx 8.x 并行编译时，os.getcwd() 可能会变，所以最好用绝对路径
    # 1. 获取 conf.py 所在的目录 (通常是 source/)
    conf_dir = os.path.dirname(os.path.abspath(__file__))
    
    # 2. 获取项目根目录 (source/ 的上一级)
    project_root = os.path.dirname(conf_dir)
    
    # 3. 定义可能的搜索路径列表
    # 策略 A: 相对于项目根目录查找 (适用于 "source/proj/..." 这种情况)
    path_from_root = os.path.join(project_root, file)
    
    # 策略 B: 相对于 conf.py 目录查找 (适用于 "./proj/..." 这种情况，即 RTD 环境)
    # 注意：如果 file 是 "./xxx"，join 会自动处理
    path_from_conf = os.path.join(conf_dir, file)

    # 4. 依次尝试查找文件
    if os.path.exists(path_from_root) and os.path.isfile(path_from_root):
        target_file = path_from_root
    elif os.path.exists(path_from_conf) and os.path.isfile(path_from_conf):
        target_file = path_from_conf
    else:
        # 如果都找不到，打印警告（打印两个尝试过的路径，方便调试）
        print(f"[WARNING] filemd5 filter: Cannot find file.")
        print(f"  - Tried root base: {path_from_root}")
        print(f"  - Tried conf base: {path_from_conf}")
        return "file_not_found_placeholder"

    # 5. 计算 MD5
    try:
        with open(target_file, "r", encoding="utf-8") as fp:
            data = fp.read()
            return hashlib.md5(data.encode()).hexdigest()
    except Exception as e:
        print(f"[WARNING] filemd5 filter error reading {target_file}: {e}")
        return "error_placeholder"

# thumbnail 过滤器 (只处理网络图片)
def _create_thumbnail_filter(builder):
    def thumbnail_filter(url):
        # 1. 安全检查：如果没有输出目录，或者是本地路径，直接跳过
        if not hasattr(builder, 'outdir') or not url.startswith(("http:", "https:")):
            return url
            
        # 2. 目标目录: build/dirhtml/_static/thumbnails
        out_static_dir = os.path.join(builder.outdir, "_static", "thumbnails")
        os.makedirs(out_static_dir, exist_ok=True)
        
        # 3. 计算文件名 (URL 的 MD5)
        img_hash = hashlib.md5(url.encode()).hexdigest()
        thumb_filename = f"{img_hash}_thumb.jpg"
        thumb_abs_path = os.path.join(out_static_dir, thumb_filename)
        
        # 返回给 HTML 的相对路径
        rel_path_for_html = f"_static/thumbnails/{thumb_filename}"
        
        # 4. 缓存命中：如果文件已存在，直接返回
        if os.path.exists(thumb_abs_path):
            return rel_path_for_html

        # 5. 下载并生成
        try:
            # print(f"[INFO] Downloading: {url}")
            response = requests.get(url, timeout=15)
            response.raise_for_status() # 确保请求成功
            
            img = Image.open(BytesIO(response.content))
            if img:
                # JPG 不支持透明 (RGBA)，必须转 RGB，透明背景会变白
                if img.mode != 'RGB':
                    img = img.convert('RGB') 
                
                img.thumbnail((200, 200), Image.Resampling.LANCZOS)
                
                # 3. 指定 quality 参数 
                img.save(thumb_abs_path, "JPEG", quality=90)
                return rel_path_for_html

        except Exception as e:
            print(f"[WARNING] Download thumbnail failed: {url} | error: {e}")
            return url # 失败则回退到原始 URL

    return thumbnail_filter

# 注入过滤器
_orig_init = BuiltinTemplateLoader.init

def _patched_init(self, builder, theme=None):
    _orig_init(self, builder, theme)
    self.environment.filters['filemd5'] = _filemd5
    
    if builder.format in ('html', 'dirhtml'):
        self.environment.filters['thumbnail'] = _create_thumbnail_filter(builder)
    else:
        self.environment.filters['thumbnail'] = lambda x: x

BuiltinTemplateLoader.init = _patched_init