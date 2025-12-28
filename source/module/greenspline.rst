:author: 朱邓达
:date: 2025-07-15

:reviewer: 周茂

.. index:: ! greenspline
.. program:: greenspline
.. include:: common_SYN_OPTs.rst_

greenspline
===========

:官方文档: :doc:`gmt:greenspline`
:简介: 使用格林函数样条进行插值

语法
--------

**gmt greenspline** [ *table* ]
:option:`-G`\ *grdfile*
[ :option:`-A`\ *gradfile*\ **+f**\ **0**\|\ **1**\|\ **2**\|\ **3**\|\ **4**\|\ **5** ]
[ :option:`-C`\ [[**n**\|\ **r**\|\ **v**]\ *value*\ [%]][**+c**][**+f**\ *file*][**+i**][**+n**] ]
[ |SYN_OPT-D3| ]
[ :option:`-E`\ [*misfitfile*][**+r**\ *reportfile*] ]
[ :option:`-I`\ *xinc*\ [/*yinc*\ [/*zinc*]] ]
[ :option:`-L`\ [**t**][**r**] ]
[ :option:`-N`\ *nodefile* ]
[ :option:`-Q`\ [*az*\|\ *x/y/z*] ]
[ :option:`-R`\ *xmin*/*xmax*\ [/*ymin*/*ymax*\ [/*zmin*/*zmax*]] ]
[ :option:`-S`\ **c**\|\ **l**\|\ **p**\|\ **q**\|\ **r**\|\ **t**\ [*tension*\ [/*scale*]][**+e**\ *limit*][**+n**\ *odd*] ]
[ :option:`-T`\ *maskgrid* ]
[ |SYN_OPT-V| ]
[ :option:`-W`\ [**w**]]
[ :option:`-Z`\ *mode* ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]


描述
--------

**greenspline** 使用格林函数 :math:`g(\mathbf{x}; \mathbf{x}')` 
作为样条在规则[或任意]位置进行插值。适用于 1-D，2-D 或 3-D 的笛卡尔坐标或球面坐标，
样条可以选择最小曲率样条、正则化样条或有张力的连续曲率样条。在数学上，解按以下公式组成

.. math::

    w(\mathbf{x}) = T(\mathbf{x}) + \sum_{j=1}^{n} \alpha_j g(\mathbf{x}; \mathbf{x}_j),

其中 :math:`\mathbf{x}` 为输出坐标，:math:`n` 为点数，:math:`T(\mathbf{x})` 为趋势函数，
:math:`\alpha_j` 为 *n* 个待解的权重。通常，:math:`T(\mathbf{x})` 为线性或平面趋势（笛卡尔）
或平均值（球面），使用最小二乘法将其从数据中去除，从而得到数据残差 
:math:`\Delta w_i = w_i - T(\mathbf{x}_i)` ；然后将它们归一化以保证数值稳定性。
待解权重 :math:`\alpha_j` 则通过精确拟合这些数据残差来求解：

.. math::

    \Delta w(\mathbf{x}_i) = \sum_{j=1}^{n} \alpha_j g(\mathbf{x}_i; \mathbf{x}_j), \quad i = 1,n

得到一个 :math:`n \times n` 的线性系统，从中可解出系数。

如果在曲线或曲面的梯度上 (:option:`-A`) 也有 *m* 个观察到的约束，那么必须添加额外的 *m* 个未知系数，
并使用格林函数的梯度来满足 *m* 个额外的约束：

.. math::

    s(\mathbf{x}_k) = \nabla w(\mathbf{x}_k) \mathbf{n}_k = \sum_{j=1}^{m} \alpha_{j+n} \nabla g(\mathbf{x}_k; \mathbf{x}_j) \mathbf{n}_k, \quad k = 1,m

其中格林函数的梯度与观测到的梯度的单位向量点乘。

最后，除了以上数据约束，格林函数需满足

.. math::

    \nabla^2  \left [ \nabla^2 - p^2 \right ] g(\mathbf{x}; \mathbf{x}') = \delta (\mathbf{x} - \mathbf{x}'),

其中 :math:`\nabla^2` 为拉普拉斯算子，:math:`\delta` 为 Dirac 函数，
:math:`p` 为张力（可选）。这个解提供数据点的精确插值。
或者，用户可以选择执行奇异值分解（SVD）并消除最小特征值的贡献；
这种方法产生一个近似解。在输出时将恢复趋势和归一化因子。

必选选项
--------

.. include:: explain_intables.rst_
..

    其中表数据格式为 **x**, *w* ， **x** 表示坐标位置，
    *w* 表示数据值（对应上面公式中的 :math:`w(\mathbf{x}_i)` ）。

**-G**\ *grdfile*
    输出文件名。

    + 如果设置了 :option:`-R` ， :option:`-I` 和可能的 **-r** ，则输出等距的表数据。
      此时如果不设置 :option:`-G` 则输出到标准输出。
      **注：** 对于 2-D 网格必须设置 :option:`-G` 。
    + 如果设置了 :option:`-T` ，则必须设置 :option:`-G` ，此时输出为 2-D 网格文件。
      仅应用于 2-D 插值。
    + 对于 3-D 网格 （以下称之为 cube）， :option:`-G` 选项是可选的。
      如果要设置 :option:`-G` ， *grdfile* 可以是单个 cube 名称，
      也可以是一个带有 C 格式浮点数标识符的文件名模板，
      这样每一层都被写入一个 2-D 网格文件；
      如果不设置 :option:`-G` ，则将 *(x,y,z,w)* 输出到标准输出。
    + 如果设置了 :option:`-N` ，则输出为 ASCII 格式（或二进制，见 **-bo**）
      的表数据，此时如果不设置 :option:`-G` 则输出到标准输出。

可选选项
--------

.. _-A:

**-A**\ *gradfile*\ **+f**\ **0**\|\ **1**\|\ **2**\|\ **3**\|\ **4**\|\ **5**
    设置曲面梯度 :math:`\mathbf{v} = v \hat{\mathbf{n}}`
    的约束，其中 :math:`v` 为梯度大小，:math:`\hat{\mathbf{n}}`
    为梯度的单位方向向量。
    梯度的方向可以由笛卡尔分量指定
    （要么单位向量 :math:`\hat{\mathbf{n}}` 和大小 :math:`v` 分开指定，
    要么直接指定梯度分量 :math:`\mathbf{v}` ）
    或相对于坐标轴的角度。后跟 ASCII 格式的曲面梯度文件 *gradfile* 。
    可使用 **+f** 选择梯度文件的输入格式：

    + **0** - *x*, :math:`v` ，用于 1-D 数据，因为没有方向，
      故仅需指定梯度大小（斜率）（1-D 数据）。
    + **1** - *x*, *y*, *azimuth*, :math:`v` ，其中 *azimuth* 单位为度，
      从正北方向顺时针测量 （2-D 数据）。
    + **2** - *x*, *y*, :math:`v`, *azimuth* ，其中 *azimuth* 单位为度，
      从正北方向顺时针测量 （2-D 数据）。
    + **3** - **x**, *direction(s)*, :math:`v` ，其中 *direction(s)*  单位为度，
      从水平方向逆时针测量，3-D 则还包括垂直轴 （2-D，3-D 数据）。
    + **4** - **x**, :math:`\mathbf{v}` （2-D，3-D 数据）。
    + **5** - **x**, :math:`\hat{\mathbf{n}}`, :math:`v` （2-D，3-D 数据）。
    
    **注：** 斜率约束不支持与数据约束在同一位置。这一设想尚未实现。

.. _-C:

**-C**\ [[**n**\|\ **r**\|\ **v**]\ *value*\ [%]][**+c**][**+f**\ *file*][**+i**][**+n**]
    求解一个近似的曲面拟合：使用 SVD 求解样条系数的线性系统，消除较小特征值的贡献
    [默认使用 Gauss-Jordan 消去法求解线性系统以精确拟合数据（除非使用 :option:`-W`）]。
    支持设置以下选项和 *value* 来决定保留哪些特征值：

    + **n** - 只保留最大的特征值[all]。可附加 % 以表明以百分比设置 *value* 。
    + **r** - 保留与最大特征值之比小于 *value* 的特征值 [默认选项， *value* = 0] 。
    + **v** - 保留最少所需的特征值，以确保模型方差比是至少达到 *value* 。
      可附加 % 以表明以百分比设置 *value* 。
    
    还支持以下子选项：

    + **+c** - 生成每个特征值贡献的累积和，每个特征值对应一个网格（仅限 2-D）。
    + **+f** - 将特征值保存到 *file* 。
    + **+n** - 搭配 **+f**\ *file* 使用，当特征值保存好后程序停止，不输出曲面。
    + **+i** - 生成每个特征值贡献的增量部分，每个特征值对应一个网格（仅限 2-D）。
    
    **注：** 

    + **+c** 和 **+i** 要求 :option:`-G` 指定的输出文件名中包含 C 格式整数标识符（特征值序号），
      用于定义多个网格的文件名。若不包含，则 GMT 默认在原输出文件名后添加 “_cum_###” 或 “_inc_###” 。
    + 可同时使用这两种修饰符来输出两种类型的网格。

.. include:: explain_-D_cap.rst_

.. _-E:

**-E**\ [*misfitfile*][**+r**\ *reportfile*]
    计算输入数据坐标位置的样条值，并报告误差（以及均值，标准差和 rms ）。
    可指定输出文件名，增加样条值和误差值两列。
    如果使用了 :option:`-C` 并保留了计算过程（即使用了一个或多个 **+c** 和 **+i** ），
    那么将输出一个包含特征值序号、特征值、模型方差百分比和 rms 误差值的表数据。
    如果使用了 :option:`-W` 还将包括 :math:`\chi^2` 。

    + **+r** - 将误差和方差统计数据输出到文件 *reportfile* 。顺序为
      *Data Model Explained(%) N Mean Std.dev RMS* ，
      如果使用了 :option:`-W` 还将在第 8 列加上 :math:`\chi^2` 。
      如果不使用 **+r** ，则这些信息会在 :option:`-V`\ **i** 中报告。

.. _-I:

**-I**\ *xinc*\ [/*yinc*\ [/*zinc*]]
    为每个维度指定等距采样间隔，间隔由斜线分隔。

.. _-L:

**-L**\ [**t**][**r**]
    具体而言，在求解系数之前，要先对数据（以及可能的梯度）进行去趋势
    （即调整 :math:`T(\mathbf{x})` ）和归一化处理。
    调整的顺序始终是固定的，即便未选择某些步骤：

    + 总是先确定数据的平均值，然后将其去除，最后恢复 :math:`\bar{w}` 。
    + **t** - 确定一条线性最小二乘趋势，并从残差数据和斜率中去除该趋势。
      **注：** 对于球面和三维插值，该功能不可用。
    + **r** - 确定最小和最大数据残差的最大绝对值，并根据该范围值对残差数据和斜率进行归一化处理。
    
    在根据残差求出系数后，按照相反的顺序撤销任何归一化和去趋势操作。
    使用 :option:`-L` 并附加 **t** 或 **i** 或两者，以覆盖默认设置。
    如果未给出任何设置，则既不会进行趋势消除也不会进行归一化操作。

.. _-N:

**-N**\ *nodefile*
    包含所需输出位置坐标（ **x** 值）的 ASCII 文件，其第一列（或多列）为坐标值。
    生成的 *w* 值会附加到每个记录中，并写入 :option:`-G` 指定的文件中（如果未指定则写入标准输出）；
    见 **-bo** 选项以实现二进制输出。
    使用 :option:`-N` 可以不必再指定 :option:`-R` 、 :option:`-I` 和 **-r** 选项。

.. _-Q:

**-Q**\ [*az*\|\ *x/y/z*]
    不求解 *w*\ (**x**) ，而对 1-D 解求一阶导数。
    对于 2-D 情况，选择在方位角 *az* 方向上求方向导数，并返回此导数的大小。
    对于 3-D 插值，指定所需向量方向的三个分量（向量使用时会被归一化）

.. include:: explain_-R.rst_
.. 
    
    需配合 :option:`-I` 和可选的 **+r** 使用。

    + **1-D** - *xmin/xmax*
    + **2-D** - *xmin/xmax/ymin/ymax* 或 **-Rg** , **-Rd**
    + **3-D** - *xmin/xmax/ymin/ymax/zmin/zmax*

.. _-S:

**-S**\ **c**\|\ **l**\|\ **p**\|\ **q**\|\ **r**\|\ **t**\ [*tension*\ [/*scale*]][**+e**\ *limit*][**+n**\ *odd*]
    选择样条。有些是 1-D 、 2-D 或 3-D 笛卡尔样条（见 :option:`-Z` ）。
    注意，所有张力值 *tension* 都应是 0 < *tension* < 1 范围内的归一化张力。

    + **c** - 最小曲率样条 [*Sandwell*, 1987] (1-D, 2-D, or 3-D Cartesian spline).
    + **l** - 线性或双线性样条，其插值结果不会超过输入数据范围 (1-D or 2-D Cartesian spline).
    + **p** - 最小曲率样条 [*Parker*, 1994] (球面样条，自动使用 :option:`-Z` ).
    + **q** - 有张力的连续曲率样条 [*Wessel and Becker*, 2008]; 后跟 *tension* 。
      **t** 对应的方法中 :math:`g(\mathbf{x}; \mathbf{x}')` 计算速度较慢（采用的是级数解形式），
      因此在方法 **q** 中先计算出一些值，然后使用三次样条插值查找的方式来代替计算 
      (球面样条，自动使用 :option:`-Z` ).
    + **r** - 有张力的正则化样条 [*Mitasova and Mitas*, 1993]; 后跟 *tension* 和可选的 *scale*
      (2-D or 3-D spline).
    + **t** - 有张力的连续曲率样条 [*Wessel and Bercovici*, 1998]; 
      后跟 *tension* 和可选的 *scale* [默认为平均网格间距]  (1-D, 2-D, or 3-D Cartesian spline).

    **注：** 方法 **q** 还支持一下子选项：

    + **+e** - 有限 Legendre 和包含截断误差 [1e-6] ，用户可指定更小误差 *limit* 而需要更长的运行时间。
    + **+n** - 在样条设置过程中预先计算的点数 *odd* [10001] （必须是奇数）。
    
.. _-T:

**-T**\ *maskgrid*
    （仅适用于 2-D 插值）仅在 *maskgrid* 中那些不等于 NaN 的节点处插值。
    使用 :option:`-T` 可以不必再指定 :option:`-R` 、 :option:`-I` 和 **-r** 选项。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [**w**]
    表示输入最后一列给出了数据的一倍标准差的不确定性，对应权重则与不确定性平方的倒数成正比。
    如果给出的是权重而非不确定性，需在后面加上 **w** ，那么这些权重将直接使用（不进行平方处理）。
    这样就实现了加权最小二乘拟合。请注意，只有在使用 :option:`-C` 时才会有这种效果。
    [默认不使用权重或不确定性]。

.. _-Z:

**-Z**\ *mode*
    设置距离计算的模式，该模式决定了如何计算数据点之间的距离。
    
    模式 0 用于笛卡尔 1-D 样条插值：
    
    + **-Z**\ 0 表示 (*x*) 任意单位，笛卡尔距离。
    
    模式 1-3 用于笛卡尔 2-D 曲面样条插值：
    
    + **-Z**\ 1 表示 (*x*, *y*) 任意单位，笛卡尔距离。
    + **-Z**\ 2 表示 (*x*, *y*) 以度为单位，展平地球距离。
    + **-Z**\ 3 表示 (*x*, *y*) 以度为单位，球面距离（km）。
      如果 :term:`PROJ_ELLIPSOID` 是球面的，则计算大圆弧，否则计算测地线。
    
    模式 4 仅适用于球面曲面样条插值：
    
    + **-Z**\ 4 表示 (*x*, *y*) 以度为单位，使用大圆（或测地线）弧的余弦值。
    
    模式 5 用于笛卡尔 3-D 曲面样条插值：
    
    + **-Z**\ 5 表示 (*x*, *y*, *z*) 任意单位，笛卡尔距离。

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

.. include:: explain_core.rst_

.. include:: explain_help.rst_


1-D 示例
------------

使用 :doc:`math` 生成的高斯随机数据 (*x*, *y*)，保存在 *1D.txt* ，
重采样到 0 到 10 之间，步长 0.1，使用最小曲率样条插值::

    gmt begin 1D
        gmt math -T0/10/1 0 1 NRAND = 1D.txt
        gmt plot -R0/10/-5/5 -JX6i/3i -B -Sc0.1 -Gblack 1D.txt
        gmt greenspline 1D.txt -R0/10 -I0.1 -Sc | gmt plot -Wthin
    gmt end show

使用有张力的样条，张力值 0.7 ::

    gmt begin 1Dt
        gmt plot -R0/10/-5/5 -JX6i/3i -B -Sc0.1 -Gblack 1D.txt
        gmt greenspline 1D.txt -R0/10 -I0.1 -St0.7 | gmt plot -Wthin
    gmt end show

2-D 示例
--------------

使用最小曲率样条插值一个规则笛卡尔网格，输入数据为 *Tabel 5.11* (Davis, 1986)::

    gmt begin 2D
        gmt greenspline @Table_5_11.txt -R0/6.5/-0.2/6.5 -I0.1 -Sc -V -Z1 -GS1987.nc
        gmt plot -R0/6.5/-0.2/6.5 -JX6i -B -Sc0.1 -Gblack @Table_5_11.txt
        gmt grdcontour -C25 -A50 S1987.nc
    gmt end show

使用有张力的笛卡尔样条插值，但只在掩码网格的非 NaN 节点采样::

    gmt greenspline @Table_5_11.txt -Tmask.nc -St0.5 -V -Z1 -GWB1998.nc

使用有张力的笛卡尔正则化样条插值，输出曲面沿 NW 方向的梯度大小::

    gmt greenspline @Table_5_11.txt -R0/6.5/-0.2/6.5 -I0.1 -Sr0.95 -V -Z1 -Q-45 -Gslopes.nc

使用最小曲率的笛卡尔样条插值，输出每个特征值贡献的累计和::

    gmt greenspline @Table_5_11.txt -R0/6.5/-0.2/6.5 -I0.1 -Gcontribution.nc -Sc -Z1 -C+c

使用最小曲率样条插值恢复曲面，输入数据包括一个单一曲面值(*pt.txt*)，以及包括曲面梯度大小和方向的约束
(*slopes.txt*)::

    gmt greenspline pt.txt -R-3.2/3.2/-3.2/3.2 -I0.1 -Sc -V -Z1 -Aslopes.txt+f1 -Gslopes.nc

3-D 示例
--------------

输入数据为 *Tabel 5.23* (Davis, 1986)，包含坐标 *x,y,z* 和氧化铀浓度（以百分比表示），
重采样得到 3-D 的笛卡尔表数据::

    gmt greenspline @Table_5_23.txt -R5/40/-5/10/5/16 -I0.25 -Sr0.85 -V -Z5 > 3D_UO2.txt

将结果保存为一系列的 2-D 网格文件 *lauer_\*z\*.grd* ::

    gmt greenspline @Table_5_23.txt -R5/40/-5/10/5/16 -I0.25 -Sr0.85 -V -Z5 -G3D_UO2_%g.grd

将结果保存为 3-D netCDF 网格::

    gmt greenspline @Table_5_23.txt -R5/40/-5/10/5/16 -I0.25 -Sr0.85 -V -Z5 -G3D_UO2.nc

2-D 球面示例
------------------

在全球 1x1 度网格上复现 *Parker (1994)* 的示例，使用远程数据 *@mag_obs_1990.txt* ::

    gmt greenspline -V -Rg -Sp -Z3 -I1 -GP1994.nc @mag_obs_1990.txt

问题类似但应用 0.85 的张力 ::

    gmt greenspline -V -Rg -Sq0.85 -Z3 -I1 -GWB2008.nc @mag_obs_1990.txt

注意事项
-----------------

#. 对于笛卡尔坐标系的情况，GMT 使用自由空间的格林函数，因此在指定区域的边缘无需应用边界条件。
   对于大多数应用来说，这并无问题，因为该区域通常会根据用户的数据范围进行任意设定。
   然而，如果用户的应用需要特定的边界条件，那么可以考虑使用 :doc:`surface` 来替代。

#. 在所有情况下，插值解是通过对格林函数系数的 *n×n* 双精度矩阵进行求逆来获得的，
   其中 *n* 是数据约束的数量。因此，用户计算机的内存可能会对使用 **greenspline** 
   处理的数据集大小造成限制。建议使用 :doc:`blockmean` 、 :doc:`blockmedian` 或 :doc:`blockmode` 
   对数据进行预处理，以避免混叠，并且还可以控制 *n* 的大小。
   具体来说，如果 *n* = 1024，则仅需要 8 Mb 的内存，但当 *n* = 10240 时，则需要 800 Mb 的内存。
   请注意，**greenspline** 完全支持 64 位标准（如果按此编译的话）。
   对于球面数据，用户可以考虑使用 :doc:`spatial` 最近邻来降采样。

#. 当数据点之间的距离与数据的整体范围相比非常接近时，系数的求逆运算可能会出现数值不稳定的情况。
   为解决此问题，用户可以对数据进行预处理，例如通过对相邻的密集数据点进行平均处理。
   另外，用户还可以通过使用奇异值分解（SVD）并丢弃与最小特征值相关的信息来提高稳定性（见 :option:`-C`）。

#. **-Sq** 中的级数解由 Robert L. Parker (Scripps Institution of Oceanography) 开发，
   对此 GMT 表示衷心的感谢。

#. 如果用户需要通过数据点构建某种 1-D 样条曲线，那么或许可以考虑使用 :doc:`sample1d` 模块。
   它会提供具有标准边界条件的传统样条曲线（例如自然三次样条曲线，该曲线将两端的曲率设为零）。
   相比之下，:doc:`greenspline` 所使用的 1-D 样条曲线（如注释 1 中所解释的）
   并未在数据域的两端指定边界条件。

#. 可能很难确定需要多少个特征值才能实现合适的近似拟合。通过使用 :option:`-C` 选项，用户可以进一步探究这一问题，
   即针对所有截断选择创建解，并根据所使用的特征值数量来估算模型方差和数据误差。
   如此大量的解决方案可以进行动画展示，这样就更便于探索不同解决方案之间的变化，
   并为 :option:`-C` 选项做出恰当的选择。

张力
------------

通常，张力被用于抑制由最小曲率要求所引起的虚假振荡，尤其是在数据中存在快速梯度变化的情况下。
合适的张力只能通过实验来确定。一般来说，非常平滑的数据（例如势场）通常不需要太多（甚至不需要）张力，
而较为粗糙的数据（例如地形）则通常在适度的张力下能更好地进行插值。
在选定最终结果之前，请先尝试不同的值范围。 **注意：** 有张力的正则化样条仅在有限的 *scale* 值范围内稳定；
用户必须通过实验来确定有效范围和有用的设置。有关张力的更多信息，请参阅以下参考文献。

弃用
------------

- 6.3.0: Replace **+m** and **+M** modifiers for :option:`-C`. `#5714 <https://github.com/GenericMappingTools/gmt/pull/5714>`_
- 6.3.0: Use **+n** instead of negative value for :option:`-C` to set dry-run. `#5725 <https://github.com/GenericMappingTools/gmt/pull/5725/>`_

参考文献
-----------------

Davis, J. C., 1986, *Statistics and Data Analysis in Geology*, 2nd
Edition, 646 pp., Wiley, New York,

Mitasova, H., and L. Mitas, 1993, Interpolation by regularized spline
with tension: I. Theory and implementation, *Math. Geol.*, **25**,
641-655.

Parker, R. L., 1994, *Geophysical Inverse Theory*, 386 pp., Princeton
Univ. Press, Princeton, N.J.

Sandwell, D. T., 1987, Biharmonic spline interpolation of Geos-3 and
Seasat altimeter data, *Geophys. Res. Lett.*, **14**, 139-142.

Wessel, P., and D. Bercovici, 1998, Interpolation with splines in
tension: a Green's function approach, *Math. Geol.*, **30**, 77-93,
https://doi.org/10.1023/A:1021713421882.

Wessel, P., and J. M. Becker, 2008, Interpolation using a generalized
Green's function for a spherical surface spline in tension, *Geophys. J.
Int*, **174**, 21-28, https://doi.org/10.1111/j.1365-246X.2008.03829.x.

Wessel, P., 2009, A general-purpose Green's function interpolator,
*Computers & Geosciences*, **35**, 1247-1254, https://doi.org/10.1016/j.cageo.2008.08.012.

相关模块
-------------

:doc:`math`,
:doc:`nearneighbor`,
:doc:`plot`,
:doc:`sample1d`,
:doc:`sphtriangulate`,
:doc:`surface`,
:doc:`triangulate`,
:doc:`xyz2grd`
