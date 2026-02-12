:author: 周茂, 陈箫翰
:date: 2026-01-01

.. index:: ! grdfft
.. program:: grdfft

grdfft
======

:官方文档: :doc:`gmt:grdfft`
:简介: 在谱域中对网格进行数学运算

**grdfft** 将会对输入网格实施 2-D FFT 并在频域中进行一种或多种数学运算。在将新的数值
写入到输出文件前，可以使用选项对数据进行缩放。网格的水平维度单位假定为米。地理坐标网
格可以使用 :option:`-f`\ *flags* 选项来将单位从度转换为米。如果输入网格的单位为千米，可以使用
:doc:`grdedit` 转换为米，或使用 :doc:`grdmath` 缩放输出结果。

.. note::

   如果输入文件为netCDF 格式，另一种更加方便的方法是使用 **+s**\ [scale] 对网格文件进行缩放。

语法
----

**gmt grdfft**
*ingrid* [ *ingrid2* ]
:option:`-G`\ *outfile*\|\ *table*
[ :option:`-A`\ *azimuth* ]
[ :option:`-C`\ *zlevel* ]
[ :option:`-D`\ [*scale*\|\ **g**] ]
[ :option:`-E`\ [**r**\|\ **x**\|\ **y**][**+w**\ [**k**]][**+n**] ]
[ :option:`-F`\ [**r**\|\ **x**\|\ **y**]\ *params* ]
[ :option:`-I`\ [*scale*\|\ **g**] ]
[ :option:`-M`\ *mgal_at_45* ]
[ :option:`-N`\ *params* ]
[ :option:`-Q` ]
[ :option:`-S`\ *scale*\|\ **d** ]
[ :option:`-V`\ [*level*] ]
[ :option:`-f`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_grd_in.rst_
..

    对于交叉谱计算，必须同时给定第二个网格文件 *ingrid2*。

必须选项
--------

.. option:: -G

**-G**\ *outfile*\|\ *table*
    输出网格文件名或一维谱的表数据文件名（见 :option:`-E` ）。该选项对 :option:`-E` 选项是可选
    的，因为其默认输出到标准输出。但如果输出网格，则该选项是必须的。

可选选项
--------

.. option:: -A

**-A**\ *azimuth*
    计算方位角为 *azimuth* 方向的导数。方位角单位为度，从北向顺时针度量

.. option:: -C

**-C**\ *zlevel*
    将数据向上（*zlevel* > 0）或向下（*zlevel* < 0）延拓 *zlevel* 米

.. option:: -D

**-D**\ [*scale*\|\ **g**]
    对场求垂直梯度，即对网格 grid *z* 求 :math:`\frac{\partial}{\partial z}` ，
    等价于在频域中乘以 :math:`k_r` （ :math:`k_r` 为径向波数）。
    若指定 *scale* 参数，则用 :math:`k_r \cdot`\ *scale* 代替 :math:`k_r` [默认没有 *scale*]。
    可选的 **g** 参数表明输入数据为大地水准面，单位为米，输出结果为重力异常，单位为毫伽 (mGal)。

.. option:: -E

**-E**\ [**r**\|\ **x**\|\ **y**][**+w**\ [**k**]][**+n**]
    估计径向或水平方向的功率谱，不创建网格文件。

    如果提供了一个网格文件，则将 *f* （即频率或波数）、power[*f*] 以及 power[*f*] 的 1 倍标准差写入由 :option:`-G` 指定的文件 [默认为标准输出]。

    如果提供了两个网格文件，将写入 *f* 和 8 个量：Xpower[*f*]、Ypower[*f*]、相干功率coherent power[*f*]、噪声功率noise power[*f*]、
    相位phase[*f*]、导纳admittance[*f*]、增益gain[*f*]、相干性coherency[*f*]。
    每个量后面都跟着其自身的 1 倍标准差误差估计值，因此输出共有 17 列。

    通过选择以下指令之一来选择谱类型：

    - **r** 选择径向谱 [默认]。
    - **x** 改为计算 *x* 方向的谱。
    - **y** 改为计算 *y* 方向的谱。

    有两个修饰符可用于进一步调整输出：

    - **+w** 写入波长 *w* 而非频率 *f*；如果是地理网格，还可以附加 **k**，将波长从米 [默认] 缩放为千米 (km)。
    - **+n** 归一化谱，以便报告每个频率的平均谱值 [默认情况下，谱是通过对多个频率求和得到的]。

.. option:: -F

**-F**\ [**r**\|\ **x**\|\ **y**]\ *params*
    对输入网格滤波。**x** 和 **y** 表示分别只在 *x* 和 *y* 方向滤波，默认为
    **r** ，即网格具有各向同性，在 *x* 和 *y* 方向同时滤波。
    滤波方法包括：

    Cosin-taper 滤波：
        指定 4 个波长 *lc*/*lp*/*hp*/*hc* （单位设置见 :option:`-f`\ *flags* ) 设计一个
        带通滤波：
        大于 *lc* 以及小于 *hc* 波长的部分将被截断；大于 *lp* 以及小于 *hp*
        波长的部分则会通过，波长位于中间的部分则被 cos tapering。例如：
        :option:`-F`\ 1000000/250000/50000/10000。 :option:`-f`\ *flags* 将会滤掉波长大于
        1000 km 以及小于 10 km 的部分；大于 50 km 以及小于 250 km 波长的部分
        则会被留下。
        如果想设计为高通或者低通滤波，则分别将 *hp*/*hc* 或者 *lc*/*lp* 中的
        值设置为 (-)。例如：**-Fx**-/-/50/10 将会对 x 方向进行低通滤波，其中
        大于 50 的部分将保持不变，小于 10 的部分被滤除，10~50 中间的部分则被
        taper。**-Fy**\ 1000/250/-/- 将会对 y 方向进行高通滤波，小于 250 的
        部分将被保留，大于 1000 的部分被滤除。

    高斯滤波：
        包含两个参数 *lo*/*hi* ，波长的单位见 :option:`-f`\ *flags* 。在给定的波长处，
        高斯滤波的权重为 0.5。设计高通或者低通滤波即将对应的参数设置为 (-)。
        例如：:option:`-F`-/30 将对数据进行低通滤波，在 30 处权重设置为 0.5。
        :option:`-F`\ 400/- 为高通滤波。

    巴特沃斯滤波：
        包含三个参数 *lo*/*hi*/*order* ，波长单位见 :option:`-f`\ *flags* ，*order* 为
        滤波的阶数，必须为整数。在给定的截止频率处，权重设置为 0.707 （the
        power spectrum will therefore be reduced by 0.5）。设计高通或者低通
        滤波即将对应的参数设置为 (-)。例如：:option:`-F`-/30/2 将会使用 2 阶巴特沃斯
        低通滤波，在波长为 30 处设置为一般权重，:option:`-F`\ 400/-/2 为 2阶巴特沃斯
        高通滤波。

.. option:: -I

**-I**\ [*scale*\|\ **g**]
    对场进行积分，即 :math:`\int z(x,y) dz`。
    该操作相当于在频域中除以 :math:`k_r` （ :math:`k_r` 为径向波数）。
    追加 *scale* 时则会除以 :math:`k_r \cdot`\ *scale* [默认没有 *scale*]。
    **g** 选项表明输入数据为以毫伽 (mGal)为单位的重力异常，并且输出结果为以米为单位的大地水准面。

.. option:: -M

**-M**\ *mgal_at_45*
    指定 45 度纬度处的重力值，单位为毫伽 (mGal)（用于将重力异常转换为大地水准面高度）。
    默认值为 980619.9203 mGal（Moritz 1980 年国际重力公式值）。在使用来自其他行星的数据时，需要相应地更改此值。

.. include:: explain_fft.rst_

.. option:: -Q

**-Q**
    不进行波数操作。当只需输出二维谱时和 :option:`-N` 选项同时使用，通常用于输出中间结果。

.. option:: -S

**-S**\ *scale*\|\ **d**
    在空间域中将每个元素乘以 *scale* （频域操作后）[默认值为 1.0]。可选的 **d**
    参数可以将垂线偏差从弧度转换为微弧。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

网格距离单位
------------

如果网格在水平方向的单位不为米，则使用 **+u**\ *unit* 指定输入单位，并在计算
中自动转换为米。如果网格为地理坐标，使用 :option:`-f`\ *flags* 将单位转换为米。

注意事项
--------

NetCDF 网格将被自动识别为地理网格。如果数据靠近极点，则应考虑使用
:doc:`grdproject` 将其投影后再进行本模块操作。

数据去趋势
----------------

默认的去趋势模式是移除一个最佳拟合的线性平面 (**+d**)。使用 :option:`-N` 来选择其他模式。

谱归一化
--------

默认情况下，:option:`-E` 返回的谱只是简单地加和，即对于 x 或 y 方向谱，将另一个
方向上的谱相加。对于径向谱，则意味着在二维谱中，将所有方向的对应频率的值
相加。这种加和做法对于白噪声过程来说，会得到一个与波数正相关的线性径向
谱。通过 **+n** 选项则计算每个频率的平均结果，这样会保证白噪声过程最终仍
能得到一个白化的径向谱（即在谱图中为一条平行于频率轴的直线）。

示例
----

.. include:: explain_example.rst_

从远程 @white_noise.nc 文件中去均值，并计算归一化后的径向谱::

    gmt grdfft @white_noise.nc -Er+n -N+a > spectrum.txt

将文件 mag_0.nc 中位于海平面的磁异常向上延拓到海拔 800 米的面::

    gmt grdfft mag_0.nc -C800 -V -Gmag_800.nc

将以米为单位的大地水准面地理网格（geoid.nc）转换到自由空气重力异常，结果单位为毫伽::

    gmt grdfft geoid.nc -Dg -V -Ggrav.nc

将重力异常（faa.nc）转换为 38 方位角方向上的垂线偏差，重力异常单位为毫伽，垂线偏差单位为
微弧。首先要将重力积分计算大地水准面，然后计算方向梯度，最后缩放弧度到微弧::

    gmt grdfft faa.nc -Ig -A38 -S1e6 -V -Gdefl_38.nc

重力异常的二阶导数和重力场的曲率有关，可以通过下面命令得到，结果单位为 mGal/m^2 ::

    gmt grdfft gravity.nc -D -D -V -Ggrav_2nd_derivative.nc

计算同样配准方式的海底地形和海洋重力场网格的交叉谱，并将结果以波长（单位：千米）的
形式输出::

    gmt grdfft bathymetry.nc gravity.grd -E+wk -fg -V > cross_spectra.txt

将 topo.nc 进行去均值，边界点镜像对称 padding 以及 tapering，进行 FFT 后，在 topo.nc 中保存计算
的谱的实部和虚部::

    gmt grdfft topo.nc -N+w+z -fg -V -Q

接下来可以使用 topo_taper.nc，topo_real.nc 以及 topo_imag.nc 绘图。

相关模块
--------

:doc:`grdedit`,
:doc:`grdfilter`,
:doc:`grdmath`,
:doc:`grdproject`,
:doc:`gravfft`
