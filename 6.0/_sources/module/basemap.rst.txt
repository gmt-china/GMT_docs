.. index:: ! basemap
.. include:: common_SYN_OPTs.rst_

basemap
=======

:官方文档: :doc:`gmt:basemap`
:简介: 绘制底图及边框

该命令用于绘制：

- 绘制底图边框（标注、刻度、标签等）、网格线和标题
- 绘制比例尺
- 绘制方向玫瑰、磁场玫瑰图

语法
----

**gmt basemap** |-J|\ *parameters*
|SYN_OPT-Rz|
[ |-A|\ [*file*] ]
[ |SYN_OPT-B| ]
[ |-F|\ *box* ]
[ |-J|\ **z**\|\ **Z**\ *parameters* ]
[ |-L|\ *scalebar* ]
[ |SYN_OPT-U| ]
[ |-T|\ *rose* ]
[ |-T|\ *mag_rose* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

**-B** **-L** **-T** 三个选项中必须至少使用一个。

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

.. include:: explain_-B.rst_

.. include:: explain_-L_scale.rst_

.. include:: explain_-T_rose.rst_

可选选项
--------

.. _-A:

**-A**\ [*file*]
    不绘制图形，仅输出矩形底图的边框坐标。

    该选项会将矩形底图的边框坐标输出到标准输出或文件中。使用该选项时，必须通过
    **-J** 和 **-R** 指定绘图区域，且不能再使用其他选项。
    若不指定 *file* 则默认输出到标准输出，否则输出到文件 *file* 中。

    说明：

    #. 该选项似乎仅适用于矩形底图边框，非矩形边框会输出一堆NaN
    #. 边框的采样间隔由参数 :term:`MAP_LINE_STEP` 决定

.. _-F:

**-F**\ [**d**\|\ **l**\|\ **t**][**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制比例尺和方向玫瑰的背景面板属性

    若只使用 **-F** 而不使用其它子选项，则会在比例尺或方向玫瑰的周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    - **+p**\ *pen* 指定背景面板的画笔属性（默认画笔属性由 :term:`MAP_FRAME_PEN` 决定）
    - **+g**\ *fill* 设置背景面板的填充色 [默认不填充]
    - **+c**\ *clearances* 以设置不同方向的空白间隔
    - **+i**\ *gap*/*pen* 在背景面板内部绘制一个额外的内边框。\ *gap* 为外边框
      与内边界之间的距离 [2p]，默认边界属性由 :term:`MAP_DEFAULT_PEN` 控制
    - **+r**\ *radius* 控制圆角矩形边框，圆角矩形半径 *radius* 默认为 6p
    - **+s** 绘制背景面板阴影区。\ *dx*/*dy* 是阴影区相对于背景面板的偏移量 [4p/4p]。
      *shade* 为阴影区的颜色 [gray50]。

    该选项默认会同时控制比例尺和方向玫瑰的背景边框。
    加上 **d**\|\ **l**\|\ **t** 则表示只控制 **-D**\ 、\ **-L**\ 或 **-T**
    选项绘制的特征。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_-f.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

下图展示了绘制方向玫瑰图时 **+f** 取不同值的效果：

.. gmtplot:: basemap/dir_rose.sh
   :width: 80%
   :show-code: true

   方向玫瑰图

下图展示了磁场玫瑰图以及相关配置参数：

.. gmtplot:: basemap/mag_rose.sh
   :width: 80%

   磁场玫瑰图
