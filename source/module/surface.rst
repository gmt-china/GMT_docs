.. index:: ! surface
.. include:: common_SYN_OPTs.rst_

surface
=======

:贡献者: ||
:最近更新日期: 2024-07-21

----

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
xxxxx
解微分方程时，采用自然边界条件。对于经度范围是 360 度的地理数据，将采用
周期边界条件。

.. warning::

    在每个维度上至少必须有4个点，否则无法使用 **surface** 。

    如果你的数据是等间隔的 (x,y,z) 数据，请不要使用 **surface** 生成网格文件。正确的做法是
    使用 :doc:`xyz2grd` 生成网格文件。



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

.. include:: explain_grd_inout.rst_

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ *aspect_ratio*\|\ **m**
    设置网格纵横比 *aspect_ratio* ，其中 dy = dx / *aspect_ratio* 。
    对于地理数据，可以使用 **-Am** 设置网格纵横比为纬度平均值的余弦。
    不设置本项时，默认网格纵横比为1，即各向同性网格。

.. _-L:

**-Ll**\ *lower* and **-Lu**\ *upper*
    对微分方程的解加上限制。 **-Ll**\ *lower* 设置下限，其中 *lower* 可以是一个grid网格文件的文件名、
    或一个固定值。 **-Lu**\ *upper* 设置上限，同样 *upper*  可以是一个grid网格文件的文件名、
    或一个固定值。

.. _-T:

**-T**\ [**i**\|\ **b**]\ *tension_factor*
    设置张量因子，必须在0到1之间。 不设置时默认为0。

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
鉴于上述问题，用户在处理全球数据时，应考虑使用球面网格化，例如：:doc:`gmt:greenspline`
或 :doc:`sphinterpolate`；或者使用 stereographic 投影数据并对投影后的数据
做 **surface**。

格网花地理坐标数据：设置间隔
----------------------------

对地理网格设置带有距离单位的网格间隔时，将会激活距离转换，即将间隔转换为等效
的度，并且在经纬度方向是不同的并且与椭球设置有关，但不论使用什么椭球，最终仍
使用球近似（即大圆距离）。
xxxx

已知 Bug
--------

在输出网格的任意节点存在多个输入数据，**surface** 会提示用户使用
:doc:`blockmean`， :doc:`blockmedian`，或 :doc:`blockmode`。
如果已经使用了上述模块，但仍存在警告，则意味着设置的网格间隔太小，
输出数据需要更多的有效数字。用户可在运行该模块前编辑 `gmt.conf` 中的
:term:`FORMAT_FLOAT_OUT` 选项以增加有效数字个数，或使用但精度或者
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
:doc:`gmt:greenspline`,
:doc:`nearneighbor`,
:doc:`triangulate`,
:doc:`sphinterpolate`
