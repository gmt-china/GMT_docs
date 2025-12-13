:author: 田冬冬, 周茂, 王亮
:date: 2022-06-19

.. index:: ! basemap
.. program:: basemap

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

**gmt basemap**
**-B**\ :doc:`(参数说明) </option/B>`
:option:`-L`\ *scalebar*
:option:`-T`\ *rose*
:option:`-T`\ *mag_rose*
[ :option:`-A`\ [*file*] ]
[ :option:`-F`\ *box* ]
:doc:`可选的通用标准选项 </option>`
**--PAR**\ =\ :doc:`配置参数临时设置 <conf/overview>`

必选选项
--------

**-B**, :option:`-L`, :option:`-T`三个选项中必须至少使用一个。

.. include:: explain_-B.rst_

.. include:: explain_-L_scale.rst_

.. include:: explain_-T_rose.rst_

可选选项
--------

.. option:: -A

**-A**\ [*file*]
    不绘制图形，仅输出矩形底图的边框坐标。

    该选项会将矩形底图的边框坐标输出到标准输出或文件中。使用该选项时，必须通过
    :option:`-J` 和 :option:`-R` 指定绘图区域，且不能再使用其他选项。
    若不指定 *file* 则默认输出到标准输出，否则输出到文件 *file* 中。

    说明：

    - 该选项似乎仅适用于矩形底图边框，非矩形边框会输出一堆NaN
    - 边框的采样间隔由参数 :term:`MAP_LINE_STEP` 决定

.. option:: -F

**-F**\ [**l**\|\ **t**][**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制比例尺和方向玫瑰的背景面板属性

    若只使用 :option:`-F` 而不使用其它子选项，则会在比例尺或方向玫瑰的周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

    该选项默认会同时控制比例尺和方向玫瑰的背景边框。
    加上 **l**\|\ **t** 则表示只控制 :option:`-L` 或 :option:`-T`
    选项绘制的特征。

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
