:author: 周茂, 陈箫翰
:date: 2024-07-21

.. index:: ! surface
.. include:: common_SYN_OPTs.rst_

surface
=======

:官方文档: :doc:`gmt:surface`
:简介: 使用可调节张力连续曲率样条插值法对数据进行网格化

**surface** 从标准输入或表数据文件 *table* 中读取离散的数据点 (x,y,z)，
通过解如下微分方程，得到网格化的数据 z(x,y) 并生成网格文件

.. math::

    (1 - t) \nabla ^2(z) + t \nabla (z) = 0,

其中 *t* 是张力因子，取值范围为 0 到 1，:math:`\nabla` 是拉普拉斯算子。
若 *t = 0*, 则退化为最小曲率张力样条。最小曲率张力样条可能会导致数据中
出现虚假的震荡，产生错误的区域极值 [见 *Smith and Wessel*\ , 1990]。
大于 0 的张力可削弱这些效应。对于势能场数据，建议 *t* ~ 0.25 。对于陡峭
的地形数据，张力则建议 *t* ~ 0.35。当 *t = 1* 时，则上述微分方程退化为
Laplace 方程，其解即为调和面，除控制点外，不会出现最大值或最小值。
建议用户事先使用 :doc:`blockmean`， :doc:`blockmedian`，或 :doc:`blockmode`
预处理数据，以避免空间混叠（即数据点之间距离太小）与消除冗余数据。
用户也可设置输出解的范围以保证结果总在预定的范围内。解微分方程时，采用
自然边界条件。对于经度范围是 360 度的地理数据，将采用周期边界条件。

语法
----

