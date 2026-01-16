:author: 田冬冬, 周茂, 邓山泉, 陈箫翰
:date: 2026-01-12

.. index:: ! ternary
.. program:: ternary

ternary
=======

:官方文档: :doc:`gmt:ternary`
:简介: 绘制三角图解

**ternary** 从文件或者标准输入中读取 (*a*, *b*, *c* [, *z*]) 数据，并在三角图中绘制符号。
如果给定符号类型，但未给出符号大小，**ternary** 会将第四列数据作为符号大小，
符号大小值小于0的将会被跳过。如果没指定符号类型，就必须在数据的最后一列给出符号代码（见下文 :option:`-S` ）。
如果未指定 :option:`-S` ，则改为绘制线条或多边形。

语法
----

**gmt ternary**
[ *table* ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-G`\ *fill* ]
[ :option:`-J`\ **X**\ [-]\ *width* ]
[ :option:`-L`\ *a*\ /*b*\ /*c* ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-R`\ *amin*\ /*amax*\ /*bmin*\ /*bmax*\ /*cmin*\ /*cmax* ]
[ :option:`-S`\ [*symbol*][*size*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [*pen*][*attr*] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_intables.rst_

必须选项
--------

必须使用 :option:`-M` 或者 :option:`-R` 和 :option:`-J`。

可选选项
--------

.. option:: -B

**-B**\ [**a**\|\ **b**\|\ **c**]\ *args*
    设置三角图的三条边的属性。

    与常规图不同，三角图有三条不同的边。三条边从下面这条边开始，
    逆时针旋转，分别称为 **a**、**b**、**c**。
    如果所有坐标轴的参数都相同，则只需提供一个不带坐标轴字母的选项。其余用法与标准选项 :option:`-B` 相同。

.. option:: -C

**-C**\ *cpt*
    指定CPT文件，或者跟上一系列以逗号分隔的颜色以构建一个线性连续CPT： :option:`-C`\ *color1,color2*\ [*,color3*\ ,...]

    若使用了 :option:`-S` 选项，则符号填充色由第四列数值决定，其它字段向右移动一列
    （即若需要指定符号大小，符号大小应置于第5列）。

    现代模式下，若不指定CPT，则使用当前CPT。

.. option:: -G

**-G**\ *fill*
    指定符号填充色。

    对于多段数据，段头记录中的 :option:`-G` 字符串会覆盖命令行中该选项的值。

.. option:: -J

**-JX**\ *width*
    指定三角图的宽度。使用负的 *width* 值表示坐标轴的正方向为顺时针方向 [默认情况下，*a, b, c* 轴的正方向为逆时针方向]。

.. option:: -L

**-L**\ *a*\ /*b*\ /*c*
    设置三个顶点（即组分为 100% 处）的标签 [默认为空]。这些标签放置在距离各自顶点三倍于 :term:`MAP_LABEL_OFFSET` 设置值的位置。若要跳过其中任何一个，请将该标签指定为 `-`。

.. option:: -M

**-M**
    不绘图。将三角图数据 (*a*,\ *b*,\ *c*\ [,\ *z*]) 转换为笛卡尔坐标
    (*x*,\ *y*,\ [,\ *z*])，x,y 为在三角图解中的归一化坐标值。
    x 的取值范围为0-1，y 的取值范围为0到 :math:`\frac{\sqrt{3}}{2}`

    如果一个点在三角图中坐标为 (a, b, c)，则笛卡尔坐标(x, y)为:

    .. math::

        x = \frac{(100-a)+b}{2\times100}

        y =\frac{\sqrt{3}}{2\times 100}\times c

.. option:: -N

**-N**
    不裁剪落在三角图外的符号 [默认只绘制三角图内的符号]

.. option:: -R

**-R**\ *amin/amax/bmin/bmax/cmin/cmax*
    指定三条边 **a**、**b** 和 **c** 的最大最小值。

.. option:: -S

**-S**\ [*symbol*][*size*]
    在三角图中绘制符号。如果不使用本选项，将改为绘制线条（需要 :option:`-W` ）或多边形（需要 :option:`-C` 或 :option:`-G` ）。
    如果指定了符号大小 *size* ，则默认单位为 :term:`PROJ_LENGTH_UNIT` ，也可以附加 **c** 、 **i** 或 **p** 。
    如果不指定符号代码 *symbol* ，则从输入数据的最后一列读取。这种省略默认设置不能用在读取二进制输入文件的情况。

    **注意**：如果通过输入文件同时提供大小和符号，则必须使用 :term:`PROJ_LENGTH_UNIT` 来指示用于符号大小的单位，或者在文件中的大小数值后附加单位。
    可以通过 :option:`-i` 选项将这些值转换为合适的符号大小。一般的输入要求为：

    *coordinates* [ *value* ] [ *parameters* ] [ *symbol* ]

    其中 *coordinates* 是两列或三列，用于指定点的位置。当使用 :option:`-C` 控制颜色时，需要 *value* 。当未指定符号大小时，需要 *parameters* 。当未指定符号代码时，则需要 *symbol* 。
    **注意**： *parameters* 可能代表多个 *size* 列，因为某些符号需要定义多个参数（例如，圆只需要一列，矩形需要两个维度，而椭圆需要一个方向和两个维度）。
    当只有一个参数时， *parameters* 等同于 *size*。

    具体可用的符号详见 :doc:`plot` 中的 **-S** 选项。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*pen*][*attr*]
    设置符号轮廓的画笔属性。

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

.. _gmt-ternary-example:

示例
----

在一个 15 厘米宽的三角图中，在 ternary.txt 文件所列的位置上绘制圆（直径为 0.1 厘米），并使用默认的标注、网格线间距以及指定的标签：

.. gmtplot::
    :width: 70%

    gmt begin map
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
