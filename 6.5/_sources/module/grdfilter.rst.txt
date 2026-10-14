.. index:: ! grdfilter
.. include:: common_SYN_OPTs.rst_

grdfilter
=========

:贡献者: |周茂|
:最近更新日期: 2022-07-18

----

:官方文档: :doc:`gmt:grdfilter`
:简介: 在空间（或时间）域中对网格滤波

**grdfilter** 使用卷积、非卷积各向同性或矩形滤波器对网格进行滤波。输出网格可以
设置新的区域（|-R|），间隔（|-I|）或者配准方式（|-T|）。这样可以在数据足够
大的情况下，可去掉网格边缘以避免滤波的边缘效应。如果滤波器为低通滤波，则输出结果
的频率可能低于输入的采样频率。**注**：频域（或称波数域）滤波，见 :doc:`grdfft`。

语法
----

**gmt grdfilter** *ingrid* |-D|\ *distance_flag*
|-F|\ **x**\ *width*\ [/*width2*][*modifiers*]
|-G|\ *outgrid*
[ |SYN_OPT-I| ]
[ |-N|\ **i**\|\ **p**\|\ **r** ]
[ |SYN_OPT-R| ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_grd_in.rst_

.. _-D:

**-D**\ *flag*
    距离 *flag* 用来设置滤波相关的宽度的单位和类型等信息：

    - *flag* = p ：网格(px,py) 的单位为像素（ *width* 为奇数），使用笛卡尔距离
    - *flag* = 0 ：网格(x,y) 的单位和 *width* 相同，使用笛卡尔距离
    - *flag* = 1 ：网格(x,y) 的单位为度，*width* 单位为千米，使用笛卡尔距离
    - *flag* = 2 ：网格(x,y) 的单位为度，*width* 单位为千米，dx 乘以 cos(lat)，
      lat 为所有纬度中值，使用笛卡尔距离
    
    上述计算都狠快，因为只需计算一次权重矩阵。下面的三个选项相对较慢，因为对于
    每个纬度都需重新计算权重矩阵

    - *flag* = 3 ：网格(x,y) 的单位为度，*width* 单位为千米，dx 乘以 cos(lat)，
      lat 为对应的纬度，使用笛卡尔距离
    - *flag* = 4 ：网格(x,y) 的单位为度，*width* 单位为千米，使用球面距离计算
    - *flag* = 5 ：网格(x,y) 的单位为墨卡托 **-Jm1** img 单位，*width* 为千米，
      使用球面距离计算

.. _-F:

**-Fx**\ *width*\ [/*width2*][*modifiers*]
    设置滤波类型，可从卷积和非卷积滤波中选择。**x** 为滤波类型代码，后面的
    *width* 为滤波直径，此时进行各向同性滤波；追加 *width2* 以实现不同方向
    不同的滤波长度（需要 **-Dp** 和 **-D0** ）。默认情况下，执行低通滤波。
    追加 **+h** 选项选择高通滤波。对于各向同性滤波，*width* 可以是一个网格
    ，用来提供权重，这种情况下，网格必须与输出网格具有相同的配准。

    其中卷积滤波对应的代码包括：

    - **b** ：Boxcar，即滤波窗口内所有点等权
    - **c** ：Cosine Arch，滤波窗口内的权中为 Cosin 曲线
    - **g** ：Gaussion，权重通过高斯函数给出，其中宽度是传统高斯标准差的 6 倍
    - **f** ：Custom，权重由网格文件 *width* 给出，维度必须为奇数，且需 
      **-D0** ，输出网格的间隔必须与输入一致或为其整数倍
    - **o** ：Operator，权重由网格文件 *width* 给出，维度必须为奇数，且需
      **-D0** ，输出网格的间隔必须与输入一致或为其整数倍。不同之处在于，假定
      权重总和为 0，因此不会进行归一化

    非卷积滤波对应的代码包括：

    - **m** ：Median，返回中值；追加 **+q**\ *quantile* 可选择其他的分位数，
      *quantile* 范围必须在 0-1 之间，默认为 0.5，即中位数
    - **p** ：Maximum likelihood probability （一种众数估计），返回众数；
      如果存在多个众数，则返回其平均数。追加 **+l** 和 **+u** 可分别选择
      多个众数中的最小值和最大值
    - **h** ：Histogram mode（另一种众数估计），返回直方图主峰的中心值，追加
      /*binwidth* 来指定直方图每个分区的间隔。
      如果存在多个众数，则返回其平均数。追加 **+l** 和 **+u** 可分别选择多个
      众数中的最小值和最大值。
    - **l** ：返回最小值
    - **L** ：返回正值中的最小值
    - **u** ：返回最大值
    - **U** ：返回负值中的最大值

    在 **L|U** 情况下，可能最终的结果不存在数据，则范围 NaN。

.. include:: explain_grd_out.rst_

可选选项
--------

.. include:: explain_-I.rst_

.. _-N:

**-N**\ **i**\|\ **p**\|\ **r**
    确定输入网格中的 NaN 值如何处理。

    - **i** 计算过程中忽略所有 NaN 值 [默认]
    - **r** 与 **i** 相同，但如果输出网格与输入配准相同，则在输入网格的 NaN 
      值出现的位置将输出网格对应值也设置为 NaN
    - **p** 如果在滤波搜索范围内出现 NaN 值，则将最终网格点设置为 NaN

.. include:: explain_-R.rst_

.. _-T:

**-T**
    转换网格配准方式。或者使用 **-r**\ [**g**\|\ **p**] 显式指定输出网格的
    配准方式

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

.. include:: explain_grd_coord.rst_

注意事项
--------

#. 使用 **-D5** 选项时，输入墨卡托网格必须由 :doc:`img2grd` 的 **-C** 选项
   生成，因此 y 值的原点为赤道（即 x = y = 0 对应于 lon = lat = 0）
#. |-I| 选项设置的新的 *x\_inc* ， *y\_inc* 如果不是输入数据的间隔的整数倍，
   则滤波会非常慢

示例
----

@earth_relief_05m 为 5 分分辨率的远程 DEM 文件，对该文件使用 300 km 为半径的
中值滤波；输出范围为 150 E 到 250 E，10 N 到 40 N，输出网格大小设置为 0.5 度；
计算过程中使用球面距离 ::

    gmt grdfilter @earth_relief_05m -Gfiltered_pacific.nc -Fm600 -D4 -R150/250/10/40 -I0.5 -V

如果想执行高通滤波 ::

    gmt grdfilter @earth_relief_05m -Gresidual_pacific.nc -Fm600+h -D4 -R150/250/10/40 -I0.5 -V

使用自定义的各向同性滤波器 exp (-0.5\*r^2) 对 ripple.nc 滤波，其中距中心的距离
r 为 (2x^2 + y^2 -2xy)/6 ::

    gmt grdmath -R-10/10/-10/10 -I1 X 2 POW 2 MUL Y 2 POW ADD X Y MUL 2 MUL \
            SUB 6 DIV NEG 2 DIV EXP DUP SUM DIV = gfilter.nc
    gmt grdfilter ripples.nc -Ffgfilter.nc -D0 -Gsmooth.nc -V

相关模块
--------

:doc:`grdfft`,
:doc:`img2grd`
