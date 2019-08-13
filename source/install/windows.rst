Windows 下安装 GMT
==================

GMT 提供了 Windows 下的安装包，可以直接双击使用。

.. warning::

    从 GMT 5.2.1 开始，GMT 提供的安装包已经不再支持 Windows XP。

1.  下载 GMT 6.0.0rc3 安装包

    - `64位安装包 <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0rc3-win64.exe>`__
    - `32位安装包 <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.0.0rc3-win32.exe>`__

2.  安装GMT

    直接双击安装包即可安装，直接点击下一步，使用默认的选项即可，无须做任何修改。
    在“选择组件”页面，建议将四个选项都勾选上，然后点击下一步安装完成。

    .. note::

        安装过程中可能会出现如下警告::

            Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.

        出现此警告的原因是系统的环境变量 ``PATH`` 太长，GMT安装包无法直接修改。

        解决办法是，先忽略这一警告，待安装完成后按照如下步骤手动修改系统环境变量 ``PATH``\ 。

        1.  点击“计算机”->“属性”->“高级系统设置”->“环境变量”打开“环境变量”编辑工具
        2.  在“系统变量”部分中，选中“Path”并点击“编辑”
        3.  在“变量值”的最后加上GMT的bin目录的路径，默认值为 ``C:\programs\gmt6\bin``\ 。
            需要注意“path”变量值中多个路径之间用英文分号分隔

    安装完成后，“开始”->“所有程序”->“附件”->“命令提示符”以启动cmd。在cmd窗口中执行::

        C:\Users\xxxx> gmt --version
        6.0.0rc3

    即表示安装成功。

3.  安装ghostscript 9.26

    GMT需要使用 ghostscript 生成PDF、JPG等格式的图片，因而必须安装 ghostscript。

    - `64位安装包 <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw64.exe>`__
    - `32位安装包 <https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/gs926aw32.exe>`__

    .. warning::

        ghostscript 9.27存在严重bug，会导致生成的图片中有用信息被裁剪。
        请确保自己安装的不是 9.27 版本。

    安装过程很简单，双击安装即可。
    在最后一步，记得勾选 ``Generate cidfmap for Windows CJK TrueType fonts``\ 。

4.  安装GSview 5.0（可选）

    GSview是一个PostScript阅读器。GMT默认生成PDF格式的图片，如果需要生成并查看
    PS格式的图片，则需要安装GSview，否则无需安装。

    - `64位安装包 <http://www.ghostgum.com.au/download/gsv50w64.exe>`__
    - `32位安装包 <http://www.ghostgum.com.au/download/gsv50w32.exe>`__

    安装过程很简单，双击直接安装即可。

5.  安装 UnixTools （可选）

    `UnixTools.zip <https://gmt-china.org/data/UnixTools.zip>`__

    UnixTools是中文社区整理的Unix下小工具的合集。下载并解压，将解压得到的
    exe 文件移动到 GMT 的 bin 目录即可。

6.  安装生成动画所需的软件（可选）

    GMT在制作 gif 动画时需要使用 `GraphicsMagick <http://www.graphicsmagick.org/>`_\ ，
    在制作 MP4 动画视频时需要使用 `FFmpeg <https://ffmpeg.org/>`_\ 。

    如有制作动画的需求，请自行下载安装这两个软件，并将其bin目录加入到系统环境
    变量 ``PATH`` 中，以保证 GMT 可以找到其提供的 ``gm`` 和 ``ffmpeg`` 命令。
