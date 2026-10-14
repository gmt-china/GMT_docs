.. index:: ! sphdistance
.. include:: common_SYN_OPTs.rst_

sphdistance
===========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:sphdistance`
:简介: 在球上创建 Voronoi 距离，节点或自然最邻近网格

**sphdistance** 读取一个或多个 ASCII（或二进制）坐标文件，使用所有的坐标创建 Voronoi 图。
得到的多边形用来创建球面上的网格，其中网格值为到坐标文件中坐标的最近距离（见 |-E| ）
。 创建 Voronoi 图使用 STRIPACK 算法。可以使用 :doc:`sphtriangulate` 提前创建多边形文件
以节省时间和运行时所需的空间。

语法
----

**gmt sphdistance** [ *table* ]
|-G|\ *grdfile*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-C| ]
[ |-D| ]
[ |-E|\ **d**\|\ **n**\|\ **z**\ [*dist*] ]
[ |-L|\ *unit* ]
[ |-N|\ *nodetable* ]
[ |-Q|\ *voronoi.txt* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]

    输出网格文件名，其中各子选项的含义见 
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-C:

**-C**
    用于节省内存。该模块默认在运算过程中同时保存地理坐标和笛卡尔坐标，但对于大型数据
    集，这可能会占据很大内存，因此使用该选项可以只保留其中一种坐标以节省内存，必要的
    时候 GMT 会自动实现坐标转换。在使用 |-Q| 选项时，该选项无用

.. _-D:

**-D**
    用于删掉重复点 [默认不删除，即假定数据中不存在重复]

.. _-E:

**-Ed**\|\ **n**\|\ **z**\ [*dist*]
    指定球面网格中每个网格值的类型。

    - **d** 默认选项，计算球面上网格点到输入坐标的最近距离

    - **n** 将网格值设置为所在多边形的 ID

    - **z** 将网格值设置为所在多边形的节点（即 Delaunay 三角网的外接圆圆心）上的值 

    *dist* 为在球面弧上进行重采样的间隔，默认为 1，单位为度。

.. _-L:

**-L**\ *unit*
    指定距离计算的单位，可选项包括 **e** (m)， **f** (foot)， **k** (km)，
    **M** (mile)，**n** (nautical mile)，**u** (survey foot)，或 **d** (spherical degree)    

.. _-N:

**-N**\ *nodetable*
    从 *nodetable* 文件度读取每个 Voronoi 多边形相关的节点坐标和面积等信息 [默认从
    输出 ASCII 文件的段信息中获取]。 

.. _-Q:

**-Q**\ *voronoi.txt*
    指定 Voronoi 多边形文件 [默认使用输入数据构建 Voronoi 图]。输入数据为二进制文件，
    需要 |-N| 选项指定节点信息。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

创建一个球面网格，网格值为到 :file:`hotspots.txt` 文件中点的最近距离，然后以 200 km
为间隔在球面网格创建等值线，每 1000 km 设置标注 ::

    gmt begin map
        gmt sphtriangulate @hotspots.txt -Qv -D > t.txt
        gmt sphdistance -Rg -I1 -Qt.txt -Gt.nc -Lk
        gmt grdcontour t.nc -JG-140/30/7i -C200 -A1000 -Bafg
    gmt end show

以 :file:`testdata.txt` 创建 Voronoi 图，并生成 1 度分辨率的全球距离网格 ::

    gmt sphdistance testdata.txt -Rg -I1 -Gglobedist.nc

上述代码也可分成两个命令 ::

    gmt sphtriangulate testdata.txt -Qv > voronoi.txt
    gmt sphdistance -Qvoronoi.txt -Rg -I1 -Gglobedist.nc

此外， `GMT 官方示例 35 <https://docs.generic-mapping-tools.org/6.3/gallery/ex35.html>`__
展示了使用本模块和全球海岸线创建海洋到海岸线的距离网格。

注意事项
--------

STRIPACK 算法需要输入中不包含重复点。
:doc:`gmt:blockmean` 等模块可以将多个接近的点合并成单个点。**sphdistance**
的 |-D| 选项也可以删除重复点，但是这通过对点的坐标精确比较实现，对大型
数据集来说，运行可能会很慢。STRIPACK 算法在检测到重复点时，会直接退出执行

参考文献
--------

Renka, R, J., 1997, Algorithm 772: STRIPACK: Delaunay Triangulation and
Voronoi Diagram on the Surface of a Sphere, *AMC Trans. Math. Software*,
**23**\ (3), 416-434.

相关模块
--------

:doc:`sphtriangulate`,
:doc:`triangulate`
