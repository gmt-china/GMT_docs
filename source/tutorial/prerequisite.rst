准备工作
========

启动终端
--------

终端，即Terminal，是用户键入命令与电脑进行交互的接口。

**Linux用户**
    终端是Linux系统的标配，通常你可以在Application中直接找到它。
**macOS用户**
    使用“Command+空格”键启动Splitlight，在弹出的搜索框中输入“terminal”
    再按回车即可打开终端。
**Windows用户**
    默认终端是“命令提示符”，也就是 CMD。
    直接点击“开始”→“附件”→“命令提示符”即可启动cmd。
    也可以直接在开始按钮中的搜索框中搜索“cmd”并启动。

第一次运行GMT
-------------

在打开的终端中，敲入 ``gmt``\ ，你将看到GMT的欢迎界面信息，类似于::

        GMT - The Generic Mapping Tools, Version 6.0.0 [64-bit] [8 cores]
        (c) 1991-2019 The GMT Team (https://www.generic-mapping-tools.org/team.html).

    Supported in part by the US National Science Foundation (http://www.nsf.gov/)
    and volunteers from around the world.

    GMT is distributed under the GNU LGP License (http://www.gnu.org/licenses/lgpl.html).

    usage: gmt [options]
        gmt <module name> [<module-options>]

    options:
    --help            List descriptions of available GMT modules.
    --show-bindir     Show directory with GMT executables.
    --show-cores      Show number of available cores.
    --show-datadir    Show directory/ies with user data.
    --show-modules    Show all module names.
    --show-library    Show path of the shared GMT library.
    --show-plugindir  Show directory for plug-ins.
    --show-sharedir   Show directory for shared GMT resources.
    --version         Print GMT version number.

从中可以看到GMT的版本，请确保你所使用的GMT版本是与本手册的版本一致。

脚本及脚本语言
--------------

通常一张图都不是由一个命令就可以实现的，因而需要将绘图所需的一系列命令写到
一个文件中，这个文件即称为脚本或脚本文件。每个脚本都需要按照脚本语言所规定的
语法写成，并用脚本语言对应的解释器去执行。

Linux和macOS下最常用的脚本语言是Bash，而Windows自带的脚本语言则是BAT。
Windows用户可以使用BAT脚本语言，也可以安装 `git for Windows <https://git-scm.com/download>`
使用Bash脚本解释器。

不同脚本语言的语法规则不同，本教程中的示例将采用Bash作为脚本语言。本教程假定
用户对Bash或BAT语言有基本的了解。如果不了解，请阅读 `附录中的相关章节 </appendix/cmd>`_
以及网络上的相关教程。

文本编辑器
----------

要在脚本文件中写GMT命令，我们需要一个文本编辑器。每个操作系统都自带了文本编辑器，
Linux下通常是Gedit，Windows下有记事本，macOS也有自己的文本编辑器。除此之外，还有
很多流行的编辑器，如Notepad++、Vim、Emacs、Sublime Text、Atom等。

此处，推荐使用微软开发的 `Visual Stuidio Code <https://code.visualstudio.com/>`_\ 。
其具有如下特点：

#. 开源且跨平台
#. 开箱即用，学习成本低
#. 内置功能强大
#. 有丰富的官方插件和第三方插件，可扩展性高
#. 内置终端

写第一个脚本
------------

**Linux或macOS用户**

#.  打开文本编辑器并新建文件
#.  向文件中输入如下文本::

        #!/usr/bin/env bash
        echo "Hello World"

#.  将文件保存为脚本文件 :file:`hello.sh`
#.  打开终端，使用 ``cd`` 命令进入脚本所在目录
#.  执行如下命令，为脚本文件增加可执行权限::

        chmod +x hello.sh

#.  执行脚本::

        ./hello.sh

    你会看到终端输出 ``Hello world``\ 。

**Windows用户**

#.  打开文本编辑器并新建文件
#.  向文件中输入如下文本::

        echo "Hello world"
        pause

#.  将文件保存为脚本文件 :file:`hello.bat`
#.  打开终端，使用 ``cd`` 命令进入脚本所在目录，敲入命令 ``hello.bat``
    你会看到终端输出 ``Hello world``
#.  或者也可以使用文件管理器找到该脚本文件，然后双击执行
