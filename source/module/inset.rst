.. index:: ! inset
.. include:: common_SYN_OPTs.rst_

inset
=====

:官方文档: :doc:`gmt:inset`
:简介: 管理和设置图中图模式

**inset** 模块用于管理图中图模式。即在纸张上规划出一小片区域，并限制接下来的绘制
操作均只在该小区域内操作。

**inset** 模块包含两个命令：

- **inset begin** 用于设置图中图模式，其定义了图中图区域的位置和大小
- **inset end** 用于结束图中图模式，所有的操作都会回到原大图中。

在图中图中，用户可以使用任意的投影方式和投影区域。若投影方式中底图宽度或
比例用 ``?`` 表示，则会根据 |-D| 选项设置的小图尺寸自动确定小图的投影参数。

inset begin语法
---------------

**gmt inset begin**
|-D|\ *inset-box*
[ |-F|\ *box* ]
[ |-C|\ *clearance* ]
[ |-N| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必须选项
--------

.. _-D:

**-D**\ *xmin/xmax/ymin/ymax*\ [**+r**][**+u**\ *unit*]
    类似于 :doc:`-R </option/R>` 选项，通过指定大图中的一个矩形区域作为小图的绘图区域。

    - **+r**: 与 :doc:`-R </option/R>` 选项类似，表明坐标为矩形区域的左下角和右上角坐标。
    - **+u**\ *unit*\ : 与 :doc:`-R </option/R>` 选项类似，表明此时的坐标为投影后坐标

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ **+w**\ *width*\ [/*height*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    指定小图区域的尺寸和位置

    简单介绍各子选项的含义，详情见 :doc:`/basis/embellishment`

    - **g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ 指定地图上的参考点

      .. include:: explain_refpoint.rst_

    - **+j**\ *justify* 指定小图区域的锚点
    - **+o**\ *dx*/*dy* 在参考点的基础上设置小图区域的额外偏移量
    - **+w**\ *width*\ [/*height*] 指定小图区域的宽度和高度。

可选选项
--------

.. _-F:

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    设置小图区域的背景面板属性。

    若只使用 |-F| 而不使用其它子选项，则会在小图周围绘制矩形边框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

.. _-C:

**-C**\ *clearance*
    小图区域内部的额外空白区域 [默认值没有空白]。其可以取三种形式：

    - 一个值，表示四个边的空白相同
    - 两个用斜杠分隔的值，分别设置水平和垂直方向的空白
    - 四个用斜杠分隔的值，分别设置左右下上四条边的空白

.. _-N:

**-N**
    不裁剪超过小图区域边界的部分。

.. include:: explain_-V.rst_

.. include:: explain_help_nopar.rst_

示例
----

.. gmtplot:: inset/inset-ex01.sh
   :width: 75%

.. gmtplot:: inset/inset-ex02.sh
   :width: 75%

相关模块
--------

:doc:`begin`,
:doc:`clear`,
:doc:`docs`,
:doc:`end`,
:doc:`figure`,
:doc:`subplot`
