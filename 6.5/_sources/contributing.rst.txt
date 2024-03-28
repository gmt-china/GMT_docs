贡献指南
========

:撰写: |田冬冬|
:审核: |姚家园|
:最近更新日期: 2023-09-05

----

欢迎 GMT 中文用户参与到 GMT 中文手册的维护与更新中。

维护与更新
----------

文档的维护与更新主要包括几个方面：

- 修正错别字、语句不通等
- 修正文档中的错误或不清晰的描述
- 修正 reStructuredText 文件语法错误导致的显示问题
- 调整章节结构，使文档条理更清晰
- 翻译、整理更多模块的文档
- 增加示例与入门教程

可以通过如下两种方式参与文档的维护与更新：

1. 在 GitHub 上的文档源码仓库下提交 `Issue <https://github.com/gmt-china/GMT_docs/issues>`__
2. 修改文档源码并提交 `Pull Request <https://github.com/gmt-china/GMT_docs/pulls>`__
   （不熟悉 Pull Request 的读者可以参考 `Pull Request 流程 <https://seismo-learn.org/contributing/pull-request/>`__\ ）

文档风格
--------

文件风格
^^^^^^^^

1.  所有教程均采用 `reStructuredText <https://docutils.sourceforge.io/rst.html>`__
    语言编写，可参考 `reStructuredText Cheatsheet <https://docs.generic-mapping-tools.org/latest/devdocs/rst-cheatsheet.html>`__
    学习其常用语法。
2.  reStructuredText 文档的一级标题、二级标题和三级标题，分别用 ``=``、``-`` 和 ``^``
    符号标识
3.  所有 Bash 命令前应加上 Shell 提示符 ``$`` 以表示该命令为 Shell 命令
4.  中文字符与英文字符和数字之间应加上空格，如 ``中文 ABC 中文`` 而非 ``中文ABC中文``，
    ``中文 123 中文`` 而非 ``中文123中文``
5.  标点符号采用全角，如 ``，``、``。``、``：``、``、``、``？`` 等。
    标点符号与中文字符、英文字符以及数字之间不需加空格。
6.  使用 UTF8 编码和 Linux 换行符
7.  图片应在保证清晰度的前提下尽可能小

文件命名
^^^^^^^^

每个源文件都会被转换成一个单独的网页。因而，确定文件名时应慎重，一旦确定，尽量不要再改动。
由于 Windows 不区分文件名大小写，故而 :file:`option-B.rst` 和 :file:`option-b.rst`
在 Windows 下会出现冲突。我们使用的文件的命名规则是：

- 文件名一律采用小写字母
- 文件名应尽量使用单词全称，避免使用各种形式的简写
- 若文件名中含多个单词，应使用连字符 (hyphen) :kbd:`-` 连接

示例风格
^^^^^^^^

- 示例脚本尽量使用 Bash，非必须请勿使用 Perl、Python 等
- 所有脚本均使用 GMT 现代模式语法
- 所有脚本至少需要生成 PNG 格式的图片，建议使用 PNG、PDF 生成两种格式的图片，分别供网页版和 PDF 版使用
- 所有脚本以 ``gmt end show`` 结尾
- 示例中加入必要的注释，用于说明某个代码段、某个命令选项的功能及其他重要信息，
  但尽量使用简单英文，更复杂的说明应考虑写到正文中
- 若一行命令太长，可使用反斜杠换行，并且脚本的行数要尽量小
- 需要缩进时，应使用四个空格

文档使用 Sphinx 扩展 `sphinx_gmt <https://github.com/GenericMappingTools/sphinx_gmt>`__
提供的 ``gmtplot`` 指令自动执行脚本生成图片，同时将图片插入到文档中。该指令的常用选项有：

- ``width``： 图片在网页中的宽度（建议使用百分比表示，如 ``100%``）
- ``caption``：图片标题
- ``show-code``：表示是否显示代码（``true`` 或 ``false``）

该指令用法有两种：行内模式（直接在文档中写绘图代码）和脚本模式（将绘图代码写在脚本中）。

**行内模式**::

    .. gmtplot::
        :caption: 图片标题
        :width: 80%

        gmt begin map
        gmt basemap -JX10c/10c -R0/10/0/10 -Baf
        gmt end show

**脚本模式**::

    .. gmtplot:: /scripts/psmeca_ex1.sh
        :width: 80%

        图片标题

新增绘图实例
------------

社区绘图实例都位于 :file:`source/examples/` 目录下，每个文件夹包含一个实例，
从 :file:`ex001` 开始顺序编号。例如，实例 1 的文件夹为 :file:`source/examples/ex001/`，
该文件夹下需要包含如下信息：

1. 描述文件 :file:`index.rst`\ （必须）
2. Bash 绘图脚本，如 :file:`ex001.sh`\ （必须）
3. 绘图所需数据 :file:`xxx.dat` （可选，数据应尽量小）

简要描述绘图意义、所用核心模块的关键语法以及绘图必需的数据等。
新增实例时，请参考\ `文档风格`_\ 和已有的\ :doc:`社区绘图实例 </gallery/index>`。

添加图片到图库
--------------

为了将某个图片添加到\ :doc:`图库 </gallery/index>`\ 中，需要修改
:file:`source/gallery/gallery.yaml` 文件。
每个示例对应一个记录，每个记录的格式如下::

    - script: path/to/script.sh
      title: 绘制 GPS 速度场
      target: examples/ex015/

- ``script`` 指定了生成图片的脚本在 `source` 目录下的路径
- ``title`` 是显示在图片下方的标题
- ``target`` 是点击图片时要跳转的链接，可以是某个页面的路径，也可以是某个页面的锚点名称

构建文档
--------

本手册使用基于 Python 的文档生成工具 `Sphinx <http://www.sphinx-doc.org/>`__ 构建。
读者可以按照如下步骤在自己的计算机上构建得到 HTML 和 PDF 格式的文档。

1.  安装 `Anaconda <https://seismo-learn.org/software/anaconda/>`__
2.  下载文档源码

    ::

        $ git clone --depth=1 https://github.com/gmt-china/GMT_docs.git

3.  创建 conda 虚拟环境并安装构建文档所需的依赖

    ::

        $ cd GMT_docs
        $ conda env create -f environment.yml
        $ conda activate gmtdocs


4.  下载文档所需的地学数据并配置中文支持

    .. warning::

        执行以下脚本会修改 :file:`~/.gmt` 文件夹中的内容。
        执行脚本前请务必阅读脚本源码以了解该脚本具体做了什么。

    ::

        $ bash scripts/setup-ci.sh

5.  编译生成 HTML 格式的文档

    ::

        $ make html

    编译生成的 HTML 格式的文档 :file:`build/html/` 目录。
    直接用浏览器打开 :file:`build/html/index.html` 即可在本地预览。

6.  安装 LaTeX 相关软件

    构建 PDF 格式的文档需要安装 LaTeX 相关软件。用户可以选择安装
    `TeXLive <https://tug.org/texlive/>`__
    或者更轻量级的 `TinyTeX <https://yihui.org/tinytex/>`__\ 。

    安装完 TeXLive 或 TinyTex 后，还需要安装构建文档所需的 LaTeX 包::

        $ bash scripts/setup-latex.sh

7.  编译生成 PDF 格式的文档

    ::

        $ make latexpdf

    编译生成 PDF 格式的文档的路径为 :file:`build/latex/GMT_docs.pdf`
