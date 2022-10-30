.. index:: ! gmtsplit
.. include:: common_SYN_OPTs.rst_

gmtsplit
========

:官方文档: :doc:`gmt:gmtsplit`
:简介: 将表数据拆分成单独的段

**gmtsplit** 将表数据拆分以使每段数据都具有近乎恒定的方位角。该模块可认为
是数据提取和 :doc:`wiggle` 模块之间的一个数据过滤模块，也可以用来将一个大的
数据集分割成小段。

语法
----

**gmt gmtsplit** [ *table* ]
[ |-A|\ *azimuth*/*tolerance* ]
[ |-C|\ *course_change*]
[ |-D|\ *minimum_distance* ]
[ |-F|\ *xy\_filter*/*z\_filter* ]
[ |-N|\ *template* ]
[ |-Q|\ *flags* ]
[ |-S| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入表文件，可以为 2 列，3 列或者 5 列，数据值为 (x,y,[z[,d,h]])。
    默认情况下认为输入只包含 3 列，若输入数据为 5 列，使用 |-S| 选项确保 d
    不是递减的

可选选项
--------

.. _-A:

**-A**\ *azimuth*/*tolerance*
    计算方位角，只输出和方位角 *azimuth* 相差小于 *tolerance* 的段

.. _-C:

**-C**\ *course\_change*
    当检测到航向发生变化且超过 *course\_change* 时，结束该航段

.. _-D:

**-D**\ *minimum\_distance*
    输出总长度大于 *minimum\_distance* 的段，默认值为 0

.. _-F:

**-F**\ *xy\_filter*/*z\_filter*
    对数据进行滤波，假定数据为 d 列（x 的增量）的函数。*xy\_filter* 和 *z\_filter*
    分别为 x，y 值和 z 值的滤波的长度，单位和距离单位相同（见 |-S| ）。如果长度
    为 0 ，即不进行滤波。滤波长度的绝对值的是余弦滤波总的窗口宽度，如果长度为
    正值，则数据为低通滤波，如果为负值，则为高通滤波。如果 *z\_filter* 不为 0，则
    在拆分之前对数据滤波，因此边缘效应只会发生在整体数据的开始和结尾处，在每段数据
    的头尾则不会有。如果 *xy\_filter* 不为 0，数据将先被拆分，然后对每段的 x 和 y 
    值滤波，即在每段首尾都可能存在边缘效应，但是可以避免低通滤波将测线拐弯处舍入。

.. _-N:

**-N**\ *template*
    将拆分后的每段都单独输出到文件 [默认在一个文件输出所有段]。可以追加一个格式化
    的文件模版，必须使用 C 语言格式的语法，例如 %d 表示整数，%08d 表示宽度为 8 的
    整数，位数不够则在前面补 0 [默认模版为 gmtsplit_segment_%d.{txt|bin}，后缀与
    输出文件格式有关]。或者给出一个带有两个 C 语言格式的模版，使用表数据的编号和
    段号生成文件名。

.. _-Q:

**-Q**\ *flags*
    设置输出列包含 *xyzdh* 中的哪些列以及其顺序，中间不需要使用空格，且必须使用小写
    字母，默认为 **-Q**\ *xyzdh* ；如果输入只包含两列，则为 **-Q**\ *xydh* 。

.. _-S:

**-S**
    支持包含 d 和 h 的列，这时输入数据为 x,y,z,d,h。其中 d 和 h 分别表示 x 的增量和
    y 的增量。使用 **-fg** 时，数据为地理坐标，x 和 y 的坐标单位为度，增量的单位均
    为 km，角度为方位角。若为笛卡尔坐标，距离的单位和 x 以及 y 相同，角度从水平方向
    开始顺时针计算。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

使用 NCEI 提供的 JA020015 航次中 -R300/315/12/20 范围内东西方向的测线绘制磁异常的
:doc:`wiggle` 图，并对测线进行 100 km 的低通滤波和 500 km 的高通滤波 ::

    gmt mgd77list JA020015 -R300/315/12/20 -Flon,lat,mag,dist,azim |\
        gmt split -A90/15 -F100/-500 -D100 -S -V -fg |\
        gmt wiggle -R300/315/12/20 -Jm0.6i -Baf -B+tJA020015 -T1 \
        -W0.75p -Ggray -Z200 -pdf JA020015_wiggles

原始测量数据为 MGD77 格式，因此建议使用 :doc:`mgd77list`
模块提取 dist 和 azim 而不是使用 **gmtsplit** 计算。

将一个包含经纬度以及重力观测值的二进制双精度文件，拆分为 survey_xxxx.txt 形式的一系列
文件，拆分原则为间隙大于 100 km ::

    gmt split survey.bin -Nsurvey_%03d.txt -V -gd100k -D100 -: -fg -bi3d

相关模块
--------

:doc:`filter1d`,
:doc:`mgd77list`,
:doc:`wiggle`
