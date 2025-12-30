:author: 朱邓达, 田冬冬
:date: 2025-07-10

.. index:: ! sample1d
.. program:: sample1d

sample1d
========

:官方文档: :doc:`gmt:sample1d`
:简介: 对 1D 表数据进行重采样

语法
--------


**gmt sample1d** [ *table* ]
[ :option:`-A`\ [**f**\|\ **p**\|\ **m**\|\ **r**\|\ **R**][**+d**][**+l**] ]
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-E` ]
[ :option:`-F`\ **a**\|\ **c**\|\ **e**\|\ **l**\|\ **n**\|\ **s**\ *p*\ [**+d1**\|\ **2**] ]
[ :option:`-N`\ *col* ]
[ :option:`-T`\ [*min/max*\ /]\ *inc*\ [**+a**][**+i**\|\ **n**][**+u**] \| [:option:`-T`\ *file*\|\ *list*]]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *col* ]
[ :option:`-b`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-j`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

描述
-----------    

**sample1d** 从文件（或标准输入）读取一个多列的 ASCII 格式（或二进制）数据，
对时间序列或指定测线点位进行重采样。其中独立变量
（即单调递增或递减的变量，以下称之为 *time* ）
默认位于首列，用户可指定其他列作为独立变量。可以使用等距或其他指定采样。
所有列都将基于新的采样间隔重新采样。除平滑样条 （smoothing spline）方法外，
还可选择多种插值方法。其中，平滑样条通过在拟合误差和曲率之间进行权衡
（即不完全精确拟合数据点以换取更平滑的曲线）来实现平滑效果。
本模块不支持输入数据范围外做外推插值。通过使用 :option:`-C` 指定 CPT，
本模块将基于输入数据最后一列做颜色插值，将 *r,g,b,a* 添加到输出。

必选选项
------------------

.. include:: explain_intables.rst_

可选选项
--------------

.. option:: -A

**-A**\ [**f**\|\ **p**\|\ **m**\|\ **r**\|\ **R**][**+l**]
    关于沿测线进行采样（如果设置了 :option:`-T`\ ...\ *unit* ）的一些选项，在 :option:`-A` 后追加：

    + **f** - 沿测线采样，保留原始点位，按需会适当插值线段中点（默认）。
    + **m** - 类似 **f** ，但测线变为阶梯状，先沿经度采样，再沿纬度采样。
    + **p** - 类似 **f** ，但测线变为阶梯状，先沿纬度采样，再沿经度采样。
    + **r** - 等距采样，此时输入的点位（尤其是端点）可能不会严格包括在输出结果中。
    + **R** - 类似 **r** ，但会适当调整采样点间距使输入点位都在输出结果中。
    
    还支持以下选项：
    
    + **+d** - 删除重复输入记录（即 *time* 没变化）。
    + **+l** - 使地理距离的测量沿着恒向线（rhumb lines 或 loxodromes ，
      即沿着该方向行进时行进方向始终与经线保持相同夹角）而不是默认的大圆弧。
      loxodromes的计算模式是在球面上，故 **+l** 不可与 **-je** 同时使用。

.. include:: dump_rgb.rst_

.. option:: -E

**-E**
    如果输入数据中每行记录最后包含有文本列，输出的插值结果将尝试保留 *time* 
    精确匹配的记录对应的文本列，其它 *time* 不匹配的则没有文本。默认忽略文本列。

.. include:: explain_interpolant.rst_

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_splines.png
   :width: 500 px
   :align: center

   :option:`-F` 选项允许您在多个插值方法中选择，包括一个近似方法（平滑样条）。
   你也可以指定选项来计算导数。

.. option:: -N

**-N**\ *col*
    选择独立变量 *time* 的列索引 *col* ，默认为 0（即首列）。

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+a**][**+i**\|\ **n**][**+u**] \| [**-T**\ *file*\|\ *list*]
    定义要等距采样的 *time* 范围（从 *min* 到 *max* ）和步长 *inc* 
    （默认使用输入的 *time* 值）。用法 **-T**\ *list* 表示指定一系列 *time* 值，
    例如 **-T**\ *13,15,16,22.5* 。具体详见 `生成一维数组`_ 。
    若不使用 :option:`-A` ，默认为 :option:`-A`\ **f** 。 

    **注：** 对于空间 *(x, y)* 或 *(lon, lat)* 序列的重新采样，
    用户必须使用有效的距离单位给出步长，例如 **-T**\ *20k* 。
    关于单位见 `距离单位`_  ，笛卡尔坐标则用单位 **c** 做距离单位。
    此时前两列必须为空间坐标，GMT 将基于前两列空间坐标以及指定的步长沿大圆路径插值。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *col*
    指定列索引值为 *col* 的列作为平滑三次样条的权重， 要求使用 **-Fs** 。

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

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_precision.rst_

.. include:: explain_array.rst_

注意
----
平滑样条 :math:`s(t)` 通过设置拟合因子 :math:`p` 在最小化拟合误差
（完全拟合所有点，对应 :math:`p` 很大）和最小化曲率（ :math:`p` 接近 0）之间进行权衡。
具体而言，我们想要最小化以下泛函

.. math::

    F_p (s)= K (s) + p E (s), \quad p > 0,

其中拟合误差定义为

.. math::

    E (s)= \sum^n_{i=1} \left [ \frac{s(t_i) - y_i}{\sigma_i} \right ]^2

而曲率定义为样条的二阶导数的在区间上的定积分，

.. math::

    K (s) = \int ^b _a [s''(t) ]^2 dt.

可能需要反复试验来选择合适的 :math:`p` 。


示例
----

.. include:: explain_example.rst_

使用 Akima 样条以 1 km 为间隔重采样文件 `profiles.tdgmb`，文件格式为: time, distance, gravity, magnetics, bathymetry ::

    gmt sample1d profiles.tdgmb -N1 -Fa -T1 > profiles_equi_d.tdgmb

使用三次样条插值，在 `grav_pos.dg` 指定的点位上采样文件 `depths.txt` ::

    gmt sample1d depths.txt -Tgrav_pos.dg -Fc > new_depths.txt

将 0 到 6 之间的数据以 0.01 为间隔用三次样条重采样，不输出数据而是输出一阶偏导（即斜率）::

    gmt sample1d points.txt -T0/6/0.01 -Fc+d1 > slopes.txt

测线数据中包含经度、纬度和深度，将其采样为每 2 海里一个点::

    gmt sample1d track.txt -T2n -AR > new_track.txt

同上，但确保包含了原始数据点::

    gmt sample1d track.txt -T2n -Af > new_track.txt

以 5 km 为间隔，沿着恒向线采样 ::

    gmt sample1d track.txt -T5k -AR+l > new_track.txt

在文件 `temperatures.txt` 中采样 2000 年到 2018 年每月温度::

    gmt sample1d temperatures.txt -T2000T/2018T/1o > monthly_temp.txt

在地形剖面上给定拟合因子使用平滑样条插值::

    gmt sample1d @topo_crossection.txt -T300/500/0.1 -Fs0.001 > smooth.txt

相关模块
--------

:doc:`greenspline`,
:doc:`filter1d`
