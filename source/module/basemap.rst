.. index:: ! basemap

basemap
=======

:官方文档: :doc:`gmt:basemap`
:简介: 绘制底图

该命令用于绘制：

- ``-B`` 选项绘制底图边框（标注、刻度、标签等）和标题
- ``-L`` 选项绘制比例尺
- ``-T`` 选项绘制方向玫瑰、磁场玫瑰图

必选选项
--------

``-B`` ``-L`` ``-T`` 三个选项必须至少存在一个。

``-B``
    绘制底图边框。 ``-B`` 选项是GMT的通用选项，见GMT中文手册中相关内容。

    示例::

        gmt basemap -R-180/180/-70/70 -JM10c -Bx60 -By30 -pdf test

.. include:: explain_-L_scale.rst_
..

    示例::

        gmt basemap -R90/110/30/40 -JM10c -Bx5 -By5 -Lg95/35+c35+w800k+lscale+u+f -png test

        gmt basemap -R90/180/-50/50 -Jm0.025i -Bafg -B+tMercator -Lx1i/1i+c0+w5000k -png mercator

.. include:: explain_-T_directional_rose.rst_
..

    下图展示了方向玫瑰图的效果图：

    .. gmtplot:: /scripts/basemap_ex3.sh
       :width: 100%
       :show-code: false

       方向玫瑰图

       （左） ``-Tdg0/0+w1i+jCM``
       （中） ``-Tdg0/0+w1i+f1+jCM``
       （右） ``-Tdg0/0+w1i+f3+l+jCM``

.. include:: explain_-T_magnetic_rose.rst_

可选选项
--------


``-A[<file>]``
    不绘制图形，仅输出矩形底图的边框坐标。

    该选项会将矩形底图的边框坐标输出到标准输出或文件中。使用该选项时，必须通过
    ``-J`` 和 ``-R`` 指定绘图区域，且不能同时使用其他选项。若不指定 ``<file>``
    则默认输出到标准输出，否则输出到文件 ``<file>`` 中。

    说明：

    #. 该选项似乎仅适用于矩形底图边框，非矩形边框会输出一堆NaN
    #. 尚不清楚该选项存在的意义
    #. 边框的采样间隔由参数 ``MAP_LINE_STEP`` 决定

    示例::

        gmt basemap -R0/10/0/10 -JX10c/5c -Aoutline.txt

``-F[d|l|t][+c<clearances>][+g<fill>][+i[[<gap>/]<pen>]][+p[<pen>]][+r[<radius>]][+s[[<dx>/<dy>/][<shade>]]]``
    控制比例尺和方向玫瑰的背景边框的属性

    说明：

    #. 该选项用于给比例尺和方向玫瑰绘制背景边框，默认同时控制三者的属性
    #. ``d|l|t`` 表示该选项定义的属性仅适用于 ``-D``\ 、\ ``-L`` 或 ``-T`` 选项
    #. 直接使用 ``-F`` 选项，则绘制背景边框，边框属性由参数 ``MAP_FRAME_PEN`` 控制
    #. 其他子选项的含义见 :doc:`/basis/embellishment` 一节的详细介绍

.. include:: explain_-U.rst_

.. include:: explain_-t.rst_

示例
----

下面的脚本绘制了磁场玫瑰图：

.. gmtplot:: /scripts/basemap_ex4.sh
   :width: 100%

   磁场玫瑰图

BUGS
----

#. 使用 ``-A`` 选项可以正常输出结果，但会出现 ``double free`` 的错误（v5.2.1）
