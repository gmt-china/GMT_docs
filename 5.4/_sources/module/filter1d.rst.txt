.. index:: ! filter1d

filter1d
========

:官方文档: :doc:`gmt:filter1d`
:简介: 对1D表数据做时间域滤波

该模块用于对多列时间序列数据做时间域滤波。用户需要指定哪一列数据代表时间（即
自变量）。若输入的时间序列是等间隔且无间断或outliers则滤波速度较快。对于有
间断的不等间隔数据，需要使用 ``-L`` 、 ``-Q`` 、 ``-S`` 选项。

必选选项
--------

``-F<type><width>[<mode>][+h]``
    设置滤波器类型

    滤波器分为两大类，卷积滤波器和非卷积滤波器。 ``<type>`` 用于指定滤波器类型，
    ``<width>`` 指定滤波器宽度（单位与时间数据相同）。

    对于卷积滤波器， ``<type>`` 可以取：

    - ``b`` Boxcar: All weights are equal
    - ``c`` Cosine Arch: Weights follow a cosine arch curve
    - ``g`` Gaussian: Weights are given by the Gaussian function
    - ``f`` Custom: Instead of *width* give name of a one-column file with your own weight coefficients.

    对于非卷积滤波器， ``<type>`` 可以取：

    - ``m`` Median: Returns median value
    - ``p`` Maximum likelihood probability (a mode estimator): Return modal value.
      If more than one mode is found we return their average value. Append - or +
      to the filter width if you rather want to return the smallest or largest
      of the modal values.
    - ``l`` Lower: Return the minimum of all values.
    - ``L`` Lower: Return minimum of all positive values only.
    - ``u`` Upper: Return maximum of all values.
    - ``U`` Upper: Return maximum or all negative values only.

    大写的 ``B|C|G|M|P|F`` will use robust filter versions, i.e.,
    replace outliers (2.5 L1 scale off median) with median during filtering.

    In the case of **L**\ \|\ **U** it is possible that no data passes
    the initial sign test; in that case the filter will return 0.0.

    该模块默认对数据进行低通滤波，加上 ``+h`` 选项则对数据进行高通滤波。

选项
----

``-D<increment>``
    当输入的时间序列是不等间隔采样时，需要使用该选项。 ``<increment>`` 为输出
    数据的分辨率，所有横坐标（时间）都会被rounded off到 ``<increment>`` 的整数倍。
    当然，也可以使用 :doc:`sample1d` 对时间序列做重采样。

``-E``
    输出时间序列的首尾端数据。默认情况下，首尾两端都会丢失半滤波器宽度的数据点

``-I<ignore_val>``
    若输出数据等于 ``<ignore_val>`` ，则设置其值为NaN

``-L<lack_width>``
    检查数据间断。若输入数据存在超过 ``<lack_width>`` 的间断，则该数据点不输出值。

``-N<t_col>``
    指定哪一列数据包含自变量（即时间）。默认值为0，即第一列。

``-Q<q_factor>``
    检查输出值的质量因子。

    ``<q_factor>`` 的取值为0到1，若某点的卷积的平均权重小于 ``<q_factor>`` ，
    则该点的输出会被压制。

``-S<symmetry_factor>``
    检查数据关于时间窗中心的对称性。

    ``<symmetry_factor>`` 的取值范围为0到1。若
    ( (abs(n_left - n_right)) / (n_left + n_right) ) > factor，则该点不输出值。

``-T<t_min>/<t_max>/<t_inc>[+n]``
    限定时间范围为 ``<t_min>`` 到 ``<t_max>`` ，时间间隔为 ``<t_inc>`` 。

    ``+n`` 表示 ``<t_inc>`` 代表的是等间隔的时间点数目。

示例
----

数据 ``cruise.gmtd`` 中包含了四列数据，分别是重力、磁场、地形和距离（单位为m），
现对其做10 km Gaussian滤波，去除outliers，并在0到100 km内每2 km输出一个滤波后
的数据点::

    gmt filter1d cruise.gmtd -T0/1.0e5/2000 -FG10000 -N3 -V > filtered_cruise.gmtd

::

    gmt filter1d v3312.dt -FM50 -T0/100000/25 -L10 -S0.3 > v3312_filt.dt
