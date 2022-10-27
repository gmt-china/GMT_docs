.. index:: ! blockmode
.. include:: common_SYN_OPTs.rst_

blockmode
=========

:贡献者: |周茂|
:最近更新日期: 2022-10-23

----

:官方文档: :doc:`gmt:blockmode`
:简介: 使用众数估计对表数据做区块处理 

**blockmode** 读取 xyz 形式的表数据（或可在最后加一列权重）, 并对 |-R| 和 |-I| 定义
的每个区块输出一个位置和值的众数估计到标准输出。使用 |-G| 可直接输出为网格文件。在进行
:doc:`surface` 模块时，为避免短波信号混淆，应提前使用 **blockmode** ，:doc:`blockmedian`
, 或 :doc:`blockmean` 。这些操作在用来抽稀数据或者平均数据时很有用。用户可通过设置
:term:`FORMAT_FLOAT_OUT` 参数设置输出数据有效数字以避免精度损失。

语法
----

**gmt blockmode** [ *table* ]
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ *fields* ]
[ |-C| ]
[ |-D|\ [*width*]\ [**+c**][**+a**\|\ **l**\|\ **h** ]]
[ |-E|\ [**r**\|\ **s**\ [**+l**\|\ **h**]] ]
[ |-G|\ [*grdfile*] ]
[ |-Q| ]
[ |SYN_OPT-V| ]
[ |-W|\ [**i**\|\ **o**][**+s**\|\ **w**] ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ *field*
   指定写入每个网格中的字段，该选项需要 |-G| 选项。其中字段通过字符设置：

   - **z** ：z 值的众数
   - **s** ：众数的 L1 范数
   - **l** ：最小值
   - **h** ：最大值
   - **w** ：权重，见 **-W**

   **s**\|\ **l**\|\ **h** 需要同时设置 |-E| 选项；默认字符为 **z**

.. _-C:

**-C** 
    使用区块的中心作为输出位置，默认使用位置的众数（见 |-Q| ）。|-C| 选项会覆盖
    |-Q|

.. _-D:

**-D**\ [*width*]\ [**+c**][**+a**\|\ **+l**\|\ **+h**]
    通过直方图来计算众数，需设置直方图每个间隔的宽度 *width* 。**+c** 将直方图
    的每个区间放在中间，一遍中间点是 *width* 的倍数。如果发现多个众数，通过设置
    **+a** 可取其平均。**+l** 和 **+h** 分别返回较大的众数和较小的众数。如果
    *width* 未设置，则默认设置为 1。对于整数数据和整数的 *width* ，默认使用
    **+c** 和 **+l** 。众数默认使用 Least Median of Squares 统计。

.. _-E:

**-E**
    输出额外的报告，见 |-A| 。输出顺序为 *x*,\ *y*,\ *z*,\ *s*,\ *l*,\ *h*\ [,\ *w*] 。
    使用 |-W| 可设置输出权重。默认输出为 *x*,\ *y*,\ *z*\ [,\ *w*] 。

**-E**\ **r**\|\ **s**\ [**+l**\|\ **h**]
    **s** 输出原数据 id； **r** 输出数据个数；上述数据将会追加到众数后；
    **+h** 输出前述字段中的最大值[默认]；**+l** 输出前述字段的最小值；
    **E** 选项可以重复使用，因此可以同时指定 **-E**\ [**b**] 和
    **-E**\ **r**\ [**+l**\|\ **h**]。**-Es** 设置时，输入数据的最后一列
    必须为无符号整数，表示数据的 id。

.. _-G:

**-G**\ *grdfile*
    将结果输出为网格；使用该选项时，将不会输出到标准输出。如果输出网格中的
    字段超过一个（|-A|），则网格名必须包含 ``%s`` 以便将字段名写入到网格
    文件名中来区别不同的输出网格。**注** : 使用该选项时不能使用 |-C| 和 |-Q| 选项。

.. _-Q:

**-Q**
    （更快的方法）获取 z 的众数及其对应的位置 [默认分别独立地计算 x 和 y 以及 z 的众数，
    三者都是独立的]。参见 |-C|

.. _-W:

**-W**\ [**i**\|\ **o**][**+s**\|\ **w**]
    计算加权结果。加权结果的输入和输出都为 4 列，输入数据的第 4 列为权重，输出
    数据的第四列为权重的和。使用 **i** 和 **u** 分别表示用于加权输入和加权输出
    [默认不使用不加权的输入和输出]。如果数据权重为不确定度，即一倍中误差，则可以
    追加 **+s** ，则在程序内部，权重定义为 weight = 1/sigma^2 。否则，直接使用
    第四列作为权重。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
----

从 :file:`ship_15.txt` 文件中获取 5 分区块的众数，输出二进制文件，double 精度 ::

    gmt blockmedian @ship_15.txt -R245/255/20/30 -I5m -bo3d > ship_5x5.b

计算每个 2 分的区块中的众数，使用直方图统计得到 ::

    gmt blockmode @ship_15.txt -R245/255/20/30 -I2  -r -C -D

计算 10 分网格中每个网格点的众数以及 L1 范数（MAD），将结果输出为两个网格文件 ::

    gmt blockmode @ship_15.txt -I10m -R-115/-105/20/30 -E -Gfield_%s.nc -Azs

相关模块
--------

:doc:`blockmedian`,
:doc:`blockmean`,
:doc:`gmt:greenspline`,
:doc:`nearneighbor`,
:doc:`sphtriangulate`,
:doc:`surface`,
:doc:`triangulate`
