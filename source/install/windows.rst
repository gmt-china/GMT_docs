Windows 下安装 GMT
==================

GMT 为 Windows 用户提供了 32 位和 64位的安装包，可以直接下载安装使用。

.. warning::

    安装前请检查你的Windows登录用户名①是否包含空格、②是否为 **Administrator** 。
    以上两种情况都会导致GMT运行出错。如果你的用户名不符合要求，请新建一个用户，
    并使用新用户登录Windows，再安装GMT。

    此外，360等安全软件会在GMT安装过程中拦截PATH环境变量的修改。请务必关闭安全软件之后再安装。

    GMT 提供的安装包不支持 Windows XP。

GMT 安装包中不仅包含了GMT，还包含了运行GMT所需的如下软件：

- `GDAL <https://gdal.org/>`_\ ：用于多种地学数据格式的转换
- `FFmpeg <https://ffmpeg.org/>`_\ ：用于生成 mp4 或 webm 格式的动画
- `Ghostscript <https://www.ghostscript.com/>`_\ : 用于生成PDF、JPG等图片格式

安装GMT
-------

1.  下载 GMT 安装包

    - `gmt-6.2.0-win64.exe (64位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-win64.exe>`__
    - `gmt-6.2.0-win32.exe (32位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.2.0-win32.exe>`__

2.  安装GMT

    双击安装包即可安装。请注意，GMT安装包中内置的 Ghostscript **不支持** 中文。
    若想要GMT支持中文，注意在安装GMT时 **不勾选** Ghostscript组件，其他所有选项都勾选上。
    待GMT安装完成后再按照下面的步骤与注意事项自行安装 Ghostscript。

    如果不需要中文支持，则必须在“Choose components”页面，将所有选项都勾选上。

    .. note::

        安装过程中可能会出现如下警告::

            Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.

        出现此警告的原因是系统的环境变量 **PATH** 太长，GMT安装包无法直接修改。
        解决办法是，先忽略这一警告，待安装完成后按照如下步骤手动修改系统环境变量 **PATH**\ 。

        1.  点击“计算机”→“属性”→“高级系统设置”→“环境变量”打开“环境变量”编辑工具
        2.  在“系统变量”部分中，选中“Path”并点击“编辑”
        3.  在“变量值”的最后加上GMT的bin目录的路径，例如 ``C:\programs\gmt6\bin``\ 。
            需要注意“path”变量值中多个路径之间用英文分号分隔

3.  测试安装是否正确

    安装完成后，点击“开始”→“所有程序”→“附件”→“命令提示符”以启动cmd。
    在cmd窗口中敲入 ``gmt --version``\ ，若出现GMT版本号则表示GMT安装成功。

4.  卸载GMT

    若想要卸载GMT，可以进入GMT安装目录，找到并双击执行 ``Uninstall.exe`` 即可完成卸载。
    偶尔会遇到卸载不干净的情况，可以等卸载程序执行完成后再手动删除GMT安装目录即可。

5.  升级GMT

    GMT目前不具备自动更新功能。如果想要升级新版本，通常需要先卸载旧版本。
    卸载完成后，再下载并安装新版安装包以完成升级。

安装其它可选软件
----------------

为了更好地使用GMT，你还可以根据自己的需求安装如下软件。

1.  安装 Git for Windows (**推荐需要在Bash下运行GMT的用户安装**)

    Git for Windows 为Windows用户提供了Bash以及Linux下常用的多个命令。
    如果想要在Windows下运行Bash脚本，推荐安装Git for Windows。

    下载地址: https://git-scm.com/download/win

2.  安装 Ghostscript (**根据是否需要中文支持决定是否安装**)

    GMT需要使用 Ghostscript 生成PDF、JPG等格式的图片，因而 Ghostscript 是必须的。
    GMT安装包中自带了Ghostscript，但其并不支持在GMT图片中添加中文。

    如果有在GMT图片中添加中文的需求，则需要在安装GMT时不安装Ghostscript组件，
    然后自己再自行安装 Ghostscript。安装 Ghostscript 的过程中记得勾选
    ``Generate cidfmap for Windows CJK TrueType fonts`` 以生成中文字体配置文件。

    中文支持的详细配置步骤请参阅《\ :doc:`/chinese/windows`\ 》。

    安装包下载地址:

    - `gs9540w64.exe (64位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w64.exe>`__
    - `gs9540w32.exe (32位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9540/gs9540w32.exe>`__

    .. warning::

        请注意 Ghostscript 的版本！
        由于Ghostscript自身的bug，请勿使用 9.27、9.51 和 9.52 版本的 Ghostscript。

3.  安装 GraphicsMagick (**根据需求选择是否安装**)

    GMT 的 **movie** 模块在制作 GIF 格式的动画时需要
    使用 `GraphicsMagick <http://www.graphicsmagick.org/>`_\ 。
    如有制作GIF动画的需求，可以下载安装这个软件，并将其 bin 目录加入到系统环境
    变量 **PATH** 中，以保证 GMT 可以找到其提供的 **gm** 命令。

4.  安装 UnixTools

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
