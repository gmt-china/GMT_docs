:author: 田冬冬, 周茂, 朱邓达, 陈箫翰
:date: 2026-01-13

.. index:: ! triangulate
.. program:: triangulate

triangulate
============

:官方文档: :doc:`gmt:triangulate`
:简介: 笛卡尔数据的 Delaunay 三角剖分或 Voronoi 图和网格化

**triangulate** 读取表数据并进行 Delaunay 三角化，该三角化方法能最大程度地避免狭窄
的三角形。如果使用了 :option:`-R` 和 :option:`-J` 选项，则表明输入为地理坐标，首先使用投影，
然后执行三角化。默认情况下，输出组成每个三角形的点 ID，并输出到标准输出。ID 编号
为输入文件时，点的位置，从 0 开始计算。该模块同时可以创建一个多段数据文件，通过
管道传递给 :doc:`plot` 模块后可绘制三角网。如果设置了 :option:`-G` 和 :option:`-I` 选项，则
基于平面三角形计算网格。具体算法来自 Watson (1982) [默认] 或 Shewchuk (1996) ，
此选择是在 GMT 安装期间确定的，通过 ``gmt get GMT_TRIANGULATE`` 可查看具体安装了
哪种算法，如果安装了 Shewchuk 算法，还可以进一步计算 Voronoi 图，并可选择自然最邻
近算法对数据进行网格化。

**注意**：对于全球范围或超大范围的地理数据，应该考虑使用 :doc:`sphtriangulate` ，
因为 **triangulate** 是笛卡尔坐标或小范围地理区域算子，无法识别周期性或极地边界条件。

语法
----

