:author: 田冬冬, 王亮, 陈箫翰
:date: 2026-01-04

.. index:: ! histogram
.. program:: histogram

histogram
=========

:官方文档: :doc:`gmt:histogram`
:简介: 统计并绘制直方图

**histogram** 模块读取文件 [或标准输入] 并检查第一列数据（或由 :option:`-i` 指定的列），根据提供的直方间隔计算直方图参数。
利用这些参数、缩放比例以及可选的范围参数绘制直方图。此外，还可以指定绘制累积直方图。

语法
----

**gmt histogram**
[ *table* ]
:option:`-J`\ **x**\|\ **X**\ *parameters*
:option:`-T`\ [*min/max*\ /]\ *inc*\ [**+n|i**] \|\ :option:`-T`\ *file*\|\ *list*
[ :option:`-A` ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt*\ [**+b**] ]
[ :option:`-D`\ [**+b**][**+f**\ *font*][**+o**\ *off*][**+r**] ]
[ :option:`-E`\ *width*\ [**+o**\ *offset*] ]
[ :option:`-F` ]
[ :option:`-G`\ *fill* ]
[ :option:`-I`\ [**o**\|\ **O**] ]
[ :option:`-L`\ **l**\|\ **h**\|\ **b** ]
[ :option:`-N`\ [*mode*][**+p**\ *pen*] ]
[ :option:`-Q`\ **r** ]
[ :option:`-R`\ *region* ]
[ :option:`-S` ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ [*type*][**+w**] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-l`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-w`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_intables.rst_

必须选项
--------

.. option:: -J

**-J**\ **x**\|\ **X**\ *parameters*
    *xscale*\[/*yscale*] 表示线性比例尺，或者使用 **-JX** 指定 *width*\[/*height*] 宽度/高度。
    详细说明请参考 :doc:`/proj/Jx` 。

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+n|i**]
    指定等间隔统计直方：

    - :option:`-T`\ *min/max/inc* 指定统计区间的最小值、最大值和直方间隔
    - :option:`-T`\ *inc* 只指定统计直方的间隔。统计区间最大和最小值由 :option:`-R` 选项决定

    **注意**：对时间数据进行统计时，时间单位默认由 :term:`TIME_UNIT` 控制。也可以在 *inc* 后自行附加时间单位后缀。

    * **+n** ：表示 *inc* 是直方数量而不是默认的直方间隔。
    * **+i** ：表示 *inc* 是直方间隔的倒数（例如，输入 3 代表 0.3333...）。

**-T**\ *file*\|\ *list*
    指定不等间隔统计直方：提供一个第一列为直方间隔的文件 *file* ，或者一个逗号分隔的数值列表 *list* 。

详情请参见 :doc:`/examples/data_ex01/` 。

可选选项
--------

.. option:: -A

**-A**
    水平绘制直方图，即从 x = 0 开始。不使用本选项默认是从 y = 0 开始垂直绘制。绘图尺寸保持不变，但两个坐标轴会发生对调。

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *cpt*\ [**+b**]
    指定 CPT 文件，将每个直方的中点坐标作为 Z 值查询 CPT 中的颜色，颜色随 X 轴（数值区间）变化。
    附加 **+b** 改为使用每个直方的频数或百分比作为 Z 值进行查询，颜色将随 Y 轴（频数或百分比）变化。
    如果 :option:`-Z` 涉及百分比，附加 **+b** 则使用计算出的百分比进行查询。

.. option:: -D

**-D**\ [**+b**][**+f**\ *font*][**+o**\ *off*][**+r**]
    为每个直方添加标注，其内容是每个直方的统计数目：

    - **+b** ：将标注放在直方的底部（默认为顶部）
    - **+f**\ *font* ：设置标注的字体
    - **+o**\ *offset* ：修改标注与直方的距离（默认值为6p）
    - **+r** ：将标注从水平方向旋转为垂直方向

.. option:: -E

**-E**\ *width*\ [**+o**\ *offset*]
    设置新的直方宽度 *width* 覆盖 :option:`-T` 中的设置，也可以附加 **+o** 将所有直方平移一个 *offset* 偏移量。
    *width* 既可以是数据单位表示的备选宽度，也可以附加有效的绘图尺寸单位（ **c|i|p** ）来指定固定尺寸。
    与 *width* 一样，偏移量 *offset* 也可以附加单位。

.. option:: -F

**-F**
    将每个直方的中点对准 :option:`-T` 选项创建的一维数组的每个值。
    不使用本选项默认使用每个直方的左边界进行对齐。

    假设 :option:`-T` 设置的范围是0到100，间隔为10。
    默认情况下，会将0到10作为第一个直方，10到20作为第二个直方，以此类推。
    若使用本选项，则第一个直方以0为中心，即-5到5是第一个直方，5到15是第二个直方，以此类推。

.. option:: -G

**-G**\ *fill*
    设置直方的填充色（默认无填充）。

.. option:: -I

**-I**\ [**o**\|\ **O**]
    输出计算结果不绘图。

    - **-I** 输出 *xmin xmax ymin ymax*，即数据的最小值、最大值和统计数量的最小值、最大值。
    - **-Io** 输出各个直方的 *x, y* 数据的 ASCII 表，不包括 *y* = 0 的数据。
    - **-IO** 输出包括 *y* = 0 的所有数据。

    **注意**：可以使用 :option:`-o` 选项选择部分数据输出。

.. option:: -L

**-Ll**\|\ **h**\|\ **b**
    设置超过统计范围的数据的处理方式。

    - **-Ll** 小于第一个直方的统计范围的数据算入第一个直方
    - **-Lh** 大于最后一个直方的统计范围的数据算入最后一个直方
    - **-Lb** 小于第一个直方的统计范围的数据算入第一个直方，
      并且大于最后一个直方的统计范围的数据算入最后一个直方

.. option:: -N

**-N**\ [*mode*][**+p**\ *pen*]
    绘制等效的正态分布曲线，可附加画笔属性 [默认为 0.25p,black]。 *mode* 用于设定正态分布的中心位置和比例尺：

    - *mode* = 0：平均值和标准差 (默认)
    - *mode* = 1：中位数和 L1 比例尺 (1.4826 * 中值绝对偏差; MAD)
    - *mode* = 2：LMS (最小二乘中位数) 众数和比例尺

    该选项可以使用多次以绘制多条曲线。
    **注意**：如果使用了 :option:`-w` 选项，则仅 *mode* = 0 可用，此时将计算圆形冯·米塞斯分布（von Mises distribution）的参数。

.. option:: -Q

**-Q**\ **r**
    绘制累计直方图， **r** 绘制反向的累计直方图。不能和 :option:`-w` 一起使用。

.. include:: explain_-R.rst_

.. option:: -S

**-S**
    绘制阶梯状直方图，并且不包含直方内部的线条。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*
    设置直方边框（或阶梯状曲线）的画笔属性 [默认不绘制]。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ [*type*][**+w**]
    选择直方图的种类：

    - *type* = 0：频数 counts（默认值）
    - *type* = 1：百分比 frequency_percent
    - *type* = 2：log (1.0 + count)
    - *type* = 3：log (1.0 + frequency_percent)
    - *type* = 4：:math:`\log_{10}` (1.0 + count)
    - *type* = 5：:math:`\log_{10}` (1.0 + frequency_percent)

    若要使用数据第二列而不是 counts 频数作为权重，可以加上 **+w** 。

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-l.rst_
..

    图例符号是一个宽高比为 3:2 的矩形。使用 **+S**\ *width*\ [/*height*] 可自定义宽度高度。

.. include:: explain_-ocols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-s.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_help.rst_

示例
----

用包含海底深度的远程数据文件 @v3206_06.txt 绘制直方图，并使用 250 米的间距、使直方居中并绘制轮廓::

    gmt histogram @v3206_06.txt -F -T250 -W0.25p -B -pdf plot

如果了解数据的分布情况，可以显式指定范围和比例尺。
例如，用文件 errors.xy 中的 y 值（第 2 列）绘制直方图，使用 1 米的间距，绘制范围为 -10 到 +10 米，
x 轴比例尺为 0.75 cm/m，y 轴比例尺为 0.01 cm/计数，每隔 2 米和 100 个计数进行标注，并使用黑色直方::

    gmt begin plot
      gmt histogram errors.xy -T1 -R-10/10/0/0 -Jx0.75c/0.01c -Bx2+lError -By100+lCounts -Gblack -i1
    gmt end show

由于未指定 y 轴范围， **histogram** 将以 100 的整数倍为增量自动计算 *ymax*。

访问 :doc:`/tutorial/histogram/index` 以查看更多示例。

相关模块
--------

:doc:`basemap`,
:doc:`rose`,
:doc:`plot`