**gmt surface** [ *table* ] |-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ *aspect_ratio*\|\ **m** ]
[ |-C|\ *convergence_limit*\ [%] ]
[ |-J|\ *parameters* ]
[ |-D|\ *breakline_file*\ [**+z**\ [*level*]] ]
[ |-L|\ **l**\ *lower* ] [ |-L|\ **u**\ *upper* ]
[ |-M|\ *max_radius* ]
[ |-N|\ *max_iterations* ]
[ |-Q|\ [**r**] ]
[ |-S|\ *search_radius*\ [**m**\|\ **s**] ]
[ |-T|\ [**b**\|\ **i**]\ *tension_factor* ]
[ |SYN_OPT-V| ]
[ |-W|\ [*logfile*] ]
[ |-Z|\ *over-relaxation_factor* ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. option:: -A

**-A**\ *aspect_ratio*\|\ **m**
    设置网格纵横比 *aspect_ratio* ，其中 dy = dx / *aspect_ratio*。
    对于地理数据，可以使用 **-Am** 设置网格纵横比为纬度平均值的余弦。
    不设置本项时，默认网格纵横比为 1，即各向同性网格。

.. option:: -C

**-C**\ *convergence_limit*\ [%]
    设置收敛极限，单位与 *z* 的单位相同。当任意格点的绝对变化量小于该极限时，
    即退出迭代。另外可给定 z 值的 RMS 的一定百分比作为收敛极限，后面必须追加 `%`。
    收敛极限默认设置为 RMS 的 10e-4。该值为最终输出的网格间距下的值，但对于
    GMT 内部，用于处理的中间临时网格的收敛值为最终网格的收敛值除以网格间距的倍数。

.. include:: explain_-J.rst_
..
    
    该设置仅用于将投影信息输出到最终的网格中，在实际计算中并不会使用。

.. option:: -D

**-D**\ *breakline*\ [**+z**\ [*level*]]
    指定一个 *breakline*, 其中数据格式为 *x, y, z*。在该 breakline 上的网格点，将
    不会做内插。海岸线或者湖岸线通常是理想的 breakline。breakline 文件可以为多段
    文件。如果文件中不存在 *z*，或者用户想要覆盖文件中的 *z* 值，则可在文件后追加
    **+z**\ *level*，如果不指定 *level* 值，则默认为 0。

.. option:: -L

**-Ll**\ *lower* and **-Lu**\ *upper*
    对微分方程的解加上限制。 **-Ll**\ *lower* 设置下限，其中 *lower* 可以是一个
    网格文件的文件名或一个固定值。设置以后，输出的网格的值将均大于等于设置的值。
    **-Lu**\ *upper* 设置上限，同样 *upper*  也可以是一个网格文件的文件名或一个
    固定值，输出处网格的值将均小于等于该值。如果设置为网格, 其大小、间隔和配准
    应与输出网格一致。如果网格其中包含 NaN，则 NaN 位置处的输出将不受约束。
    另外， *lower* 或 *upper* 除可为网格或固定值外，也可以设置为如下字符：

       - **u** 不设置约束 [默认]
       - **d** 针对 *l* 和 *u* 分别表示设置为输入数据的最小值和最大值

.. option:: -M

**-M**\ *max_radius*
    设置一个半径大小，在求解结束后，位于输出离散点半径内的格点数据将被保留，半径
    以外的数据将设置为 NaN。可追加距离单位。
    或可使用 **-M**\ *n_cells*\ **c** 形式以不用距离，而是格点个数来保留数据，其中
    *n_cells* 为离散点周围的格点个数。**-M0c** 表示只有离散点所处的格点被保留。
    **-M1c** 将保留处其所处格点外的最近一圈格点，即 3x3 的范围，依此类推。

.. option:: -N

**-N**\ *max_iterations*
    迭代次数, 默认为 500。迭代将会在达到收敛极限或迭代次数达到 *max_iterations* 时停止。这个
    最大迭代次数仅针对最终输出的网格，对于 GMT 内部的临时网格，其迭代次数放大为
    网格间隔相应的倍数。

.. option:: -Q

**-Q**\ [**r**]
    输出本模块建议运行时使用的网格维度。该选项主要目的为建议一个最优的网格维度以
    允许本模块可使用多次中间步骤以加快计算并得到更好的结果。当用户得到此建议维度
    时，可使用 |-R| 和 |-I| 设置新的结果，并在后续使用 :doc:`grdsample` 或
    :doc:`grdcut` 以得到用户原本希望的维度和范围。
    另外，可追加 **r** 使 **surface** 完全按照 |-R| 指定的范围计算结果 [默认会自动
    寻找稍大的区域，然后在输出时将区域裁剪为 |-R| 设置的范围。]

.. option:: -S

**-S**\ *search_radius*\ [**m**\|\ **s**]
    设置搜索半径 *search_radius*，单位与 x 和 y 的单位相同，默认值为 0，即不做搜索；
    追加 **m** 或者 **s**
    分别表示角分和角秒。该选项用于在第一次迭代之前进行初始化。除非网格点个数为素数，
    不存在中间阶段，否则无需设置该选项。

.. option:: -T

**-T**\ [**b**\|\ **i**]\ *tension_factor*
    设置张力因子，必须在 0 到 1 之间。
    张力可用于内部求解（见上面的方程）和边界条件（张力可使接近边缘的解区域平缓）。
    其中 **i** 用于设置内部求解张力，**b** 用于设置边界条件张力。如果不给出子选项，
    则二者同时设置为同一个值。若同时设置为 0，即退化为最小曲率样条解，这也是默认情况。

.. option:: -W

**-W**\ [*logfile*]
    将收敛信息输出到为 *logfile* 文件，默认为 *surface_log.txt*

.. option:: -Z

**-Z**\ *over-relaxation_factor*
    Over-relaxation 因子，该参数用于加速收敛，取值应位于 1 到 2 之间。当其为
    1 时，将精确地迭代，并始终保证稳定收敛。较大的值会增大收敛中的增量变化，
    因此可以更快地收敛，但由于增量变大，最终的结果可能不稳定。如果使用较大的
    值，最好使用 **-Vi** 选项观察迭代过程。默认值为 1.4，可以快速收敛且总能
    得到稳定的解。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_float.rst_

.. include:: explain_distunits.rst_

.. include:: explain_float.rst_

示例
----

ASCII 数据 `hawaii_5x5.xyg` 为经 :doc:`blockmean` 处理后的数据，使用 **surface**
网格化为 5 分，设置 *tension_factor* = 0.25，*convergence_limit* = 0.1 mgal，
将结果输出到 `havaii_grd.nc` 并使用 `-Vi` 选项查看每个迭代过程 ::

    gmt surface hawaii_5x5.xyg -R198/208/18/25 -I5m -Ghawaii_grd.nc -T0.25 -C0.1 -Vi

注意事项
--------

尽管 |-R| 选项控制了最终输出网格的范围，但在 GMT 内部会使用一个稍大一些的区域，
这种做法有利于最终结果的收敛。


格网化地理坐标数据：边界条件
----------------------------

**surface** 内部执行的有限差分算法基于笛卡尔坐标，因此设置了 |-A| 选项以适应
不同纬度下不同方向（即经度和纬度方向）的纵横比。当输出地理坐标网格的经度范围
为 0～360 范围时，将在经度方向实施周期边界条件。但是，在极点处，却不能使用该
边界条件，因为在极点处的有限差分解时无效的（在极点处，网格间隔为 0）。如果
用户在此情况下运行该模块，GMT 将给出警告，但不会阻止程序运行。
对于地理坐标，位于极点的值可能不一致，因此将被替换为极点附近的平均值，这可能
会导致在极点附近区域的结果存在问题。
鉴于上述问题，用户在处理全球数据时，应考虑使用球面网格化，例如：:doc:`greenspline`
或 :doc:`sphinterpolate`；或者使用 stereographic 投影数据并对投影后的数据
做 **surface**。

格网化地理坐标数据：设置间隔
----------------------------

对地理网格设置带有距离单位的网格间隔时，将会激活距离转换，即将间隔转换为等效
的度，在经纬度方向是不同的并且与椭球设置有关，但不论使用什么椭球，最终仍
使用球近似，即大圆距离（译注：椭球的大小是影响该距离的主要因素，球近似不是
主要因素）。对于纬度，GMT 将 y 方向的距离除以每维度所对应的距离，对于经度，则
除以平均纬度对应的距离。因此，转换后的度与用户输出的增量可能不完全一致。这
其中所涉及到的舍入是用户所不希望的，并会导致网格的维度为素数。|-Q| 选项可用来
处理这种情况，但间隔转换导致的无穷小数仍然难以有效解决。因此，不要使用长度
单位设置间隔是一种比较好的方法，设置为角度、角分、角秒可以得到更加干净的结果，
因为这样网格的维度是可控的并且可避免舍入误差。
另外，如果计算区域远离赤道，用户若担心经纬度方向不同的增量，则可选择对数据作
投影，这样就可以对投影坐标作网格化，间隔也可设置为米/千米等。
任意一种方法均可以避免类似 0.161697s 这种丑陋的间隔。如果用户所需结果却实为
以米/千米等距离为单位的网格，则投影方法是更适合的。

已知 Bug
--------

在输出网格的任意节点存在多个输入数据，**surface** 会提示用户使用
:doc:`blockmean`， :doc:`blockmedian`，或 :doc:`blockmode`。
如果已经使用了上述模块，但仍存在警告，则意味着设置的网格间隔太小，
输出数据需要更多的有效数字。用户可在运行该模块前编辑 `gmt.conf` 中的
:term:`FORMAT_FLOAT_OUT` 选项以增加有效数字个数，或使用单精度或者
双精度的二进制文件以保证其有效数字个数。

参考文献
--------

Smith, W. H. F, and P. Wessel, 1990, Gridding with continuous curvature
splines in tension, *Geophysics*, 55, 293-305, https://doi.org/10.1190/1.1442837.

相关模块
--------

:doc:`blockmean`,
:doc:`blockmedian`,
:doc:`blockmode`,
:doc:`grdcut`,
:doc:`grdsample`,
:doc:`greenspline`,
:doc:`nearneighbor`,
:doc:`triangulate`,
:doc:`sphinterpolate`
