.. index:: ! gmtbinstats
.. include:: common_SYN_OPTs.rst_

gmtbinstats
===========

:官方文档: :doc:`gmt:gmtbinstats`
:简介: 对落入网格节点内的空间数据进行统计

**gmtbinstats** 将表数据放到网格中，对给定半径的每个节点的数据进行统计，例如：
面积归一化，密度估计等操作。网格的节点可以为矩形或六边形。

语法
----

**gmt gmtbinstats** [ *table* ] |-G|\ *outgrid*
|SYN_OPT-I|
|-C|\ **a**\|\ **d**\|\ **g**\|\ **i**\|\ **l**\|\ **L**\|\ **m**\|\ **n**\|\ **o**\|\ **p**\|\ **q**\ [*quant*]\|\ **r**\|\ **s**\|\ **u**\|\ **U**\|\ **z**
|SYN_OPT-R|
|-S|\ *search_radius*
[ |-E|\ *empty* ]
[ |-N| ]
[ |-T|\ [**h**\|\ **r**] ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+s**] ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
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
    2-4 列的表数据，当包含第四列时，其为权重，必须使用 |-W| 选项来表明数据带权。
    **-Cn** 将会只接收两列数据。

.. _-C:

**-C**\ **a**\|\ **d**\|\ **g**\|\ **i**\|\ **l**\|\ **L**\|\ **m**\|\ **n**\|\ **o**\|\ **p**\|\ **q**\ [*quant*]\|\ **r**\|\ **s**\|\ **u**\|\ **U**\|\ **z**
    对每个网格节点进行数据统计，下面将展示各选项含义：

    - **a** 均值
    - **d** 绝对中位差（median absolute deviation，MAD）
    - **g** 数据范围 (max-min)
    - **i** 25-75% 的四分位数范围
    - **l** 最小值
    - **L** 最小的正值
    - **m** 中位数
    - **n** 数据个数
    - **o** for LMS scale,
    - **p** for mode (maximum likelihood)
    - **q** *quant* 分位数， 0 <= *quant* <= 100，默认值为 50
    - **r** RMS
    - **s** STD
    - **u** 最大值
    - **U** 最大的负值
    - **z** 求和

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格名。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选参数
--------

.. _-E:

**-E**\ *empty*
    设置空节点值为 *empty* ，默认为 NaN

.. _-N:

**-N**
    以节点的面积对节点值进行归一化

.. _-S:

**-S**\ *search_radius*
    设置搜索范围，可追加单位。使用此选项时不能使用 |-T| 选项

.. _-T:

**-T**\ [**h**\|\ **r**]
    设置网格节点形状：

    - **h** 六边形，仅适用于笛卡尔坐标。将六边形的中心和统计结果写到标准输出或 **-G**
      指定的文件中；**-I** 设置仅针对 Y 坐标的增量，X 方向增量会自动计算，**-R** 设定的
      范围会被调整以适应整数个六边形

    - **r** 矩形，使用 |-I| 可设置该矩形大小，将计算结果写到 |-G| 指定的网格中

.. _-W:

**-W**\ [**+s**]
    加权计算统计量，使用该选项计数将变为权重的和而不是数据的个数。如果权重是由不确定度
    （一倍中误差 sigma）决定的，使用 **+s** 选项可计算权重 weight = 1/sigma

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

远程文件 :file:`capitals.gmt` 中包含了人口数据，在 5 度分辨率的网格中，统计
半径 1000 km 内的人口，使用默认投影和颜色绘制网格 ::

    gmt begin map
    gmt gmtbinstats @capitals.gmt -a2=population -Rg -I5 -Cz -Gpop.nc -S1000k
        gmt grdimage pop.nc -B
    gmt end show

对文件 :file:`mydata.txt` 中的数据进行六边形网格的分选，计算每个节点中点的个数 ::

    gmt gmtbinstats mydata.txt -R0/5/0/3 -I1 -Th -Cn > counts.txt

相关模块
--------

:doc:`gmt:blockmean`,
:doc:`gmt:blockmedian`,
:doc:`gmt:blockmode`,
:doc:`nearneighbor`,
:doc:`triangulate`,
:doc:`xyz2grd`
