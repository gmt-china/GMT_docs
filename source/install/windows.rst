Windows 下安装 GMT
==================

GMT 为 Windows 用户提供了 32 位和 64位的安装包，可以直接下载安装使用。

.. warning::

    安装前请检查你的 Windows 登录用户名①是否包含空格、②是否为 **Administrator** 。
    以上两种情况都会导致 GMT 运行出错。如果你的用户名不符合要求，请新建一个用户，
    并使用新用户登录 Windows，再安装 GMT。

    此外，360 等安全软件会在 GMT 安装过程中拦截 PATH 环境变量的修改。
    请务必关闭安全软件之后再安装。

    GMT 提供的安装包不支持 Windows XP。

GMT 安装包中不仅包含了 GMT，还包含了运行 GMT 所需的如下软件：

- `GDAL <https://gdal.org/>`_\ ：用于多种地学数据格式的转换
- `FFmpeg <https://ffmpeg.org/>`_\ ：用于生成 mp4 或 webm 格式的动画
- `Ghostscript <https://www.ghostscript.com/>`_\ : 用于生成 PDF、JPG 等图片格式

安装 GMT
--------

下载 GMT
^^^^^^^^

- `gmt-6.2.0-win64.exe (64位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-win64.exe>`__
- `gmt-6.2.0-win32.exe (32位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-win32.exe>`__

安装 GMT
^^^^^^^^

双击安装包即可安装。请注意，GMT 安装包中内置的 Ghostscript **不支持** 中文。
若想要 GMT 支持中文，注意在安装 GMT 时 **不勾选** Ghostscript 组件，其他所有选项都勾选上。
待 GMT 安装完成后再按照下面的步骤与注意事项自行安装 Ghostscript。

如果不需要中文支持，则必须在 “Choose components” 页面，将所有选项都勾选上。

.. note::

    安装过程中可能会出现如下警告::

        Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.

    出现此警告的原因是系统的环境变量 **PATH** 太长，GMT 安装包无法直接修改。
    解决办法是，先忽略这一警告，待安装完成后按照如下步骤手动修改系统环境变量 **PATH**\ 。

    1.  点击“计算机”→“属性”→“高级系统设置”→“环境变量”打开“环境变量”编辑工具
    2.  在“系统变量”部分中，选中 “Path” 并点击“编辑”
    3.  在“变量值”的最后加上 GMT 的 :file:`bin` 目录的路径，例如 :file:`C:\\programs\\gmt6\\bin`\ 。
        需要注意 **PATH** 变量值中多个路径之间用英文分号分隔

测试安装
^^^^^^^^

安装完成后，点击“开始”→“所有程序”→“附件”→“命令提示符”以启动 cmd。
在 cmd 窗口中敲入 ``gmt --version``\ ，若出现 GMT 版本号则表示 GMT 安装成功。

升级 GMT
^^^^^^^^

GMT 目前不具备自动更新功能。如果想要升级新版本，通常需要先卸载旧版本。
卸载完成后，再下载并安装新版安装包以完成升级。

卸载 GMT
^^^^^^^^

若想要卸载 GMT，可以进入 GMT 安装目录，找到并双击执行 ``Uninstall.exe`` 即可完成卸载。
偶尔会遇到卸载不干净的情况，可以等卸载程序执行完成后再手动删除 GMT 安装目录即可。

安装可选软件
------------

为了更好地使用 GMT，你还可以根据自己的需求安装如下软件。

Visual Studio Code
^^^^^^^^^^^^^^^^^^

Visual Studio Code (VS Code)，是微软推出的一款免费、轻量且功能强大的编辑器。
VS Code 不仅支持一键执行、语法高亮、分屏显示，还可实现 Batch/Bash 脚本的丝滑切换运行、
实时预览 jpg/gif/pdf 等格式的图件、脚本报错信息显示。因此，非常适合全平台下执行 GMT 脚本。
    
安装配置教程请参阅： https://gmt-china.org/blog/vscode-usage/
    
