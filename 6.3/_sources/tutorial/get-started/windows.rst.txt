GMT 初探: Windows 篇
====================

启动 CMD 命令行
---------------

GMT 是一个纯命令行软件，没有任何的图形界面。所有的绘图操作都需要通过
在终端和脚本中执行命令来完成。Windows 下的默认终端是 “命令提示符”，
也就是 CMD 命令行。

点击 “开始”→“附件”→“命令提示符” 即可启动 CMD，
也可以直接在开始按钮中的搜索框中搜索 “CMD” 并启动。

运行 GMT
--------

启动 CMD 后，敲入 ``gmt`` 以执行 GMT 命令。你将看到 GMT 的欢迎界面信息，类似于：

.. code-block:: console

            GMT - The Generic Mapping Tools, Version 6.3.0 [64-bit] [8 cores]
            (c) 1991-2021 The GMT Team (https://www.generic-mapping-tools.org/team.html).

            Supported in part by the US National Science Foundation (http://www.nsf.gov/)
            and volunteers from around the world.

            GMT is distributed under the GNU LGPL License (http://www.gnu.org/licenses/lgpl.html).
            Dependencies: netCDF, GDAL, PCRE, FFTW, LAPACK, ZLIB, Ghostscript, GraphicsMagick, FFmpeg.

    usage: gmt [options]
           gmt <module name> [<module-options>]

    options:
      --help              List descriptions of available GMT modules.
      --new-script[=L]    Write GMT modern mode script template to stdout.
                          Optionally specify bash|csh|batch [Default is current shell].
      --new-glue=name     Write C code for external supplements to glue them to GMT.
      --show-bindir       Show directory with GMT executables.
      --show-citation     Show the most recent citation for GMT.
      --show-classic      Show all classic module names.
      --show-classic-core Show all classic module names (core only).
      --show-cores        Show number of available cores.
      --show-datadir      Show directory/ies with user data.
      --show-dataserver   Show URL of the remote GMT data server.
      --show-doi          Show the DOI for the current release.
      --show-library      Show path of the shared GMT library.
      --show-modules      Show all modern module names.
      --show-modules-core Show all modern module names (core only).
      --show-plugindir    Show directory for plug-ins.
      --show-sharedir     Show directory for shared GMT resources.
      --show-userdir      Show full path of user's ~/.gmt dir
      --version           Print GMT version number.

    if <module-options> is '=' we call exit (0) if module exist and non-zero otherwise.

生成脚本模板
------------

继续在终端中敲入::

    gmt --new-script > myplot.bat

该命令会在当前目录生成一个 GMT 模板脚本，并保存到 Batch 脚本文件 :file:`myplot.bat` 中。

.. note::

    Batch 是 Windows 自带的脚本语言，但本教程中所有示例均使用 Unix 下常用的 Bash 脚本。
    因而 Windows 用户有两种选择：

    #. 安装 `Git for Windows <https://git-scm.com/download/win>`_ 并使用其提供的
       Bash，本手册中的所有命令都将可以直接使用。要求读者对 Bash 脚本及 Unix 命令行有最基本的了解。
       不了解的用户请阅读网络上 Bash 相关教程，或本手册中 :doc:`/tutorial/scripting/index` 一节。
    #. 继续使用 Windows 的 Batch 脚本。要求读者对 Batch 脚本和 Bash 脚本均有所了解，并
       知道二者用法的差异，以便于将手册中的 Bash 脚本转换为 Batch 脚本。
       不了解的用户请阅读网络上 Bash 和 Batch 相关教程，或本手册中
       :doc:`/tutorial/scripting/index` 一节。

查看并编辑脚本文件
------------------

Batch 脚本文件是一个纯文本文件，可以直接用文本编辑器打开。例如，Windows 下自带的记事本
即可打开该脚本文件。

打开脚本文件后会看到如下内容::

    REM GMT modern mode batch template
    REM Date:    2019-09-02T23:34:25
    REM User:    seisman
    REM Purpose: Purpose of this script
    REM Set a unique session name:
    @echo off
    set GMT_SESSION_NAME=7492
    gmt begin figurename
        REM Place modern session commands here
    gmt end show

其中，以 **REM** 开头的行尾注释行，**set GMT_SESSION_NAME=7492** 这一行属于
高级用法，可以忽略。核心内容只有两行，即 **gmt begin** 和 **gmt end** 这两行。

编辑脚本，在 **gmt begin** 和 **gmt end** 中间添加 GMT 命令，将脚本修改如下::

    REM GMT modern mode batch template
    REM Date:    2019-09-02T23:34:25
    REM User:    seisman
    REM Purpose: Purpose of this script
    REM Set a unique session name:
    @echo off
    set GMT_SESSION_NAME=7492
    gmt begin figurename
        gmt coast -Rg -JH15c -Gpurple -Baf -B+t"My First Plot"
    gmt end show

编辑完成后记得保存文件。

执行脚本以绘图
--------------

回到 CMD，直接输入 Batch 脚本名以运行该脚本::

    myplot.bat

待脚本执行完成后，会自动用 PDF 阅读器打开生成的 PDF 格式的图片文件。
你将看到如下图所示的图片。

.. gmtplot::
    :width: 75%
    :show-code: false

    #!/usr/bin/env bash
    # GMT modern mode bash template
    # Date:    2019-09-10T00:44:39
    # User:    seisman
    # Purpose: Purpose of this script
    export GMT_SESSION_NAME=$$	# Set a unique session name
    gmt begin figurename
        gmt coast -Rg -JH15c -Gpurple -Baf -B+t"My First Plot"
    gmt end show

这基本上就是运行 GMT 脚本的基本流程，即：

- 生成脚本模板
- 编辑脚本，添加 GMT 绘图命令
- 运行脚本并查看绘图效果
