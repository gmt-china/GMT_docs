:author: 田冬冬, 陈箫翰
:date: 2026-01-12

.. index:: ! select
.. program:: select

select
=========

:官方文档: :doc:`gmt:gmtselect`
:简介: 筛选符合某个特定准则的数据

该命令会从输入文件 *table* 中读取前两列作为经度和纬度，并判断该点是否符合一定的空间准则，
以筛选出符合条件的记录。

用于判断的空间准则包括：

#. 在矩形区域内
#. 与点文件中的任意一个点的距离在一定范围之内
#. 与线文件中的任意一条线的距离在一定范围之内
#. 在多边形文件所指定的多边形内
#. 在某个地理区域内（需要海岸线数据）
#. Z 值在某个范围内
#. 该点所在的网格单元内具有有效值（即非零和非NaN的值）

语法
-------

**gmt select**
[ *table* ]
[ :option:`-A`\ *min\_area*\ [/*min\_level*/*max\_level*][**+a**\ [**g**\|\ **i**][**s**\|\ **S**]][**+l**\|\ **r**][**+p**\ *percent*] ]
[ :option:`-C`\ *pointfile*\ \|\ *lon*/*lat*\ **+d**\ *dist* ]
[ :option:`-D`\ *resolution*\ [**+f**] ]
[ :option:`-E`\ [**f**][**n**] ]
[ :option:`-F`\ *polygonfile* ]
[ :option:`-G`\ *gridmask* ]
[ :option:`-I`\ [**cfglrsz**] ]
[ :option:`-J`\ *parameters* ]
[ :option:`-L`\ *linefile*\ **+d**\ *dist*\ [**+p**] ]
[ :option:`-N`\ *maskvalues* ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ *min*\ [/*max*]\ [**+a**]\ [**+c**\ *col*]\ [**+h**\ [**k**\|\ **s**]]\ [**+i**] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
---------

.. include:: explain_intables.rst_

空间准则与可选选项
-------------------

准则1
+++++

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

不指定投影则默认使用 **-Jx**\ 1 。使用 :option:`-R` 筛选出在该矩形区域内的点::

    gmt select points.xy -R0/5/0/5

准则2
+++++

筛选出与文件 *pointfile* 中的基准点的距离在一定范围内的点。

.. option:: -C

**-C**\ *pointfile*\ **+d**\ *dist*
    ASCII文本文件 *pointfile* 中每一行是一个基准点的经纬度坐标。
    该准则会筛选出与任意一个基准点的距离在 *dist* 之内的记录。

    若 *dist* 等于0，则 *pointfile* 必须有第三列，表示每个基准点各自的影响半径。
    默认情况下 *dist* 是笛卡尔坐标系下的距离，单位为用户单位。
    若指定 **-fg** 选项，则表明 *dist* 为球面距离，后面可以添加地理单位（详情见 :doc:`/basis/unit` ）。

    如果只有一个基准点，可以简单使用 :option:`-C`\ *lon*/*lat*\ **+d**\ *dist* 。

    如果同时使用 :option:`-R` 和 :option:`-J` 选项，则表示基于投影后的图片纸面上的距离进行判断（详情请参考末尾的例子）。

准则3
+++++

筛选所有与线文件 *linefile* 中的任意一条线的距离在一定范围之内的点。

.. option:: -L

**-L**\ *linefile*\ **+d**\ *dist*\ [**+p**]
    ASCII文本文件 *linefile* 内容格式与表示线段的格式相同，也可以是多段数据表示的多条线段
    (参见 :ref:`table-ascii-multiple-segment` )。
    该准则会筛选出与任意一条线段的距离在 *dist* 之内的记录。

    若 *dist* 等于零，则可以在 *linefile* 中每段数据的段头记录中使用 :option:`-D`\ *dist* 参数，为每个线段分别指定距离值。
    (参见 :ref:`table-ascii-attrs` )

    默认情况下 *dist* 是笛卡尔坐标系下的距离，单位为用户单位。
    若指定 **-fg** 选项，则表明 *dist* 为球面距离，后面可以添加地理单位（详情见 :doc:`/basis/unit` ）。

    如果使用 **+p** 则会进一步筛选出到最近的线段的垂直投影位置在线段的两个端点内的数据
    （默认情况下垂直投影位置在线段以外的数据点也会被包含进来）。

准则4
+++++

筛选出在某个多边形内的点。

.. option:: -F

**-F**\ *polygonfile*
    多段数据文件 *polygonfile* 的内容为一个或多个闭合多边形的各个顶点(参见 :ref:`table-ascii-multiple-segment` )。
    该选项筛选出在任意一个多边形内的数据记录。

准则5
+++++

根据地理特征信息筛选数据。

.. option:: -N

**-N**\ *wet/dry*
    跳过或保留海湖(wet)/陆地(dry)内的点。

    *wet* 和 *dry* 可以取 **s** 或 **k** ，分别表示 skip 和 keep。
    默认值为 **-Ns/k** ，即保留所有位于陆地上的记录，并跳过所有海洋、湖泊中的记录。

**-N**\ *ocean/land/lake/island/pond*
    进一步细分地理特征，五项分别表示海洋、大陆和岛屿(Continents and islands)、
    湖泊(Lakes (regular and river lakes))、湖中岛(Islands inside lakes)以及湖中岛中湖(Ponds in islands inside lakes)，
    对应GSHHG数据的不同等级(（详情见 :doc:`/module/gshhg` ）)
    每一项均可以取 **s** 或 **k** ，分别表示 skip 和 keep。默认值为 **-Ns/k/s/k/s** ，
    等效于 **-Ns/k** ，即仅保留所有陆地上的记录。

.. option:: -D

**-D**\ *resolution*\ [**+f**]
    选择海岸线数据的精度，仅与 :option:`-N` 选项一起使用有效。见 :doc:`coast` 中
    :option:`-D` 选项的介绍。

.. include:: explain_-A.rst_

准则6
+++++

筛选Z值在某个范围内的点

.. option:: -Z

**-Z**\ *min*\ [/*max*]\ [**+a**]\ [**+c**\ *col*]\ [**+h**\ [**k**\|\ **s**]]\ [**+i**]
    筛选出数据第三列的Z值在 *min* 到 *max* 范围内或等于 NaN 的数据点
    （使用 **-s** 选项可以排除掉 NaN 数据点）。

    若省略 *max* 则判断Z值是否等于 *min* 。若不限制范围的上限或下限， *min*\ [/*max*] 可以使用 ``-`` 代替。

    注意：
    (1)若第三列Z值代表时间，想要判断Z值是否在某个时间范围内，需要使用 **-f**\ 2T 选项。
    (2)若想要对多列做类似的测试，可以重复多次使用 :option:`-Z` 选项。
    (3)输入数据必须至少有三列。
    (4)当重复多次使用 :option:`-Z` 选项时，不可使用 **-Iz** 选项。

    可以使用以下附加选项：

    - **+a** 重复使用 :option:`-Z` 选项时，数据点只要满足一个选项即可（默认要满足所有 :option:`-Z` 选项）。
    - **+c**\ *col* 指定Z值所在的列。只使用一个 :option:`-Z` 选项时，不使用 **+c** 默认为第三列(col=2)。
      当重复多次使用 :option:`-Z` 选项时，不使用 **+c** 默认每个 :option:`-Z` 选项分别使用数据中第三列、第四列、第五列……为Z值。
    - **+i** 反转筛选准则。筛选出Z值不在 *min* 到 *max* 范围内的数据点。

准则7
+++++

根据数据点所在的网格单元内具有有效值（即非零和非NaN的值）来筛选数据。

.. option:: -G

**-G**\ *gridmask*
    使用 :option:`-G`\ *gridmask* 指定一个网格文件。对于每个数据点而言，判断其所在位置的网格单元是否具有有效值（即非零或非NaN的值）。若该网格单元有有效值，则保留该数据点。

其他选项
--------

.. option:: -E

**-E**\ [**f**][**n**]
    在判断点是否在一个多边形内时，默认会将恰好在多边形边界线上的点也认为是在多边形内，使用该选项会将多边形上的点认为是在多边形外部。
    **f** 和 **n** 分别修改 :option:`-F` 和 :option:`-N` 选项的行为。

.. option:: -I

**-I**\ [**cflrsz**]
    对七个准则取反，即筛选出不符合准则的记录。c、f、g、l、r、s、z分别对应于
    :option:`-C` 、 :option:`-F` 、 :option:`-G` 、 :option:`-L` 、 :option:`-R` 、 :option:`-N` :option:`-A` :option:`-D` 和 :option:`-Z` 。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_precision.rst_

此注释仅适用于 ASCII 输出与二进制或 netCDF 输入或 **-:** 选项结合使用的情况。另请参阅下文。

ASCII 输入记录处理注释
----------------------

除非您使用 **-:** 选项，否则选定的 ASCII 输入记录将原样复制到输出。
这意味着诸如 :option:`-f`\ **oT** 之类的选项以及 :term:`FORMAT_FLOAT_OUT` 和 :term:`FORMAT_GEO_OUT` 等设置将不会对输出产生任何影响。
另一方面，它允许选择包含各种内容的记录，包括字符串（无论是否加引号）、注释和其他非数值内容。

距离注释
---------

如果选择了 :option:`-C` 或 :option:`-L` 选项，则距离为笛卡尔距离，单位为用户单位。
使用 :option:`-f`\ **g** 则表示公里单位的球面距离和地理（*经度, 纬度*）坐标。
或者，指定 :option:`-R` 和 :option:`-J` 以测量地图单位（由 :term:`PROJ_LENGTH_UNIT` 确定的厘米、英寸或磅）下的投影笛卡尔距离。

本程序多年来不断演进。最初，:option:`-R` 和 :option:`-J` 是处理地理数据所必需的，但现在已全面支持球面计算。
因此，只有在您希望将测试应用于投影数据而非原始坐标时，才应使用 :option:`-J` 。如果使用了 :option:`-J` ，则通过 :option:`-C` 和 :option:`-L` 给出的距离均为投影距离。

分段注释
---------

如果分段中有一个或多个记录通过测试，输入文件中的分段头将被复制到输出。选择始终是逐点进行的，而不是按分段进行的。这意味着分段中只有通过测试的点才会包含在输出中。
如果您希望裁剪线条并在分段末端包含新的边界点，则必须改用 :doc:`spatial`。

示例
----

返回远程文件 @ship_15.txt 中位于经度 246 到 247、纬度 20 到 21 之间的区域内的数据点::

    gmt select @ship_15.txt -R246/247/20/21

返回该矩形区域之外的所有点::

    gmt select @ship_15.txt -R246/247/20/21 -Ir

筛选输入数据 *data.txt* 中与 *pts.txt* 的任意基准点的距离在300 km以内，
且与 *lines.txt* 中线段的距离在100 km以外( :option:`-I`\ **l** )的点。结果输出到 *subset.txt* ::

    gmt select data.txt -fg -Cpts.txt+d300k -Llines.txt+d100k -Il > subset.txt

此处需要使用 :option:`-f`\ **g** 以告知程序正在处理地理数据。

筛选某个区域内所有不在陆地上的点::

    gmt select data.txt -R120/121/22/24 -Dh -Nk/s > subset.txt

筛选 *quakes.txt* 中所有位于多边形区域内的点::

    gmt select quakes.txt -Flonlatpath.txt -fg > subset.txt

筛选 *stations.txt* 中的点投影作图后，与 *origin.txt* 的基准点在图片纸面上的距离在5 cm之内的点::

    gmt select stations.txt -Corigin.txt+d5 -R20/50/-10/20 -JM20c --PROJ_LENGTH_UNIT=cm > subset.txt

返回 quakes.txt 中位于网格 topo.nc 范围内且对应网格值不为零的所有点::

    gmt select quakes.txt -Gtopo.nc > subset2.txt

返回第 3 列数值在 10-50 范围内且第 5 列数值均为负数的所有记录::

    gmt select dataset.txt -Z10/50 -Z-/0+c4 > subset3.txt

.. include:: explain_gshhg.rst_

.. include:: explain_inside.rst_

相关模块
--------------

:doc:`convert`,
:doc:`simplify`,
:doc:`spatial`,
:doc:`grdlandmask`,
:doc:`coast`