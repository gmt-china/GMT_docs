Linux 下的 GMT 中文支持
=======================

本文介绍如何让 GMT 在 Linux 下支持中文。

ghostscript的中文支持
---------------------

Linux 的中文字体较少，这里使用 Windows 下提供的四个基本字体：宋体、仿宋、黑体和楷体。
对于 Windows 下的其他中文字体、Linux 的其他中文字体甚至日韩字体来说，方法类似。

可以使用 `cjk-gs-support <https://github.com/texjporg/cjk-gs-support>`_
项目提供的脚本 `cjk-gs-integrate.pl`_ 来实现ghostscript的中文支持。

1.  从Windows下获取四种基本字体的字体文件（文件名类似于 ``simsun.ttc``\ ）并复制到
    ``/usr/share/fonts/winfonts/`` 目录下
2.  下载脚本 `cjk-gs-integrate.pl`_
3.  ``cjk-gs-integrate.pl`` 脚本的执行依赖于命令 ``kpsewhich``\ ，该命令由 TeXLive 提供。
    执行 ``kpsewhich --version`` 检查 ``kpsewhich`` 这个命令是否存在。若不存在，则
    需要单独安装。

    对于Ubuntu/Debian用户，执行::

        sudo apt-get install texlive-binaries

    对于CentOS/RHEL/Fedora用户，执行::

        sudo yum install texlive-kpathsea-bin

4.  执行脚本::

        $ sudo perl cjk-gs-integrate.pl

    该脚本会自动搜索系统中自带的中文字体，并生成gs支持中文所需的配置文件。

.. _cjk-gs-integrate.pl: https://raw.githubusercontent.com/texjporg/cjk-gs-support/master/cjk-gs-integrate.pl

GMT的中文支持
-------------

在 ``~/.gmt``\ （若无该文件夹，请自行新建）下创建字体配置文件::

    $ touch ~/.gmt/PSL_custom_fonts.txt
    $ open ~/.gmt/PSL_custom_fonts.txt

打开 GMT 字体配置文件，在文件中加入如下语句::

    STSong-Light-UniGB-UTF8-H  0.700    1
    STFangsong-Light-UniGB-UTF8-H  0.700    1
    STHeiti-Regular-UniGB-UTF8-H   0.700   1
    STKaiti-Regular-UniGB-UTF8-H   0.700   1
    STSong-Light-UniGB-UTF8-V  0.700    1
    STFangsong-Light-UniGB-UTF8-V  0.700    1
    STHeiti-Regular-UniGB-UTF8-V   0.700   1
    STKaiti-Regular-UniGB-UTF8-V   0.700   1

这几句话分别添加了宋体、仿宋、黑体和楷体四种字体的横排和竖排两种方式。

用 ``gmt pstext -L`` 命令查看 GMT 当前的字体配置::

    $ gmt pstext -L
    Font #  Font Name
    ------------------------------------
    0   Helvetica
    1   Helvetica-Bold
    ...    ......
    39 STSong-Light-UniGB-UTF8-H
    40 STFangsong-Light-UniGB-UTF8-H
    41 STHeiti-Regular-UniGB-UTF8-H
    42 STKaiti-Regular-UniGB-UTF8-H
    43 STSong-Light-UniGB-UTF8-V
    44 STFangsong-Light-UniGB-UTF8-V
    45 STHeiti-Regular-UniGB-UTF8-V
    46 STKaiti-Regular-UniGB-UTF8-V

其中 39-46 号字体为新添加的中文字体。
以后要用中文字体时，需要用这些编号来指定字体，也许你的机器上的编号和这里不同。

GMT 中文测试
------------

.. note::

   请自行确认你的中文字体编号。如果编号不是39到46，请自行修改以下测试脚本。

.. literalinclude:: GMT_Chinese.sh

成图效果如下：

.. figure:: GMT_Chinese.*
   :width: 100%
   :align: center
