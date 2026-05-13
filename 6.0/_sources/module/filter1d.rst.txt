.. index:: ! filter1d
.. include:: common_SYN_OPTs.rst_

filter1d
========

:官方文档: :doc:`gmt:filter1d`
:简介: 对1D表数据做时间域滤波

**filter1d** 用于对多列时间序列数据做时间域滤波。用户需要指定哪一列数据代表时间（即
自变量）。若输入的时间序列是等间隔且无间断或outliers则滤波速度较快。对于有
间断的不等间隔数据，需要使用 **-L** **-Q** 或 **-S** 选项。

对于空间序列数据，提供了一个选项用于计算沿着测线的距离，并以此作为滤波的自变量。

语法
----

**gmt filter1d** [ *table* ] |-F|\ *type<width>*\ [*modifier*]
[ |-D|\ *increment* ] [ |-E| ]
[ |-L|\ *lack\_width* ] [ |-N|\ *t\_col* ] [ |-Q|\ *q\_factor* ]
[ |-S|\ *symmetry\_factor* ]
[ |-T|\ [*min/max*\ /]\ *inc*\ [**+e**\|\ **+a**\|\ **n**] \|\ |-T|\ *file*\|\ *list* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. _-F:

**-F**\ **type**\ *width*\ [*modifier*]
    设置滤波器类型

    滤波器分为两大类，卷积滤波器和非卷积滤波器。
    *type* 用于指定滤波器类型，
    *width* 指定滤波器宽度（单位与时间数据相同）。

    对于卷积滤波器，\ *type* 可以取：

    - **b** Boxcar: 所有权重相同
    - **c** Cosine Arch: 权重为cosine曲线
    - **g** Gaussian: 权重为高斯函数
    - **f** Custom: 不指定 *width* 而是给定一个含单列数据的文件，以指定权重系数

    对于非卷积滤波器，\ *type* 可以取：

    - **m** Median: 返回中位数
    - **p** Maximum likelihood probability (a mode estimator): Return modal value.
      If more than one mode is found we return their average value. Append - or +
      to the filter width if you rather want to return the smallest or largest
      of the modal values.
    - **l** Lower: 返回所有值中的最小值
    - **L** Lower: 返回所有正值中的最小值
    - **u** Upper: 返回所有值中的最大值
    - **U** Upper: 返回所有负值中的最大值

    大写的 **B|C|G|M|P|F** 会使用健壮滤波器。即在滤波时会将outliers替换为中位数。
    outliers 定义为偏离中位数 2.5 倍的 L1 sacle （1.4826倍的Median absolute deviation）。

    对于 **L**\|\ **U** 可能会出现没有数据大于或小于0，此时滤波器会返回0.0。

    该模块默认对数据进行低通滤波，加上 **+h** 选项则对数据进行高通滤波。

选项
----

.. include:: explain_intables.rst_

.. _-D:

**-D**\ *increment*
    当输入的时间序列是不等间隔采样时，需要使用该选项设置输出数据的分辨率 *increment*\ 。
    所有横坐标（时间）都会被rounded off到 *increment* 的整数倍。
    当然，也可以使用 :doc:`sample1d` 对时间序列做重采样。

.. _-E:

**-E**
    输出时间序列的首尾端数据。默认情况下，首尾两端都会丢失半滤波器宽度的数据点

.. _-L:

**-L**\ *lack_width*
    检查数据间断。若输入数据存在超过 *lack_width* 的间断，则该数据点不输出值。

.. _-N:

**-N**\ *t_col*
    指定哪一列数据包含自变量（即时间）。默认值为0，即第一列。

.. _-Q:

**-Q**\ *q_factor*
    通过检查卷积过程中的平均权重以评估输出值的质量因子。

    *q_factor* 的取值为0到1，若某点的卷积的平均权重小于 *q_factor* 则不输出该点。

.. _-S:

**-S**\ *symmetry_factor*
    检查数据关于时间窗中心的对称性。

    *symmetry_factor* 的取值范围为0到1。
    若 ( (abs(n_left - n_right)) / (n_left + n_right) ) > factor，则该点不输出值。

.. _-T:

**-T**\ [*min/max*\ /]\ *inc*\ [**+e**\|\ **+a**\|\ **n**] \|\ |-T|\ *file*\|\ *list*
    生成时间序列

    生成从 *min* 到 *max* 间隔为 *inc* 的等间隔数列。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

相关模块
--------

:doc:`gmt` ,
:doc:`sample1d`,
:doc:`splitxyz`
