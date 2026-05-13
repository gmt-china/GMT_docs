.. index:: ! nearneighbor
.. include:: common_SYN_OPTs.rst_

nearneighbor
============

:官方文档: :doc:`gmt:nearneighbor`
:简介: 使用最邻近算法网格化表数据

**nearneighbor** 读取 (*x,y,z*\ [,\ *w*]) 形式的数据，并使用最邻近算法计算网格点的加权平均值。
计算原理为

.. math::

    w(r_i) = \frac{w_i}{1 + d(r_i) ^ 2}, \quad d(r) = \frac {3r}{R}, \quad \bar{z} = \frac{\sum_i^n w(r_i) z_i}{\sum_i^n w(r_i)}

其中 *n* 为满足筛选标准的数据点数，:math:`r_i` 为网格点到第 *i* 个数据点的距离，如果不给定
输入点的权重，则假定其为等权，即 :math:`w_i = 1`

.. gmtplot:: nearneighbor/GMT_nearneighbor.sh
    :width: 40%
    :align: center
    :show-code: false

    算法示意图。R 为搜索半径，其限制了考虑的点和扇区的数量，只有每个扇区中最近的点（红色点）参与估计

语法
----

**gmt nearneighbor** [ *table* ] |-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
|-S|\ *search_radius*
[ |-E|\ *empty* ]
[|-N|\ *sectors*\ [**+m**\ *min_sectors*]\ \|\ **n**]
[ |SYN_OPT-V| ]
[ |-W| ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入表数据，包含三列或四列 (*x,y,z*\ [,\ *w*]) 形式的数据（见 |-W| 选项）

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格名。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *search_radius*
    设置 *search_radius* ，即上图中的 R，可在后面追加单位

可选选项
--------

.. _-E:

**-E**\ *empty*
    指定空节点的值为 *empty* ，默认为 NaN

.. _-N:

**-N**\ *sectors*\ [**+m**\ *min_sectors*]\|\ **n**
    以每个网格节点为中心可以将圆形的搜索区域划分为扇区 *sectors* 。**+m** 选项
    用来设置最少搜索的扇区 *min_sectors* ，即至少 *min_sectors* 个扇区至少含有
    一个数据时，才计算最终的加权值；未通过此测试的节点值被设置为 NaN，见 |-E| 。
    如果不设置该选项，GMT 至少设置 50% 的扇区来计算加权值，默认情况下，
    sectos = min_sectors = 4。每个扇区最接近的值才会被用来计算加权值，远处的点
    则被忽略。使用 **-Nn** 可以调用 GDAL 的最邻近算法，而不是用 GMT 的该算法。

.. _-W:

**-W**
    表明输入数据的第四列为权重，该权重与距离权重因子相乘即为最终权重

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

将文件 :file:`ship_15.txt` 格网化成 5 分分辨率的网格，搜索半径设置为 15 分，绘制最终
的网格 ::

    gmt begin map
        gmt nearneighbor @ship_15.txt -R245/255/20/30 -I5m -Ggrid.nc -S15m
        gmt grdimage grid.nc -B
    gmt end show

使用 :file:`seaMARCII_bathy.lon_lat_z` 文件创建 0.5 分分辨率的网格，设置搜索半径为 5 km，
将搜索圆范围分为八个扇区，每个扇区必须有数据，并将最终的空节点设置为 -9999 ::

    gmt nearneighbor seaMARCII_bathy.lon_lat_z -R242/244/-22/-20 -I0.5m -E-9999 -Gbathymetry.nc -S5k -N8+m8

使用 :file:`geoid.xyz` 数据创建全球 1 度分辨率的网格，搜索半径为 200 km，距离计算使用
球面距离，将搜索范围分为4个扇区，至少 2 个扇区包含数据时计算加权值 ::

    gmt nearneighbor geoid.xyz -R0/360/-90/90 -I1 -Ggeoid.nc -S200k -N4

相关模块
--------

:doc:`gmt:blockmean`,
:doc:`gmt:blockmedian`,
:doc:`gmt:blockmode`,
:doc:`gmt:greenspline`,
:doc:`sphtriangulate`,
:doc:`surface`,
:doc:`triangulate`
