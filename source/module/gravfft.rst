.. index:: ! gravfft
.. include:: common_SYN_OPTs.rst_

gravfft
=======

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/gravfft`
:简介: 网格重力的谱计算，均衡，导纳，以及相干性计算

**gravfft** 包括 3 种模式。

- 模式 1：简单地计算地形网格导致的位变化。需要 |-D| 选项给出密度差
  （相对密度），以及 |-W| 选项给出参考基准面（观测高度）。该模式将
  对地形网格执行 2—D FFT 并使用指定阶的 Parker 展开式计算。

- 模式 2：计算地形引起的挠曲响应（挠曲量）。该模式对网格进行 2—D FFT ，
  基于选定的均衡模型计算。其中载荷可以从上部加载（即地形）也以可以从
  底部加载（热点等）。在两种情况下，使用 |-T| 以及 |-Z| 设置参数。

- 模式 3：计算导纳或者相干函数（相干谱），结果为径向平均。该模式较为
  复杂，请参照 `示例`_ 理解。

语法
----

**gmt gravfft** *ingrid* [ *ingrid2* ]
|-G|\ *outgrid*
[ |-C|\ *n/wavelength/mean\_depth*/**t**\|\ **b**\|\ **w** ]
[ |-D|\ *density*\|\ *rhogrid* ]
[ |-E|\ *n_terms* ]
[ |-F|\ [**f**\ [**+s**]\|\ **b**\|\ **g**\|\ **v**\|\ **n**\|\ **e**] ]
[ |-I|\ **w**\|\ **b**\|\ **c**\|\ **t**\|\ **k** ]
[ |-N|\ *params* ]
[ |-Q| ]
[ |-S| ]
[ |-T|\ *te/rl/rm/rw*\ [*/ri*]\ [**+m**] ]
[ |SYN_OPT-V| ]
[ |-W|\ *wd*\ [**k**] ]
[ |-Z|\ *zm*\ [*zl*] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*ingrid*\ [=\ *ID*\|\ ?\ *varname*][**+b**\ *band*][**+d**\ *divisor*][**+n**\ *invalid*][**+o**\ *offset*][**+s**\ *scale*]
    输入网格名。对于交叉谱计算，还需要指定第二个网格。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*][**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**][:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格名，计算实体对该网格内的点的异常值。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

可选选项
--------

.. _-C:

**-C**\ *n/wavelength/mean\_depth*/**t**\|\ **b**\|\ **w**
    只计算所选模型的理论导纳曲线并退出。*n* 和 *wavelength* 用于确定
    （ n \* wavelength）总的波长范围，最小波长为 *wavelength* 以 m 为单位，
    见 `示例`_ 中最后一个例子。
    *mean_depth* 为平均水深。**t** 表示使用从上面加载的模型, **b** 表示使用
    底部加载模型。使用 **w** 可输出波长而不是频率（波数）。

.. _-D:

**-D**\ *density*\|\ *rhogrid*
    设置密度对比值（密度差）。例如，计算水层的重力，随后可以与自由空
    气重力异常相结合，得到布格异常，这种情况下，请不要使用 |-T| ，同时默认
    使用 **-N+h** 。
    该选项还可指定一个密度差网格 *rhogrid* ，其必须与输入网格具有相同的配准
    方式，网格中的 NaN 将被替换为网格中的最小密度差。

.. _-E:

**-E**\ *n_terms*
    Parker 展开式中使用的阶数（即指数的值），最大为 10，默认为 3。

.. _-F:

**-F**\ [**f**\ [**+s**]\|\ **b**\|\ **g**\|\ **v**\|\ **n**\|\ **e**]
    指定需计算的参量，默认为自由空气重力异常

    - **f** 自由空气重力异常，单位 mgal。**+s** 表示从地形中删除平均值，
      表明为 0 地形，即不存在质量异常

    - **b** 布格重力异常，单位 mgal

    - **g** 大地水准面异常，单位 m

    - **v** 垂直重力梯度, 单位 1 Eotvos = 0.1 mgal/km

    - **e** 垂线偏差东向分量，单位为微弧度

    - **n** 垂线偏差北向分量，单位为微弧度

.. _-I:

**-I**\ **w**\|\ **b**\|\ **c**\|\ **t**\|\ **k**
    计算相干函数（相干谱）或导纳，输入必须为两个网格文件，输出到标准输出。
    其中第二个网格应为与第一个网格同一范围的重力或者大地水准面。默认计算
    导纳。输出结果为 3 列或者 4 列，分别为：频率（波长），导纳（相干函数）
    ，误差（1 倍）以及可选的理论导纳。追加子选项可进行详细设置：

    - **w** 输出波长，而不是频率（或称波数）

    - **k** 设置波长的单位为千米，默认为 m

    - **c** 计算相干谱而不是导纳

    - **b** 输出第四列，其为底部加载的理论导纳

    - **t** 同为理论导纳，但为从顶部加载的弹性板理论导纳

.. include:: explain_fft.rst_

.. _-Q:

**-Q**
    输出具有形变的地形网格，z 轴向上，其平均深度由 **-Z**\ *zm* 指定，模型
    参数由 |-T| 设置。这就是 "gravimetric Moho"。该选项默认使用 **-N+h**

.. _-S:

**-S**
    基于理论模型，计算由测深作为载荷产生的重力以及大地水准面网格。相关参数
    需要在 |-T| 和 |-Z| 中设置。Parker 展开式的阶数设置为 1，见下面的 `示例`_

.. _-T:

**-T**\ *te/rl/rm/rw*\ [*/ri*]\ [**+m**]
    计算输入的地形载荷在厚度为 *te* 的弹性板的情况下造成的均衡补偿。*rl*，
    *rm*，*rw* 以及 *ri* 分别为载荷、地幔、海水以及填充物的密度，使用 SI 单位。
    如果不指定 *ri* ，则其等于 *rl* 。使用 |-Z| 设置地幔平均深度。如果弹性板
    厚度 *te* 大于 1e10，则将被解析为抗扰刚度。**+m** 选项用来输出带有 Moho
    面效应的网格，见 |-F| 。如果 *te* = 0，则响应函数变为 Airy 模型。使用
    **-T+m** 时会默认设置 **-N+h**

.. _-W:

**-W**\ *wd*\ [**k**]
    以 m 为单位设置相对于地形的水深，即观测高度

.. _-Z:

**-Z**\ *zm*\ [*zl*]
    Moho [and swell] 平均补偿深度，以 m 为单位，向下为正。对于从上面加载的
    情况，只需提供 *zm* ，对于底部加载，还要设置 *zl*

.. include:: explain_-V.rst_

|SYN_OPT-f|
    地理坐标网格将会在平地球近似下将坐标单位转换为 m

.. include:: explain_help.rst_

网格距离单位
------------

如果输入的笛卡尔网格的水平方向距离的单位不是米，可以通过对输入文件名
**+u**\ *unit* 来将指定的单位转换为米。例如：对输入文件 **+uk** 将会把
输入网格的 x 和 y 坐标的单位从 km 转换为 m。如果输入网格为地理网格，可以
通过 |SYN_OPT-f| 将单位转换为米

注意事项
--------

NetCDF COARDS 网格将会被自动识别为地理网格。对于其他格式的地理网格，可使用
|SYN_OPT-f| 将单位转换为 m。如果地理网格接近两级，则应考虑使用
:doc:`grdproject` 投影后计算。

Plate Flexure
-------------

弹性板的变形中使用了 FFT 解，需要填充密度等于载荷密度（见 :doc:`grdflexure` ）。
这种情况通常填充物位于载荷的下方，如果填充物超过载荷的高度，则填充物通常是
密度较低的沉积物，或者是水/空气。Wessel(2001) 提出了一种近似方法，允许指定
不同于载荷的填充物密度，同时仍能使用 FFT 解。其思想为使用填充物密度作为载荷
密度，但振幅通过一个系数 A = sqrt ((rm - ri)/(rm - rl)) 来调整，即对于点载荷
使用不同密度导致的理论差异。这种近似在刚度较小的板上存在较大的载荷时会失效，
其他情况表现都很好，且上述失效的情况也并不常见。

示例
----

（1）
假设地壳和海水的密度分别为 2700 和 1035，计算海底地形上的海水的影响，将结果写入
到 :file:`water_g.grd` （Paker 公式计算到 4 阶） ::

    gmt gravfft bat.grd -D1665 -Gwater_g.grd -E4

然后在自由空气重力异常 :file:`faa.grd` 中减去该结果即得到布格重力异常 ::

    gmt grdmath faa.grd water_g.grd SUB = bouguer.grd

对上面计算过程做简单解释：
这里使用减而不是加的原因为，布格异常假定改正了水层导致的质量亏损，所以应该加
water_g.grd，因为水的密度比下面的岩石小。

接下来计算地壳地幔的贡献，并叠加到海底异常中。假定地壳厚度为 6 km，密度为
2700，地幔密度为 3300；可以重复使用用于计算水层异常的命令，但密度对比设置
为 600。但上述计算需要提前知道平均 Moho 面深度，可以通过对网格进行一定的
缩放或者偏移实现。这里需要注意偏移的符号，因为 z 轴向上为正 ::

    gmt gravfft bat.grd=+o-6000 -D600 -Gmoho_g.grd

接下来，将其从布格重力异常中减去即得到地幔布格重力异常 ::

    gmt grdmath bouguer.grd moho_g.grd SUB = mba.grd

（2）
计算平均深度为 7 km，密度为 2700 的弹性板上地形加载的影响，地幔平均深度为 9 km，
密度为 3300 ::

    gmt gravfft bat.grd -Gelastic.grd -T7000/2700/3300/1035+m -Z9000

如果考虑海底以及 Moho 面效应，则获得完整的均衡模型重力响应，这里仅使用 Parker
展开式中的第一项 ::

    gmt gravfft bat.grd -D1665 -Gwater_g.grd -E1
    gmt gravfft bat.grd -Gelastic.grd -T7000/2700/3300/1035+m -Z9000 -E1
    gmt grdmath water_g.grd elastic.grd ADD = model.grd

使用下面的命令可以得到与上面同样的结果 ::

    gmt gravfft bat.grd -Gmodel.grd -T7000/2700/3300/1035 -Z9000 -E1

**注** ：不知是由于 bug 或是某些限制，上面两种计算中，使用 **-E1** 时结果是相同
的，但是对于大于 1 的情况，结果则不同，第一种方法是对的，第二种方法则存在问题。

（3）
假定存在一个隆起，其深度为 50 km，上部平均补偿面深为 9 km，计算其产生的大地水准面
异常 ::

    gmt gravfft topo.grd -Gswell_geoid.grd -T7000/2700/3300/1035 -Fg -Z9000/50000 -S -E1

（4）
计算测深网格 :file:`topo.grd` 和 自由空气重力异常网格 :file:`faa.grd` 之间的导纳，
假定地壳有效弹性厚度为 10 km，平均补偿深度为 9 km，并输出从上部加载的理论导纳 ::

    gmt gravfft topo.grd faa.grd -It -T10000/2700/3300/1035 -Z9000

（5）
计算测深网格以及大地水准面网格之间的导纳，且存在一定的底部加载，该加载下补偿面深度为
40 km，上补偿面深度为 9 km，并在计算结果中输出波长而不是频率 ::

    gmt gravfft topo.grd geoid.grd -Ibw -T10000/2700/3300/1035 -Z9000/40000 -fg

（6）
计算重力理论导纳，其存在底部加载，参数如上，结果结果波长范围为 2000 km，最小波长为
500 km ::

    gmt gravfft -C400/5000/3000/b -T10000/2700/3300/1035 -Z9000/40000

参考文献
--------

Luis, J.F. and M.C. Neves. 2006, The isostatic compensation of the
Azores Plateau: a 3D admittance and coherence analysis. J. Geothermal
Volc. Res. Volume 156, Issues 1-2, Pages 10–22,
`https://doi.org/10.1016/j.jvolgeores.2006.03.010 <https://doi.org/10.1016/j.jvolgeores.2006.03.010>`_

Parker, R. L., 1972, The rapid calculation of potential anomalies, Geophys. J., 31, 447–455.

Wessel. P., 2001, Global distribution of seamounts inferred from gridded Geosat/ERS-1 altimetry,
J. Geophys. Res., 106(B9), 19,431–19,441,
`https://doi.org/10.1029/2000JB000083 <https://doi.org/10.1029/2000JB000083>`_

相关模块
--------

:doc:`gmt:grdfft`,
:doc:`gmtflexure`,
:doc:`grdflexure`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`,
:doc:`grdseamount`,
:doc:`talwani2d`,
:doc:`talwani3d`
