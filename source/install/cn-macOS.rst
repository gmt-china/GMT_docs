macOS 下的 GMT 中文支持
=======================

本文介绍如何让 GMT 在 macOS 下支持中文。

使 gs 支持中文
--------------

首先需要使 gs 支持中文，这可以通过
`cjk-gs-support <https://github.com/texjporg/cjk-gs-support>`_ 项目提供的脚本
`cjk-gs-integrate.pl`_ 实现。

1. 下载脚本 `cjk-gs-integrate.pl`_
2. 执行脚本::

    $ sudo perl cjk-gs-integrate.pl

   该脚本会自动搜索系统中自带的中文字体，并生成gs支持中文所需的配置文件。

.. _cjk-gs-integrate.pl: https://raw.githubusercontent.com/texjporg/cjk-gs-support/master/cjk-gs-integrate.pl

使 GMT 支持中文
---------------

修改 GMT 字体配置文件
+++++++++++++++++++++

在 ``~/.gmt``\ （若无该文件夹，请自行新建）下创建字体配置文件::

    $ touch ~/.gmt/PSL_custom_fonts.txt
    $ open ~/.gmt/PSL_custom_fonts.txt

打开 GMT 字体配置文件，在文件中加入如下语句::

    STSong-Light--UniGB-UTF8-H  0.700    1
    STFangsong-Light--UniGB-UTF8-H  0.700    1
    STHeiti-Regular--UniGB-UTF8-H   0.700   1
    STKaiti-Regular--UniGB-UTF8-H   0.700   1
    STSong-Light--UniGB-UTF8-V  0.700    1
    STFangsong-Light--UniGB-UTF8-V  0.700    1
    STHeiti-Regular--UniGB-UTF8-V   0.700   1
    STKaiti-Regular--UniGB-UTF8-V   0.700   1

这几句话分别添加了宋体、仿宋、黑体和楷体四种字体的横排和竖排两种方式。

查看 GMT 当前支持的字体
+++++++++++++++++++++++

用 ``gmt text -L`` 命令查看 GMT 当前的字体配置::

    $ gmt text -L
    Font #  Font Name
    ------------------------------------
    0   Helvetica
    1   Helvetica-Bold
    ...    ......
    39 STSong-Light--UniGB-UTF8-H
    40 STFangsong-Light--UniGB-UTF8-H
    41 STHeiti-Regular--UniGB-UTF8-H
    42 STKaiti-Regular--UniGB-UTF8-H
    43 STSong-Light-UniGB-UTF8-V
    44 STFangsong-Light-UniGB-UTF8-V
    45 STHeiti-Regular-UniGB-UTF8-V
    46 STKaiti-Regular-UniGB-UTF8-V

其中 39-46 号字体为新添加的中文字体。
以后要用中文字体时，需要用这些编号来指定字体，也许你的机器上的编号和这里不同。

GMT 中文测试
++++++++++++

测试脚本：

.. literalinclude:: GMT_Chinese.sh

.. note::

    生成的 PNG、JPG格式的图片中可直接显示中文，
    而生成的 PDF 文件用 macOS 自带的 PDF 预览工具打开
    无法显示中文，使用 Adobe Reader 打开则可以正常显示中文。

成图效果如下：

.. figure:: GMT_Chinese.*
   :width: 100%
   :align: center
