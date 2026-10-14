.. index:: ! block_median 
.. include:: common_SYN_OPTs.rst_

blockmedian
===========

:贡献者: |周茂|
:最近更新日期: 2022-10-23

----

:官方文档: :doc:`gmt:blockmedian`
:简介: 使用中值估计对表数据做区域处理 

**blockmedian** 读取 xyz 形式的表数据（或可在最后加一列权重）, 并对 |-R| 和 |-I| 定义
的每个区块输出一个中间的位置和值到标准输出。使用 |-G| 可直接输出为网格文件。在进行
:doc:`surface` 模块时，为避免短波信号混淆，应提前使用 :doc:`blockmedian` ，**blockmedian**
, 或 :doc:`blockmode` 。这些操作在用来抽稀数据或者平均数据时很有用。用户可通过设置
:term:`FORMAT_FLOAT_OUT` 参数设置输出数据有效数字以避免精度损失。

语法
----

**gmt blockmedian** [ *table* ]
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ *fields* ]
[ |-C| ]
[ |-E|\ [**b**\|\ **r**\|\ **s**\ [**+l**\|\ **h**]] ]
[ |-G|\ [*grdfile*] ]
[ |-Q| ]
[ |-T|\ *quantile* ]
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

   - **z** ：z 值的中值，见 **-T**
   - **s** ：中值的 L1 范数（即 1.4826 \* 中位数绝对偏差）
   - **l** ：最小值
   - **h** ：最大值
   - **q25** ：25% 分位数
   - **q75** ：75% 分位数
   - **w** ：权重，见 **-W**

   **l**\|\ **q25**\|\ **q75**\|\ **h** 需要同时设置 **-Eb** 选项；
   默认字符为 **z**

.. _-C:

**-C** 
    使用区块的中心作为输出位置，默认使用中间位置

.. _-E:

**-E**\ [**b**] 
    输出额外的报告，见 |-A| 。输出顺序为 *x*,\ *y*,\ *z*,\ *s*,\ *l*,\ *h*\ [,\ *w*]，
    默认输出为 *x*,\ *y*,\ *z*\ [,\ *w*] 。
    使用 |-W| 可设置输出权重。
    使用 **-Eb** 时，输出顺序为 *x*,\ *y*,\ *z*,\ *l*,\ *q25*,\ *q75*,\ *h*\ [,\ *w*]

**-E**\ **r**\|\ **s**\ [**+l**\|\ **h**]
    **s** 输出原数据 id； **r** 输出数据个数；上述数据将会追加到中值后；
    **+h** 输出前述字段中的最大值[默认]；**+l** 输出前述字段的最小值；
    **E** 选项可以重复使用，因此可以同时指定 **-E**\ [**b**] 和
    **-E**\ **r**\ [**+l**\|\ **h**]。**-Es** 设置时，输入数据的最后一列
    必须为无符号整数，表示数据的 id。

.. _-G:

**-G**\ *grdfile*
    将结果输出为网格；使用该选项时，将不会输出到标准输出。如果输出网格中的
    字段超过一个（|-A|），则网格名必须包含 ``%s`` 以便将字段名写入到网格
    文件名中来区别不同的输出网格。**注** : 使用该选项时不能使用 |-C| 和
    |-Q| 选项。

.. _-Q:

**-Q**
    （更快的方法）获取中值 z 及其对应的位置 [默认分别独立地计算 x 和 y 以及 z 的中值，
    三者都是独立的]。参见 |-C|

.. _-T:

**-T**\ *quantile*
    设置分位数 [默认为 0.5，及中值]，*quantile* 必须大于 0 小于 1

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

从 :file:`ship_15.txt` 文件中获取 5 分区块的中值，输出二进制表数据，
double 类型精度 ::

    gmt blockmedian @ship_15.txt -R245/255/20/30 -I5m -bo3d > ship_5x5.b

计算箱线图所需的分位数，计算结果为 5 度分辨率，输出结果为文本文件 ::

    gmt blockmedian @mars370.txt -Rg -I5 -Eb -r > mars_5x5.txt

在 10 分的区块中计算中值和 L1 范数（MAD），并将结果保存为两个网格文件 ::

    gmt blockmedian @ship_15.txt -I10m -R-115/-105/20/30 -E -Gfield_%s.nc -Azs

相关模块
--------

:doc:`blockmean`,
:doc:`blockmode`,
:doc:`gmt:greenspline`,
:doc:`nearneighbor`,
:doc:`sphtriangulate`,
:doc:`surface`,
:doc:`triangulate`
