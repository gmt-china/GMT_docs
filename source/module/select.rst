:author: 田冬冬, 陈箫翰
:date: 2025-09-22
.. index:: ! select
.. program:: select
.. include:: common_SYN_OPTs.rst_

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

**gmt select** [ *table* ]
[ |SYN_OPT-Area| ]
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
[ :option:`-Z`\ *min*\ [/*max*]\ [**+a**]\ [**+c**\ *col*]\ [**+h**\ [**k**\|\ **s**]]\ [**+i**] ]
[ :option:`-f`\ *flags* ]
[ :option:`-s`\ *flags* ]

必选选项
---------

*table*
    输入文件的文件名。

空间准则与可选选项
-------------------

准则1
+++++

.. include:: explain_-R.rst_

使用 :option:`-R` 筛选出在该矩形区域内的点::

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

    如果只有一个基准点，可以简单使用 **-C**\ *lon*/*lat*\ **+d**\ *dist* 。

    如果同时使用 :option:`-R` 和 :option:`-J` 选项，则表示基于投影后的图片纸面上的距离进行判断（详情请参考末尾的例子）。

准则3
+++++

筛选所有与线文件 *linefile* 中的任意一条线的距离在一定范围之内的点。

.. option:: -L

**-L**\ *linefile*\ **+d**\ *dist*\ [**+p**]
    ASCII文本文件 *linefile* 内容格式与表示线段的格式相同，也可以是多段数据表示的多条线段
    (参见 :ref:`table-ascii-multiple-segment` )。
    该准则会筛选出与任意一条线段的距离在 *dist* 之内的记录。

    若 *dist* 等于零，则可以在 *linefile* 中每段数据的段头记录中使用 **-D**\ *dist* 参数，为每个线段分别指定距离值。
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

**-N**\ *wet/dry*
    跳过或保留海湖(wet)/陆地(dry)内的点。

    *wet* 和 *dry* 可以取 ``s`` 或 ``k`` ，分别表示 skip 和 keep。
    默认值为 ``-Ns/k`` ，即保留所有位于陆地上的记录，并跳过所有海洋、湖泊中的记录。

**-N**\ *ocean/land/lake/island/pond*
    进一步细分地理特征，五项分别表示海洋、大陆和岛屿(Continents and islands)、
    湖泊(Lakes (regular and river lakes))、湖中岛(Islands inside lakes)以及湖中岛中湖(Ponds in islands inside lakes)，
    对应GSHHG数据的不同等级(（详情见 :doc:`/module/gshhg` ）)
    每一项均可以取 ``s`` 或 ``k`` ，分别表示 skip 和 keep。默认值为 ``-Ns/k/s/k/s`` ，
    等效于 ``-Ns/k``，即仅保留所有陆地上的记录。

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
    使用 **-G**\ *gridmask* 指定一个网格文件。对于每个数据点而言，判断其所在位置的网格单元是否具有有效值（即非零或非NaN的值）。若该网格单元有有效值，则保留该数据点。

其他选项
--------

.. option:: -E

**-E**\ [**f**][**n**]
    在判断点是否在一个多边形内时，默认会将恰好在多边形边界线上的点也认为是在多边形内，使用该选项会将多边形上的点认为是在多边形外部。
    **f** 和 **n** 分别修改 :option:`-F` 和 :option:`-N` 选项的行为。

.. option:: -I

**-I**\ [**cflrsz**]
    对七个准则取反，即筛选出不符合准则的记录。c、f、g、l、r、s、z分别对应于
    ``-C`` 、 ``-F`` 、 ``-G`` 、 ``-L`` 、 ``-R`` 、 ``-N -A -D`` 和 ``-Z`` 。

示例
----

筛选输入数据 ``data.txt`` 中与 ``pts.txt`` 的任意基准点的距离在300 km以内，
且与 ``lines.txt`` 中线段的距离在100 km以外( ``-Il`` )的点。结果输出到 ``subset.txt`` ::

    gmt select data.txt -fg -Cpts.txt+d300k -Llines.txt+d100k -Il > subset.txt

此处需要使用 **-fg** 以告知程序正在处理地理数据。

筛选某个区域内所有不在陆地上的点::

    gmt select data.txt -R120/121/22/24 -Dh -Nk/s > subset.txt

筛选 ``quakes.txt`` 中所有位于多边形区域内的点::

    gmt select quakes.txt -Flonlatpath.txt -fg > subset.txt

筛选 ``stations.txt`` 中的点投影作图后，与 ``origin.txt`` 的基准点在图片纸面上的距离在5 cm之内的点::

    gmt select stations.txt -Corigin.txt+d5 -R20/50/-10/20 -JM20c --PROJ_LENGTH_UNIT=cm > subset.txt
