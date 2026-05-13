.. index:: ! triangulate
.. include:: common_SYN_OPTs.rst_

triangiulate
============

:官方文档: :doc:`gmt:triangulate`
:简介: 笛卡尔数据的 Delaunay 三角剖分或 Voronoi 图和网格化

**triangulate** 读取表数据并进行 Delaunay 三角化，该三角化方法能最大程度地避免狭窄
的三角形。如果使用了 |-R| 和 |-J| 选项，则表明输入为地理坐标，首先使用投影，
然后执行三角化。默认情况下，输出组成每个三角形的点 ID，并输出到标准输出。ID 编号
为输入文件时，点的位置，从 0 开始计算。该模块同时可以创建一个多段数据文件，通过
管道传递给 :doc:`plot` 模块后可绘制三角网。如果设置了 |-G| 和 |-I| 选项，则
基于平面三角形计算网格。具体算法来自 Watson (1982) [默认] 或 Shewchuk (1996) ，
此选择是在 GMT 安装期间确定的，通过 ``gmt get GMT_TRIANGULATE`` 可查看具体安装了
哪种算法，如果安装了 Shewchuk 算法，还可以进一步计算 Voronoi 图，并可选择自然最邻
近算法对数据进行网格化。

语法
----

**gmt triangulate** [ *table* ]
[ |-C|\ *slpfile* ]
[ |-D|\ **x**\|\ **y** ]
[ |-E|\ *empty* ]
[ |-G|\ *outgrid* ]
[ |SYN_OPT-I| ]
[ |-J|\ *parameters* ]
[ |-M| ]
[ |-N| ]
[ |-Q|\ [**n**] ]
[ |SYN_OPT-R| ]
[ |-S| ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |-Z| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

可选选项
--------

.. _-C:

**-C**\ *slpfile*
    读取坡度网格 *slpfile* （单位为度），并使用 CURVE 算法计算水深测量中传播的不确定性
    (Zambo et al, 2016)。需要 |-G| 选项指定输出网格，但不需要 |-R| ，**-I** 等选项，这些
    信息通过网格获取。该选项不能和 **-D**，**-F**，**-M**，**-N**，**-Q**，**-S** 以及 **-T**
    选项共同使用。

.. _-D:

**-Dx**\|\ **y**
    在设置 |-G| 选项时，求 x 方向或 y 方向的导数

.. _-E:

**-E**\ *empty*
    使用 |-G| 选项时，设置空节点的值，默认为 NaN

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    使用三角化将数据网格化，该选项用于指定输出网格名。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

.. include:: explain_-I.rst_

.. include:: explain_-J.rst_

.. _-M:

**-M**
    将输出的三角网以多段线的形式输出，中间以段信息分隔 [默认输出顶点索引]

.. _-N:

**-N**
    与 |-G| 选项同时使用，用来将三角网的顶点输出到标准输出 [默认只输出网格]

.. _-Q:

**-Q**\ [**n**]
    输出 Voronoi 图的边，而不是三角网的边。需要和 |-R| 同时使用，并且只有使用 Shewchuk
    算法时可用。**n** 选项用来将边组成闭合的多边形

.. include:: explain_-R.rst_

.. _-S:

**-S**
    以多边形的形式输出三角网，中间以段头信息分隔，不能和 |-Q| 同时使用

.. _-T:

**-T**
    即使使用 |-G| 选项输出网格，仍然输出边或者多边形 [默认输出网格时不输出三角网或
    Voronoi 多边形]。

.. _-Z:

**-Z**
    指定输出和输入为 (x,y,z) 形式的数据，使用 |-G| 选项时，会自动使用该选项 [默认为 (x,y) ]

.. include:: explain_-V.rst_

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

`Shewchuk's Homepage <http://www.cs.cmu.edu/~quake/triangle.html>`__

相关模块
--------

:doc:`gmt:greenspline`,
:doc:`nearneighbor`,
:doc:`contour`,
:doc:`sphdistance`,
:doc:`sphinterpolate`,
:doc:`sphtriangulate`,
:doc:`surface`
