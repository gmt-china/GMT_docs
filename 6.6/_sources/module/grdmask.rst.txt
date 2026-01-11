:author: 田冬冬, Tche LIU, 陈箫翰
:date: 2026-01-02

.. index:: ! grdmask
.. program:: grdmask

grdmask
==============

:官方文档: :doc:`gmt:grdmask`
:简介: 根据多边形数据或点数据创建掩膜网格文件

**grdmask** 可以以两种不同的模式运行。

1. 读取一个或多个各自定义了一个闭合多边形的 *pathfiles*。
多边形外部、内部和边界上的节点可以通过 :option:`-N` 设置为不同的 *z* 值。
如果多个多边形重叠在相同的节点上，则选定的多边形取决于 :option:`-C` 的选择。
生成的掩膜网格文件可用于后续涉及 :doc:`grdmath` 的操作，以屏蔽多边形区域的数据。

2. *pathfiles* 仅代表数据点位置，根据节点是否位于最近数据点的最大距离范围内，将其判定为内部或外部。
如果指定的距离为零，则只有最靠近每个数据点的节点才被视为“内部”。

语法
--------

**gmt grdmask**
*table*
:option:`-G`\ *outgrid*
:option:`-I`\ *increment*
:option:`-R`\ *region*
[ :option:`-A`\ [**m**\|\ **p**\|\ **x**\|\ **y**\|\ **r**\|\ **t**] ]
[ :option:`-C`\ **f**\|\ **l**\|\ **o**\|\ **u** ]
[ :option:`-N`\ [**z**\|\ **Z**\|\ **p**\|\ **P**]\ *values* ]
[ :option:`-S`\ *radius*\|\ *xlim*\ /*ylim* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-j`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :option:`-w`\ *flags* ]
[ :option:`-x`\ [[-]n] ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
----------------

.. include:: explain_intables.rst_

必须选项
--------

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. option:: -A

**-A**\ [**m**\|\ **p**\|\ **x**\|\ **y**]
    控制两点之间的连接方式。

    如果输入数据是地理坐标数据（可用 :option:`-f`\ **ig** 表明输入是地理坐标），不使用本选项时默认多边形的各边将由大圆弧连接。
    如果使用本选项，各边将用直线连接。附加 **m** 先沿经线再沿纬线连接。附加 **p** 先沿纬线再沿经线连接。
    
    对于笛卡尔坐标数据，各点会被直接连接，除非附加 **x** 或 **y** 来构建阶梯式路径，首个连接分别沿 *x* 或 *y* 方向。
    如果笛卡尔坐标数据是极坐标 (*theta*, *r*)，则附加 **t** 或 **r** 来构建阶梯式路径，首个连接分别沿 *theta* 或 *r* 方向。

.. option:: -C

**-C**\ **f**\|\ **l**\|\ **o**\|\ **u**
    多个多边形重叠在相同的节点上时选择哪个多边形。
    
    - **f** 选择覆盖节点的第一个多边形
    - **o** 选择覆盖节点的最后一个多边形 [默认值为 **o**]
    - **l** 选择具有最小 *z* 值的多边形
    - **u** 选择具有最大 *z* 值的多边形
    
    **注意**：不适用于 :option:`-S` 。关于多边形的 *z* 值，请参见 :option:`-N` 。

.. option:: -N

**-N**\ [**z**\|\ **Z**\|\ **p**\|\ **P**]\ *values*
    设置位于多边形外部 (*out*)、边界 (*edge*) 和内部 (*in*) 的节点值，
    默认值为 *0/0/1* ，即多边形内部节点值为1，其他节点值为0。
    *values* 的形式为 *out/edge/in* 。可以是任意数值，也可以是 NaN。

    - **Nz** 将多边形内的节点设置为从多段数据的段头记录中获取的 Z 值，比如多边
      形段头记录中的 **-Z**\ *zval* 、 **-L**\ *header* 或 **-a**\ Z=\ *name*
    - **-NZ** 与 **-Nz** 类似，会将多边形的边界也当做是多边形的内部
    - **-Np** 使用一个默认从开始0递增的数字作为多边形的ID，也可以在其后加上一个数字以
      指定序列的起始值
    - **-NP** 与 **-Np** 类似，会将多边形的边界也当做多边形的内部

    **注意**： 本选项不能与 **-S** 同时使用。它们也都可以选择性地接受 /*out* [默认值为 0]。

.. option:: -S

**-S**\ *radius*\|\ *xlim*\ /*ylim*
    根据节点到最近数据点的距离，将其设置为内部、边界上或外部。
    距离最近数据点在搜索半径 *radius* [默认值为 0] 之内的节点被视为内部。
    如果 *radius* 为 **z**，则改为从输入数据的第三列读取每个点的半径。
    笛卡尔坐标数据除外，地理坐标数据都需要在 **-Sz** 之后附加单位来指定这些半径的单位。
    
    如果未设置本选项，则认为输入数据定义了一个或多个闭合多边形。对于具有不同单位的笛卡尔数据，可以改为附加 *xlim*\ /*ylim* 执行矩形搜索，
    数据点 ±\ *xlim* 和 ±\ *ylim* 范围内的所有节点都将被视为内部。
    也可以使用 **-S**\ *n_cells*\ **c** 形式来实现矩形选择效果。此处 *n_cells* 表示每个数据点周围的节点数量。
    例如， **-S**\ 0\ **c** 表示仅数据点所在的节点， **-S**\ 1\ **c** 则表示周围的一个节点的范围（即形成以数据点为中心 3x3 的矩阵区域）。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. option:: -n

**-n**\ [**b**\|\ **c**\|\ **l**\|\ **n**][**+a**][**+b**\ *BC*][**+t**\ *threshold*]
    附加 **+b**\ *BC* 以设置要使用的边界条件。 *BC* 可以选择:
    
    - **g** 表示地理边界条件
    - **p** 表示周期性边界条件
    - **n** 表示自然边界条件
    
    对于后两者，可以附加 **x** 或 **y** 以仅指定一个方向，否则默认两个方向 [如果网格是地理网格，则默认为地理边界条件]。

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-w.rst_

.. include:: explain_core.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_grd_coord.rst_

.. include:: explain_inside.rst_

注意事项
--------

由 **grdmask** 生成的网格是一个 **分类型** 数据集，即所有数据只能取几个固定的值。
因此，必须注意不要使用标准方法（如样条插值）进行插值。
比如 *-N0/1* 会将水域内的网格值设置为0，将陆地内的网格值设置为1。
在这种情况下，对这种数据用标准方法进行插值通常会得到无意义的结果，使用时需要小心。

然而，如果使用地图投影来绘制该网格，网格将被重新投影，从而在投影坐标系中生成一个矩形矩阵。
这个过程中涉及到了网格插值，默认情况下，这种插值是使用样条插值完成的，因此可能会在图中产生假象。
对于此类情况，建议使用 :doc:`grdimage` **-nn** 来改为使用最近邻插值 nearest neighbor 插值算法以避免这一问题。

节省存储空间
------------------------

由于 *grdmask* 的大多数用途是围绕创建仅包含少量整数值（可能还有 NaN）的掩码网格展开的，
通过在所需的网格文件名后附加后缀 **=nb**，可以将它们作为字节网格 (byte grids) 写入磁盘。
某些情况存储的整数可能会超出字节网格的可用范围，对于这些情况，可以使用 **=ns** 指定短整型网格。
对于更大的整数，可以考虑使用 **=ni**，否则请使用默认的浮点网格格式。

示例
----

多边形内和边界上的节点值为0，外部值为1::

    gmt grdmask coastline_*.xy -R-60/-40/-40/-30 -I5m -N1/0/0 -Gland_mask.nc=nb -V

数据点周围50千米范围的节点值为1，其余为NaN::

    gmt grdmask data.xyz -R-60/-40/-40/-30 -I5m -NNaN/1/1 -S50k -Gdata_mask.nc=nb -V

将多边形的ID作为多边形内部节点的值::

    gmt grdmask plates.gmt -R-40/40/-40/40 -I2m -Nz -Gplate_IDs.nc=ns -aZ=POL_ID -V

将多边形的ID作为多边形内部节点的值，但多边形ID从100开始::

    gmt grdmask plates.gmt -R-40/40/-40/40 -I2m -Np100 -Gplate_IDs.nc=ns -V

相关模块
------------

:doc:`grdlandmask`,
:doc:`grdmath`,
:doc:`grdclip`,
:doc:`mask`,
:doc:`clip`