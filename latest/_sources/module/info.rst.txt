:author: 田冬冬, 陈箫翰
:date: 2026-01-04

.. index:: ! info
.. program:: info

info
=======

:官方文档: :doc:`gmt:gmtinfo`
:简介: 从表数据中提取信息

**info** 读取标准输入（或数据文件）并寻找每一列的极值，以斜杠分隔的“最小值/最大值”形式输出。
它能够识别 NaN 值，并且如果各记录之间的列数不一致，会打印警告信息。
使用 :option:`-C` 选项可以将输出拆分为两个独立的列。
可以根据 :option:`-I` 提供的增量，将前两列数据的范围向上或向下取整到最接近的倍数。
可以以 **-R**\ *w/e/s/n* 的文本格式输出信息，可直接用于其他模块的命令行参数。
如果将 :option:`-C` 与 :option:`-I` 结合使用，则输出将采用列格式，并针对 :option:`-I` 中提供的所有增量对应的列进行向上/向下取整。
:option:`-T` 可以以 **-T**\ *zmin/zmax/dz* 的字符串格式输出信息，可直接用作 :doc:`makecpt` 的选项参数。

语法
-------

**gmt info**
[ *table* ]
[ :option:`-A`\ **a**\|\ **t**\|\ **s** ]
[ :option:`-C` ]
[ :option:`-D`\ [*dx*\ [/*dy*]] ]
[ :option:`-E`\ **L**\|\ **l**\|\ **H**\|\ **h**\ [*col*] ]
[ :option:`-F`\ [**i**\|\ **d**\|\ **t**] ]
[ :option:`-I`\ [**b**\|\ **e**\|\ **f**\|\ **p**\|\ **s**]\ *dx*\ [/*dy*\ [/*dz*...][**+e**\|\ **r**\|\ **R**\ *incs*]] ]
[ :option:`-L` ]
[ :option:`-T`\ *dz*\ [**w**\|\ **d**\|\ **h**\|\ **m**\|\ **s**][**+c**\ *col*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_intables.rst_

可选选项
--------

.. option:: -A

**-A**\ **a**\|\ **t**\|\ **s**
    输入数据为多段数据或多文件时的处理方式（默认为 **-Aa** ）：

    #. **-Aa** ：报告所有文件的总最值
    #. **-Af** ：分别报告各个文件自己的最值
    #. **-As** ：分别报告各段数据自己的最值

.. option:: -C

**-C**
    输出时，每列的最大最小值分别占一列

    在输出每一列的最大最小值时，默认会用 *min/max* 的格式输出，不易于脚本
    处理。该选项会将每列的最大最小值分别输出为一列::

        $ gmt info input.dat -C
        1   2   1   3   0   3.2

    该选项经常与 :option:`-i` 和 :option:`-o` 选项一起使用，以提取部分列的最值信息。

.. option:: -D

**-D**\ [*dx*\ [/*dy*]]
    对 :option:`-I` 选项的结果做整体偏移，使得区域范围的中心与原数据的中心对齐。
    可以为该平移附加粒度（granularity）[默认执行精确平移]。

    比如数据的真实范围是 *0/3* ，使用 **-I2** 选项会得到 *0/4* ，在此基础
    上使用 :option:`-D` 选项，则变成 *-0.5/3.5* 。

.. option:: -E

**-EL**\|\ **l**\|\ **H**\|\ **h**\ [*col*]
    返回第 *col* 列最值所在的记录行。

    #. **l|h** ：表示返回最小、最大值所在的记录行
    #. **L|H** ：表示返回绝对值最小、最大值所在的记录行

    若有多行均满足要求，则只返回第一行。若 *col* 未指定，则默认是最后一列。

.. option:: -F

**-F**\ [**i**\|\ **d**\|\ **t**]
    返回记录统计数据

    - **-Fi** ：返回总文件数、总数据段数、总数据记录数、总头段记录数、总记录数
    - **-Fd** ：返回每个数据段的信息：表号、段号、行数、开始记录号、结束记录号
    - **-Ft** ：与 **-Fd** 类似，但会对每个输入文件重置段号、开始记录号和结束记录号

.. option:: -I

**-I**\ [**b**\|\ **e**\|\ **f**\|\ **p**\|\ **s**]\ *dx*\ [/*dy*\ [/*dz*...][**+e**\|\ **r**\|\ **R**]]
    将前 *n* 列的 *min/max* 值调整为给定增量 *dx*\ [/*dy*]... 的最近倍数（用斜杠分隔 *n* 个增量）[默认是 2 列]。
    默认情况下，输出结果为字符串格式 **-R**\ *w/e/s/n* 或 **-R**\ *xmin/xmax/ymin/ymax* 。
    如果设置了 :option:`-C`，每个 *min* 和 *max* 值会输出在独立的列中。
    如果仅给出一个增量，该增量也将用于第二列。可以使用以下附加选项：

    - **b** ： 将数据表或分段的边界框写入为闭合多边形段，参考 :option:`-A`。
    - **e** ： 在 **-R** 字符串中给出精确 *min/max*。如果只想让 *x* 或 *y* 范围中的一个是精确的，而另一个范围是取整的，请将其中一个增量设为零。
    - **f** ： 附加 *dx*\ [/*dy*] 输出一个优化后的扩展区域，为 FFT 程序提供最快计算结果所需的网格范围。
    - **p** ： 仅给出一个增量 *dx* 时，不将其用于第二列。
    - **s** ： 附加 *dx*\ [/*dy*] 输出一个优化后的扩展区域，为 :doc:`surface` 等程序提供最快计算结果所需的网格范围。

    可以再附加以下选项进一步调整：

    - **+e** ： 类似于 **+r**，但确保边界框至少向外扩展增量的 0.25 倍 [默认不扩展]。
    - **+r** ： 进一步修改前 *n* 列的 *min/max* 。附加 *inc* 、 *xinc/yinc* 或 *winc/einc/sinc/ninc* 以将区域调整为这些步长的倍数 [默认不调整]。
    - **+R** ： 改为通过加上和减去这些增量来向外扩展区域。

    **注意**：如果输入的 *x* 和 *y* 坐标相对于 *dx* 和 *dy* 增量具有相同的相位偏移，那么在确定区域时会使用这些相位偏移，
    可以使用 :option:`-r` 从网格线配准切换到像素配准。对于不规则数据，两个相位偏移均被设置为 0，且 :option:`-r` 会被忽略。

.. option:: -L

**-L**
    确定多个表数据（ :option:`-A`\ **f** ）或多段数据（ :option:`-A`\ **s** ）的共同范围。
    若与 :option:`-I` 选项连用，则最终的结果会向内近似以使得极值位于真实数据范围内。

.. option:: -T

**-T**\ *dz*\ [**w**\|\ **d**\|\ **h**\|\ **m**\|\ **s**][**+c**\ *col*]
    以 **-T**\ *zmin/zmax/dz* 的形式输出第一列的最小值/最大值，并将其取整为最接近 *dz* 的倍数。
    附加 **+c**\ *col* 输出第 *col* 列的最值。 *col* 的默认值为 0 ，表示第一列。
    该选项不能与 :option:`-I` 选项连用。

    **注意**：如果列包含绝对时间，可以在 *dz* 后面附加时间单位（ **w|d|h|m|s** ），或者默认使用 :term:`TIME_UNIT` 设置的单位 [默认为 **s**]。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
--------

提取文件中各列的极值::

    $ gmt info input.dat
    input.dat: N = 6    <1/2>   <1/3>   <0/3.2>

从输出中可以看到，输入文件中有6行3列，三列数据的范围分别是1到2、1到3和0到3.2。

调整最大/小值使得其是给定的增量的最近倍数，返回的格式为 **-R**\ *w/e/s/n* ::

    $ gmt info input.dat -I2/2
    -R0/2/0/4

如果设置 *dx* 的值为 *-* ，则表示以 **-R**\ *w/e/s/n* 的格式输出真实精确的范围::

    $ gmt info input.dat -I-
    -R1/2/1/3

当 :option:`-I` 选项和 :option:`-C` 选项一起使用时，输出不再是 **-R**\ *w/e/s/n* 格式::

    $ gmt info input.dat -C -I2
    0   2   0   4   0   3.2

上面的例子中， :option:`-I` 选项后只接了一个增量，此时第二列数据也会使用同样的
增量（出于向后兼容性考虑）。若只想要为第一列指定增量，第二列不指定，可以使用
**-Ip** 选项::

    $ gmt info input.dat -C -Ip2
    0   2   1   3   0   3.2

寻找远程文件 @ship_15.txt 中的极值::

    $ gmt info @ship_15.txt
    ship_15.txt: N = 82651	<245/254.705>	<20/29.99131>	<-4504/-9>

寻找 @ship_15.txt 中取整到最接近 5 个单位的极值，平移至距离数据中心 1 个单位以内，并利用该区域通过 :doc:`plot` 将所有点绘制为黑色小圆点::

    gmt plot $(gmt info -I5 -D1 @ship_15.txt$) @ship_15.txt -B -Sc2p -pdf map

寻找前 3 列中每一列的最小值和最大值（取整为整数），并分别返回每个数据文件的结果::

    gmt info @ship_15.txt -C -I1/1/1

给定具有不同起点和终点位置的七个剖面，找到一个所有剖面共有的位置范围，增量为 5::

    gmt info profile_[123567].txt -L -I5

文件 magprofs.txt 包含许多以独立数据段形式存储的磁力剖面。需要知道共有多少个分段::

    gmt info magprofs.txt -Fi

Bugs
----

:option:`-I` 选项尚不能正确处理时间序列数据（例如 **-f**\ 0T）。因此，无法计算诸如月和年等长度可变的间隔。
作为替代，请使用与当前 :term:`TIME_UNIT` 设置相同的单位来指定您的间隔。

相关模块
-----------

:doc:`convert`,
:doc:`plot`