.. warning::
    
    使用 VS Code 内置终端运行 Batch 绘图脚本时，\ **请一定要选择 CMD 终端，
    绝对不要使用 PowerShell **\ 。PowerShell 运行 Batch 绘图脚本会出现无法使用远程数据等错误。
    CMD 终端的切换方法在上面的安装配置教程中已有详细说明。

Git for Windows
^^^^^^^^^^^^^^^

**推荐需要在 Bash 下运行 GMT 的用户安装**\ 。

Git for Windows 为 Windows 用户提供了 Bash 以及 Linux 下常用的多个命令。
如果想要在 Windows 下运行 Bash 脚本，推荐安装 Git for Windows。

下载地址: https://git-scm.com/download/win

Ghostscript
^^^^^^^^^^^

**根据是否需要中文支持决定是否安装**\ 。

GMT 需要使用 Ghostscript 生成 PDF、JPG 等格式的图片，因而 Ghostscript 是必须的。
GMT 安装包中自带了 Ghostscript，但其并不支持在 GMT 图片中添加中文。

如果有在 GMT 图片中添加中文的需求，则需要在安装 GMT 时不安装 Ghostscript 组件，
然后自己再自行安装 Ghostscript。安装 Ghostscript 的过程中记得勾选
``Generate cidfmap for Windows CJK TrueType fonts`` 以生成中文字体配置文件。

中文支持的详细配置步骤请参阅《\ :doc:`/chinese/windows`\ 》。

安装包下载地址:

- `gs9540w64.exe (64位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w64.exe>`__
- `gs9540w32.exe (32位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w32.exe>`__

.. warning::

    请注意 Ghostscript 的版本！
    由于 Ghostscript 自身的 bug，请勿使用 9.27、9.51 和 9.52 版本的 Ghostscript。

GraphicsMagick
^^^^^^^^^^^^^^

**根据需求选择是否安装**\ 。

GMT 的 :doc:`gmt:movie` 模块在制作 GIF 格式的动画时需要
使用 `GraphicsMagick <http://www.graphicsmagick.org/>`_\ 。
如有制作 GIF 动画的需求，可以下载安装这个软件，并将其 :file:`bin` 目录加入到系统环境
变量 **PATH** 中，以保证 GMT 可以找到其提供的 ``gmt`` 命令。

UnixTools
^^^^^^^^^

GMT 中文手册的实例中使用到的 **gawk** 等 Linux 下的命令并不是 GMT 的一部分。
如果想要在 Windows 下使用各种 Linux 的常用命令，
推荐使用 GMT 中文社区整理的 Unix 小工具合集包 **UnixTools**\ ，其包含了如下程序：

- ``cat`` \：显示文件内容
- ``cut``\ ：从指定文本中截取文本并输出至标准输出
- ``gawk``\ ：处理文本信息的编程语言工具
- ``grep``\ ：从指定文本或标准输入中识别并截取出特定字段等
- ``head``\ ：输出一个或多个指定文本的前 n 行
- ``join``\ ：将两个文件中文本一致的行连接并输出
- ``md5sum``\ ：检验文本的 MD5 摘要
- ``paste``\ ：并排输出两个文件的内容
- ``printf``\ ：按 C 语言格式输出文本
- ``sed``\ ：文本处理工具
- ``sort``\ ：对文本文档进行排序
- ``split``\ ：以行为单位切割文件
- ``tail``\ ：显示文件尾端的 n 行数据
- ``uniq``\ ：从文本中去除或禁止重复行
- ``wc``\ ：输出指定文件的行数、字数和文本数据大小

下载 :download:`UnixTools.zip <https://gmt-china.org/data/UnixTools.zip>`，
然后将解压得到的 exe 文件移动到 GMT 的 :file:`bin` 目录即可。

以上 Unix 工具均提取自 `MS4W <https://www.ms4w.com/>`__\ 。
如果你发现某些工具存在问题，或者觉得有其他需要的 Unix 工具没有被包含进来，
请向我们反馈，我们会酌情考虑。

可以参考《\ `Linux 常用命令 <https://seismo-learn.org/seismology101/computer/commands/>`__\ 》
简易教程学习这些命令的基本用法。
