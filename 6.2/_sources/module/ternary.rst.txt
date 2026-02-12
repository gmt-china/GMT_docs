.. index:: ! ternary
.. include:: common_SYN_OPTs.rst_

ternary
=======

:官方文档: :doc:`gmt:ternary`
:简介: 绘制三角图解

**ternary** 从文件或者标准输入中读取数据，并在三角图中绘制符号。
如果给定符号类型，但未给出符号大小，**ternary** 会将第四列数据作为符号大小，
符号大小值小于0的将会被跳过。如果没指定符号类型，就必须在数据的最后一列给出符号代码。

语法
----

**gmt ternary** [ *table* ]
[ **-JX**\ *width* ]
[ |-R|\ *amin*\ /*amax*\ /*bmin*\ /*bmax*\ /*cmin*\ /*cmax* ]
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-G|\ *fill* ]
[ |-L|\ *a*\ /*b*\ /*c* ]
[ |-M| ]
[ |-N| ]
[ |-S|\ [*symbol*][*size*] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*][*attr*] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

必须使用 **-M** 或者 **-R** 和 **-J**。

可选选项
--------

.. include:: explain_intables.rst_

.. _-B:

**-B**\ [**a**\|\ **b**\|\ **c**]\ *args*
    设置三角图的三条边的属性。

    与常规图不同，三角图有三条不同的边。三条边从下面这条边开始，
    逆时针旋转，分别称为 **a**、**b**、**c**。
    其余用法与标准选项 **-B** 相同。

.. _-C:

**-C**\ *cpt* 或 **-C**\ *color1,color2*\ [*,color3*\ ,...]
    指定CPT文件，或者跟上一系列以逗号分隔的颜色以构建一个线性连续CPT

    若使用了 **-S** 选项，则符号填充色由第四列数值决定，其它字段向右移动一列
    （即若需要指定符号大小，符号大小应置于第5列）。

    现代模式下，若不指定CPT，则使用当前CPT。

.. _-G:

**-G**\ *fill*
    指定符号填充色。

    对于多段数据，段头记录中的 **-G** 字符串会覆盖命令行中该选项的值。

.. _-J:

**-JX**\ *width*
    指定三角图的宽度

.. _-L:

**-L**\ *a*\ /*b*\ /*c*
    设置三个顶点的标签，标签距离顶点的距离为 :term:`MAP_LABEL_OFFSET` 三倍。

.. _-M:

**-M**
    不绘图。将三角图数据 (*a*,\ *b*,\ *c*\ [,\ *z*]) 转换为笛卡尔坐标
    (*x*,\ *y*,\ [,\ *z*])，x,y 为在三角图解中的归一化坐标值。
    x 的取值范围为0-1，y 的取值范围为0到 :math:`\frac{\sqrt{3}}{2}`

    如果一个点在三角图中坐标为 (a, b, c)，则笛卡尔坐标(x, y)为:

    .. math::

        x = \frac{(100-a)+b}{2\times100}

        y =\frac{\sqrt{3}}{2\times 100}\times c

.. _-N:

**-N**
    不裁剪落在三角图外的符号 [默认只绘制三角图内的符号]

.. _-R:

**-R**\ *amin/amax/bmin/bmax/cmin/cmax*
    指定三条边 **a**、**b** 和 **c** 的最大最小值。

.. _-S:

**-S**\ [*symbol*][*size*]
    指定要绘制的符号类型及大小

    详见 :doc:`plot` 中的 **-S** 选项。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*pen*][*attr*]
    设置符号的画笔属性。

.. include:: explain_-t.rst_

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_colon.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

.. _gmt-ternary-example:

示例
----

.. gmtplot::
   :width: 70%

    gmt begin map pdf,png
    gmt makecpt -Cturbo -T0/80/10
    gmt ternary @ternary.txt -R0/100/0/100/0/100 -JX6i -Sc0.1c -C -LWater/Air/Limestone \
        -Baafg+l"Water component"+u" %" -Bbafg+l"Air component"+u" %" -Bcagf+l"Limestone component"+u" %" \
        -B+givory+t"Example data from MATLAB Central"
    gmt end show

相关模块
--------

:doc:`basemap`,
:doc:`plot`,
:doc:`plot3d`
