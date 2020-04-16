Windows 下安装 GMT
==================

GMT 提供了 Windows 下的安装包，可以直接安装使用。

.. warning::

    从 GMT 5.2.1 开始，GMT 提供的安装包已经不再支持 Windows XP。

GMT 6.0.0 安装包中不仅包含了GMT，还包含了运行GMT所需的如下软件：

- `GDAL <https://gdal.org/>`_\ ：用于多种地学数据格式的转换
- `FFmpeg <https://ffmpeg.org/>`_\ ：用于生成MP4格式的动画
- `Ghostscript <https://www.ghostscript.com/>`_\ : 用于生成PDF、JPG等图片格式

安装GMT
-------

1.  下载 GMT 6.0.0 安装包

    - `gmt-6.0.0-win64.exe (64位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0-win64.exe>`__
    - `gmt-6.0.0-win32.exe (32位) <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0-win32.exe>`__

2.  安装GMT

    双击安装包即可安装。在“Choose components”页面，建议将所有选项都勾选上。

    .. note::

       GMT安装包中内置了Ghostscript 9.50，但其不支持中文。
       若想要GMT支持中文，则需要在安装GMT时不选择Ghostscript组件，
       待GMT安装完成后再自行安装 Ghostscript。

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
    在cmd窗口中执行::

        C:\Users\xxxx> gmt --version
        6.0.0

    即表示安装成功。

4.  卸载GMT

    若想要卸载GMT，可以进入GMT安装目录，找到并双击执行 ``Uninstall.exe`` 即可完成卸载。
    偶尔会遇到卸载不干净的情况，可以等卸载程序执行完成后再手动删除GMT安装目录即可。

5.  升级GMT

    GMT目前不具备自动更新功能。如果想要升级新版本，通常需要先卸载旧版本。
    卸载完成后，再下载并安装新版安装包以完成升级。

安装其它可选软件
----------------

为了更好地使用GMT，你还可以根据自己的需求安装如下软件。

1.  安装 Git for Windows (**推荐**)

    Git for Windows 为Windows用户提供了Bash以及Linux下常用的多个命令。
    如果想要在Windows下运行Bash脚本，推荐安装Git for Windows。

    下载地址: https://git-scm.com/download/win

2.  安装 GraphicsMagick (**根据需求选择是否安装**)

    GMT 的 **movie** 模块在制作 GIF 格式的动画时需要
    使用 `GraphicsMagick <http://www.graphicsmagick.org/>`_\ 。
    如有制作GIF动画的需求，可以下载安装这个软件，并将其 bin 目录加入到系统环境
    变量 **PATH** 中，以保证 GMT 可以找到其提供的 **gm** 命令。

3.  安装 Ghostscript (**根据是否需要中文支持决定是否安装**)

    GMT需要使用 Ghostscript 生成PDF、JPG等格式的图片，因而 Ghostscript 是必须的。
    GMT安装包中自带了Ghostscript，但是其并不支持在GMT图片中添加中文。

    如果有在GMT图片中添加中文的需求，则需要在安装GMT时不安装Ghostscript组件，
    然后自己再自行安装 Ghostscript。安装 Ghostscript 的过程中记得勾选
    ``Generate cidfmap for Windows CJK TrueType fonts`` 以生成中文字体配置文件。

    安装包下载地址:

    - `gs926aw64.exe (64位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw64.exe>`__
    - `gs926aw32.exe (32位) <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw32.exe>`__

    .. warning::

        请注意 Ghostscript 的版本！

        由于Ghostscript的bug和兼容性问题，Windows下 GMT 6.0.0 建议与 ghostscript 9.26
        搭配使用。

4.  安装GSview 5.0 (**不推荐**)

    GSview是一个PostScript阅读器。GMT6默认生成PDF格式的图片，因而无需安装GSview。
    如果坚持想要生成并查看PS格式的图片，则可以安装GSview。

    - `gsv50w64.exe (64位) <http://www.ghostgum.com.au/download/gsv50w64.exe>`__
    - `gsv50w32.exe (32位) <http://www.ghostgum.com.au/download/gsv50w32.exe>`__

5.  安装 UnixTools (**不推荐**)

    如果想要在Windows下运行Batch脚本，但同时想要使用各种Linux下的常用命令，
    则可以使用GMT中文社区整理的Unix小工具合集包 UnixTools。

    直接下载并解压，将解压得到的 exe 文件移动到 GMT 的 bin 目录即可。

    下载地址: `UnixTools.zip <https://gmt-china.org/data/UnixTools.zip>`__
