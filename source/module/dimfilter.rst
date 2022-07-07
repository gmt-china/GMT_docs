.. index:: ! dimfilter
.. include:: common_SYN_OPTs.rst_

dimfilter
=========

:贡献者: |周茂|
:最近更新日期: 2022-07-05

----

:官方文档: :doc:`gmt:dimfilter`
:简介: 在空间域对网格进行方向中值（DIrectional Median, DIM）滤波

**dimfilter** 对空间域（或时间域）中的网格滤波。该模块将滤波范围（圆）划分
为多个扇区，对每个扇区进行一级或者二级滤波，并根据二级滤波选择最终的结果。
这种划分多个扇区的做法与普通中值滤波的区别在于可以避免在具有一定倾斜趋势的
区域中某些特征（以对海底地形滤波为例，特征可能为海山）导致的中值偏离的情况。
输出网格可以使用 |-R| 进行裁剪，或者使用 |-I| 设置新的网格间隔；裁剪可以避
免边缘效应。|-Q| 选项用于误差分析模式并且输入文件中包含滤波深度。
**dimfilter** 不会向其他滤波一样产生平滑的输出，因为其返回 N 个扇区中的 N
个中值中的最小值。除非数据数据中无噪声，否则输出结果可能很不平滑。因此，通
常建议对网格进行一次额外的滤波（例如，使用 :doc:`grdfilter` ）。

语法
----

**gmt dimfilter** *ingrid*
|-D|\ *0-4*
|-F|\ **x**\ *width*\ [*modifier*]
|-G|\ *outgrid*
|-N|\ **x**\ *sectors*\ [*modifier*]
[ |-L| ]
[ |-Q| ]
[ |SYN_OPT-I| ]
[ |SYN_OPT-R| ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_grd_in.rst_

.. _-D:

**-D**\ *flag*
    距离 *flag* 用来设置滤波相关的宽度的单位和类型等信息：

    - *flag* = 0 ：网格(x,y) 的单位和 *width* 相同，使用笛卡尔距离
    - *flag* = 1 ：网格(x,y) 的单位为度，*width* 单位为千米，使用笛卡尔距离
    - *flag* = 2 ：网格(x,y) 的单位为度，*width* 单位为千米，dx 乘以 cos(lat)，
      lat 为所有纬度中值，使用笛卡尔距离
    
    上述计算都狠快，因为只需计算一次权重矩阵。下面的三个选项相对较慢，因为对于
    每个纬度都需重新计算权重矩阵

    - *flag* = 3 ：网格(x,y) 的单位为度，*width* 单位为千米，dx 乘以 cos(lat)，
      lat 为对应的纬度，使用笛卡尔距离
    - *flag* = 4 ：网格(x,y) 的单位为度，*width* 单位为千米，使用球面距离计

.. _-F:

**-F**\ **x**\ *width*\ [**+l**\|\ **u**]
    设置一级滤波类型，可从卷积和非卷积滤波中选择。**x** 为滤波类型代码，后面的
    *width* 为滤波直径。

    其中卷积滤波对应的代码包括：

    - **b** ：Boxcar，即滤波窗口内所有点等权
    - **c** ：Cosine Arch，滤波窗口内的权中为 Cosin 曲线
    - **g** ：Gaussion，权重通过高斯函数给出

    非卷积滤波对应的代码包括：

    - **m** ：Median，返回中值
    - **p** ：Maximum likelihood probability （一种众数估计），返回众数；
      如果存在多个众数，则返回其平均数。追加 **+l** 和 **+u** 可分别选择
      多个众数中的最小值和最大值

.. _-N:

**-N**\ **x**\ *sectors*\ [**+l**\|\ **u**]
    设置二级滤波类型，以及扇区的个数 *sectors* ，扇区个数必须为整数并大于
    0；当扇区格式为 0 时，则不使用二级滤波。

    其中滤波对应的代码包括：

    - **l** ：返回最小值
    - **u** ：返回最大值
    - **a** ：返回平均值
    - **m** ：Median，返回中值；
    - **p** ：Maximum likelihood probability （一种众数估计），返回众数；
      如果存在多个众数，则返回其平均数。追加 **+l** 和 **+u** 可分别选择
      多个众数中的最小值和最大值

.. include:: explain_grd_out.rst_

可选选项
--------

.. include:: explain_-I.rst_

.. _-L:

**-L**
    使用此选项将 dim.template.sh 脚本内容写到标准输出，不与其他选项组合使用

.. include:: explain_-R.rst_

.. _-T:

**-T**
    转换输出网格的配准方式，使其与输入网格相反

.. _-Q:

**-Q**
    

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_help.rst_

.. include:: explain_grd_coord.rst_

示例
----

脚本模版
--------

dim.template.sh 是一个脚本框架，可在其中进行完整的 dim 分析，包括 MAD 分析，
通过 |-L| 选项可以获取。

参考文献
--------

Kim, S.-S., and Wessel, P. (2008), Directional Median Filtering for
Regional-Residual Separation of Bathymetry, *Geochem. Geophys.
Geosyst.*, **9**, Q03005, https://doi.org/10.1029/2007GC001850.

相关模块
--------

:doc:`grdfilter`
