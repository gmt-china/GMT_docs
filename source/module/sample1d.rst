.. index:: ! sample1d

sample1d
========

:官方文档: :doc:`gmt:sample1d`
:简介: 对1D表数据进行重采样

该命令既可以对常规的一维数据（比如时间序列，自变量为时间）进行重采样，也可以
对地理坐标下的测线进行重采样。

可选选项
--------

``<table>``
    多列表数据，其中某一列是自变量，其他列为因变量。自变量所在列必须递增或递减。
    本页面将自变量称为“时间”，因为该命令常用于处理时间序列，实际上自变量可以是
    任意物理量

``-Af|p|m|r|R[+l]``
    指定插值方式。

    - ``-Af`` 保留原始数据点，若有必要，则在原始数据点的中间加上额外的点
    - ``-Am`` 对测线进行采样时，先沿着Y方向，再沿着X方向
    - ``-Ap`` 对测线进行采样时，先沿着X方向，再沿着Y方向
    - ``-Ar`` 等间距采样
    - ``-AR`` 等间距采样，但会调整间距以适应自变量的原始长度
    - ``+l`` if distances should be measured along rhumb lines (loxodromes)

``-Fl|a|c|n[+1|+2]``
    插值方式

    - ``l`` 线性插值
    - ``a`` Akima样条插值
    - ``c`` natural cubic spline
    - ``n`` 不插值，取最近的数据点作为插值后的值
    - ``+1|+2`` 插值的同时计算spline的一阶或二阶插值

``-I<inc>[<unit>]``
    默认的等间隔采样间隔是自变量第一个和第二个数据点的间隔，该选项可以自定义
    采样间隔 ``<inc>`` 。

    加上 ``<unit>`` 表明数据文件的前两列包含经纬度信息，重采样后的测线的采样
    间隔的单位是 ``<units>`` 。若想要采样笛卡尔坐标下的(x,y)，则需要指定单位
    为 ``c`` 。

``-N<knotfile>``
    ``<knotfile>`` 中包含了一系列X坐标轴，使用该选项则会将原始数据插值到这些
    X坐标轴数据点上。

``-S<start>[/<stop>]``
    对于等间隔采样而言， ``<start>`` 是第一个输出值的X位置， ``<stop>`` 是
    最后一个输出值的X位置。

``-T<col>``
    指定输入数据中的哪列数据是自变量。

示例
----

输入数据的格式为::

    time distance gravity magnetics bathymetry

使用Akima spline插值方式将其采样为1千米等间隔::

    gmt sample1d profiles.tdgmb -I1 -Fa -T1 > profiles_equi_d.tdgmb

将0到6之间的数据用cubic spline方式重采样为0.01间隔，不输出数据而是输出一阶偏导（即斜率）::

    gmt sample1d points.txt -S0/6 -I0.01 -Fc+1 > slopes.txt

测线数据中包含经度、纬度和深度，将其采样为每2海里一个点::

    gmt sample1d track.txt -I2n -AR > new_track.dt

同上，但确保包含了原始数据点::

    gmt sample1d track.txt -I2n -Af > new_track.dt

To obtain a rhumb line (loxodrome) sampled every 5 km instead::

    gmt sample1d track.txt -I5k -AR+l > new_track.dt
