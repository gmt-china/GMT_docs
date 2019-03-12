.. index:: ! figure

figure
======

:官方文档: :doc:`gmt:figure`
:简介: 设置当前图片的属性

一个GMT现代模式会话下可以绘制一张或多张图件。对于一个会话中绘制多张图件的情况，
``figure`` 模块可以指定当前图件的文件名和格式。该模块必须在你开始向当前图件绘图
之前执行，且每次调用 ``figure`` 模块都会开启一张新的图件。你可以再次使用 ``figure``
模块在多个图件之间来回切换，但是 ``<formats>`` 和 ``<options>`` 等选项只能在你
第一次指定该图件时使用。

语法
----

::

    gmt figure <prefix> [<formats>] [<options>]

必须选项
--------

``<prefix>``
    图片文件名前缀。文件名后缀由图片格式 ``<formats>`` 自动决定。

可选选项
--------

``<formats>``
    一个或多个由逗号分隔的图片格式后缀。默认图片格式为 ``pdf``\ 。
    支持的图片格式见 :ref:`图片格式列表 <fig-formats>`\ 。

``<options>``
    GMT本质上是先生成PS格式的图片，再通过调用 :doc:`psconvert` 自动转换成用户
    指定的图片格式。此处可以设置要传递给模块 :doc:`psconvert` 的选项，
    多个选项之间用逗号分隔。

    默认值为 ``A``\ ，表示将 ``-A`` 选项传给 :doc:`psconvert`\ 。

    其他可选的选项包括：

    - **A**\ [*args*]: 裁剪选项
    - **C**\ *args*: 额外传递给GhostScript的选项
    - **D**\ *dir*: 指定图片的输出目录
    - **E**\ *dpi*: 设置图片分辨率
    - **H**\ *factor*
    - **M**\ *args*
    - **Q**\ *args*
    - **S**

    详细解释见 :doc:`psconvert` 的说明文档。

示例
----

在当前的现代模式下开启一个新绘图，图片名为 Regional，格式为PDF和EPS格式::

    gmt begin
    gmt figure Regional pdf,eps
    gmt ...
    gmt end

开启一个新绘图，名为GlobalMap，图片格式为JPEG，并对图片进行裁剪，四边均保留1厘米的空白::

    gmt begin
    gmt figure GlobalMap jpg A1c
    gmt ...
    gmt end


在两张图之间切换::

    gmt begin

    # 在 Fig1 中绘制
    gmt figure Fig1 png
    gmt ...

    # 在 Fig2 中绘制
    gmt figure Fig2 png
    gmt ...

    # 切换回 Fig1
    gmt figure Fig1
    gmt ...

    # 切换回 Fig2
    gmt figure Fig2
    gmt ...

    gmt end