**gmt triangulate**
[ *table* ]
[ :option:`-A` ]
[ :option:`-C`\ *slpfile* ]
[ :option:`-D`\ **x**\|\ **y** ]
[ :option:`-E`\ *empty* ]
[ :option:`-G`\ *outgrid* ]
[ :option:`-I`\ *increment* ]
[ :option:`-J`\ *parameters* ]
[ :option:`-L`\ *indexfile*\ [**+b**] ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-Q`\ [**n**] ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ [*first*][**+z**\ [**a**\|\ **l**\|\ **m**\|\ **p**\|\ **u**]][**+n**] ]
[ :option:`-T` ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z` ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_intables.rst_

可选选项
--------

.. option:: -A

**-A**
    计算笛卡尔三角形的面积，并将面积追加到输出分段头中 [默认不计算面积]。需要使用 :option:`-S` ，且不兼容 :option:`-Q` 。

.. option:: -C

**-C**\ *slpfile*
    读取坡度网格 *slpfile* （单位为度），并使用 CURVE 算法计算水深测量中传播的不确定性
    (Zambo et al, 2016)。需要 :option:`-G` 选项指定输出网格，但不需要 :option:`-R` ，:option:`-I` 等选项，这些
    信息通过网格获取。该选项不能和 :option:`-D`，:option:`-M`，:option:`-N`，:option:`-Q`，:option:`-S` 以及 :option:`-T`
    选项共同使用。

.. option:: -D

**-Dx**\|\ **y**
    在设置 :option:`-G` 选项时，计算由平面面片（planar facets）表示的表面的 x 或 y 方向导数。

.. option:: -E

**-E**\ *empty*
    使用 :option:`-G` 选项时，设置空节点的值，默认为 NaN

.. include:: explain_grd_out.rst_
..

    使用三角剖分将数据网格化为均匀网格（由 :option:`-R` 和 :option:`-I` 控制）。
    插值是在原始坐标系中进行的，因此如果三角形靠近极点，最好在使用 **triangulate** 之前将所有数据投影到局部坐标系中，或者改用 :doc:`sphtriangulate` 。
    对于自然最近邻网格化，必须添加 :option:`-Q`\ **n** 。

.. include:: explain_-I.rst_

.. include:: explain_-J.rst_

.. option:: -L

**-L**\ *indexfile*\ [**+b**]
    指定包含先前计算好的 Delaunay 信息的文件的名称。
    每条记录必须包含输入数据表 (*table*) 中一个三角形的三个节点编号 [默认使用 Delaunay 三角剖分计算这些信息]。
    如果 *indexfile* 是二进制文件，且其读取方式与二进制输入数据表相同，则可以追加 **+b** 以加快读取速度 [默认以 ASCII 格式读取节点]。

.. option:: -M

**-M**
    将输出的三角网以多段线的形式输出，中间以段信息分隔 [默认输出顶点索引]

.. option:: -N

**-N**
    与 :option:`-G` 选项同时使用，同时输出所有 Delaunay 顶点编号的三元组 [默认只输出网格]

.. option:: -Q

**-Q**\ [**n**]
    改为输出 Voronoi 胞元的边 [默认输出 Delaunay 三角形的边]。
    需要使用 :option:`-R`，且仅在链接了 Shewchuk [1996] 库时可用。
    注意，输出时将忽略 :option:`-Z` 。追加 **n** 将这些边组合成封闭的 Voronoi 多边形。

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ [*first*][**+z**\ [**a**\|\ **l**\|\ **m**\|\ **p**\|\ **u**]][**+n**]
    将三角形作为多边形分段输出，各分段由包含节点编号 *a-b-c* 和 **-Z**\ *polynumber* 的分段头记录分隔。
    如果使用了 **+n** 标志，将跳过 *polynumber* 和节点编号。
    追加 *first* （ *first* 为整数），从 *first* 开始计数来报告多边形编号 [默认从零开始]。
    本选项与 :option:`-Q` 不兼容。
    附加 **+z** 将 **-Z**\ *zvalue* 置于分段头中，其中 *zvalue* 是每个三角形的代表值。

    **注意**： **+z** 会自动使用 :option:`-Z` 。可以使用以下附加设置：

        * **a** ：选择平均值 [默认]
        * **l** ：选择最小值
        * **m** ：选择中位数
        * **p** ：选择众数
        * **u** ：选择最大值

.. option:: -T

**-T**
    即使使用 :option:`-G` 选项输出网格，仍然输出边或者多边形 [默认输出网格时不输出三角网或
    Voronoi 多边形]。

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**
    读取 (*x, y, z*) 数据，使用 :option:`-M` 或 :option:`-S` （且未带 **+z**）时输出 *z* 。

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

.. include:: explain_float.rst_

.. include:: explain_inside.rst_

示例
----

对 :file:`samples.xyz` 进行三角化，在二进制文件中保存三角网结果，并创建网格 ::

    gmt triangulate samples.xyz -bo -R0/30/0/30 -I2 -Gsurf.nc > samples.ijk

使用 15 cm 的墨卡托图绘制基于上述同样数据生成的三角网 ::

    gmt triangulate samples.xyz -M -R-100/-90/30/34 -JM15c |\
        gmt plot -R-100/-90/30/34 -JM15c -W0.5p -B1 -pdf network

同样使用上述数据，但绘制 Voronoi 图 ::

    gmt triangulate samples.xyz -M -Q -R-100/-90/30/34 -JM15c |\
        gmt plot -R-100/-90/30/34 -JM15c -W0.5p -B1 -pdf cells

将 Voronoi 的线段组合成多边形并根据他们的 ID 填充 ::

    gmt triangulate samples.xyz -M -Qn -R-100/-90/30/34 -JM15c | \
        gmt plot -R-100/-90/30/34 -JM15c -W0.5p+cf -L -B1 -Ccolors.cpt -L -pdf polygons

使用自然最邻近算法进行网格化 ::

    gmt triangulate samples.xyz -Gnnn.nc -Qn -R-100/-90/30/34 -I0.5

说明
----------

水深网格的不确定度传播需要水平和垂直方向的不确定度，并根据局部坡度进行加权。
更多详情请参阅 *Zambo et al.* [2014] 和 *Zhou and Liu* [2004] 参考文献。

参考文献
--------

Shewchuk, J. R., 1996, Triangle: Engineering a 2D Quality Mesh Generator
and Delaunay Triangulator, First Workshop on Applied Computational
Geometry (Philadelphia, PA), 124-133, ACM, May 1996.

Watson, D. F., 1982, Acord: Automatic contouring of raw data, *Comp. &
Geosci.*, **8**, 97-101.

Zambo, S., Elmore, P. A., Bourgeois, B. S., and Perkins, A. L., 2016,
Uncertainty estimation for sparse data gridding algorithms,
Proceedings of the U.S. Hydro Conference,National Harbor, MD, 16-19 March 2015.

Zhou, Q., and Liu, X., 2004, Error analysis on grid-based slope and aspect
algorithms, *Photogrammetric Eng. & Remote Sensing*, **70** (8), 957-962.

`Shewchuk's Homepage <http://www.cs.cmu.edu/~quake/triangle.html>`_

相关模块
--------

:doc:`greenspline`,
:doc:`nearneighbor`,
:doc:`contour`,
:doc:`sphdistance`,
:doc:`sphinterpolate`,
:doc:`sphtriangulate`,
:doc:`surface`
