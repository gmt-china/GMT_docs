.. index:: ! figure

figure
======

:官方文档: :doc:`gmt:figure`
:简介: 设置当前图片的属性

一个GMT现代模式会话下可以绘制一张或多张图件。对于一个会话中绘制多张图件的情况，
``figure`` 模块可以指定当前图件的文件名和格式。该模块必须在你开始向当前图件绘图
之前执行，且每次调用 ``figure`` 模块都会开启一张新的图件。你可以在多个图件之间
来回切换，但是 ``<formats>`` 和 ``<options>`` 等选项只能在你第一次指定该图件时
使用。

语法
----

    gmt figure <prefix> [<formats>] [<options>]

必须选项
--------

``<prefix>``
    图片文件名前缀。文件名后缀由图片格式 ``<formats>`` 自动决定。

可选选项
--------

``<formats>``
    一个或多个由逗号分隔的图片格式后缀。支持的图片格式见表 :ref:`formats <tbl-formats>`\ 。
    默认图片格式为 pdf。

``<options>``
    设置用于传递给模块 :doc:`psconvert` 的选项，多个选项之间用逗号分隔。
    默认值为 ``A`` 表明在调用 :doc:`psconvert` 模块生成最终图片时会额外
    加上 ``-A`` 选项。

    其它有效的选项子集包括
    **A**\ [*args*],\ **C**\ *args*,\ **D**\ *dir*,\ **E**\ *dpi*,\ **H**\ *factor*,\ **M**\ *args*,\ **Q**\ *args*,\ **S**.
    每个选项的具体含义见 :doc:`psconvert` 。

示例
----

在当前的现代模式下开启一个新绘图，图片名为 Regional，格式为PDF和EPS格式::

    gmt figure Regional pdf,eps

开启一个新绘图，名为GlobalMap，图片格式为JPEG，并对图片进行裁剪，四边均保留1厘米的空白::

    gmt figure GlobalMap jpg A1c
