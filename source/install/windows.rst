Windows 下安装 GMT
==================

:撰写: |田冬冬|, |陈箫翰|, |姚家园|, |周茂|
:最近更新日期: 2023-09-13

----

GMT 为 Windows 用户提供了 32 位和 64 位安装包，可以直接下载安装使用。

.. warning::

    - 安装前请检查你的 Windows 登录用户名：（1）是否包含空格；
      （2）是否包含中文。以上两种情况都可能导致 GMT 运行出错。
      如果用户名不符合要求，请新建一个用户。然后使用新用户登录 Windows，再安装 GMT。
    - 360 等安全软件会在 GMT 安装过程中拦截 **PATH** 环境变量的修改。
      请务必关闭安全软件之后再安装。
    - GMT 提供的安装包不支持 Windows XP。

安装 GMT
--------

1.  下载 GMT 安装包

    - 64 位安装包：`gmt-6.4.0-win64.exe <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.4.0-win64.exe>`__
    - 32 位安装包：`gmt-6.4.0-win32.exe <http://mirrors.ustc.edu.cn/gmt/bin/gmt-6.4.0-win32.exe>`__

    GMT 安装包中不仅包含了 GMT，还包含了运行 GMT 所需的如下软件：

    - `GDAL <https://gdal.org/>`__：用于多种地学数据格式的转换
    - `FFmpeg <https://ffmpeg.org/>`__：用于生成 mp4 或 webm 格式的动画
    - `Ghostscript <https://www.ghostscript.com/>`__：用于生成 PDF、JPG 等图片格式

2.  安装 GMT

    双击安装包即可安装。在 “Choose components” 页面应勾选全部选项。

    .. note::

        安装过程中可能会出现如下警告::

            Warning! Failed to add GMT to PATH. Please add the GMT bin path to PATH manually.

        出现此警告的原因是系统的环境变量 **PATH** 太长，GMT 安装包无法直接修改。
        解决办法是，先忽略这一警告，待安装完成后按照如下步骤手动修改系统环境变量 **PATH**。

        1.  点击“计算机”→“属性”→“高级系统设置”→“环境变量”打开“环境变量”编辑工具
        2.  在“系统变量”部分中，选中 “Path” 并点击“编辑”
        3.  在“变量值”的最后加上 GMT 安装目录下的 :file:`bin` 目录的路径，
            如 :file:`C:\\programs\\gmt6\\bin`。需要注意 **PATH** 变量值中多个路径之间用英文分号分隔

3.  测试安装

    安装完成后，点击“开始”→“所有程序”→“附件”→“命令提示符”以启动 CMD。
    在 CMD 窗口中敲入 ``gmt --version``，若出现 GMT 版本号则表示 GMT 安装成功。

4.  升级 GMT

    GMT 目前不具备自动更新功能。如果想要升级新版本，通常需要先卸载旧版本。
    卸载完成后，再下载并安装新版安装包以完成升级。

5.  卸载 GMT

    若想要卸载 GMT，可以进入系统的设置 -> 应用，或控制面板 -> 卸载程序进行卸载。
    偶尔会遇到卸载不干净的情况，可以等卸载程序执行完成后再手动删除 GMT 安装目录即可。

安装可选软件
------------

为了更好地使用 GMT，用户可以根据自己的实际需求选择安装如下软件。

GraphicsMagick
^^^^^^^^^^^^^^

GMT 的 :doc:`gmt:movie` 模块在制作 GIF 格式的动画时需要使用
`GraphicsMagick <http://www.graphicsmagick.org/>`__。
如需制作 GIF 动画，可以安装这个软件，并将其 :file:`bin` 目录加入到系统环境变量 **PATH** 中，
以保证 GMT 可以找到其提供的 ``gm`` 命令。
