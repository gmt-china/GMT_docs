.. index:: ! sphtriangulate
.. include:: common_SYN_OPTs.rst_

sphtriangulate
==============

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:sphtriangulate`
:简介: 创建球面 Delaunay 三角网或 Voronoi 图

**Delaunay 三角网** 是 Delaunay 三角化的结果。Delaunay 三角化是一种空间三角剖分算法。
该算法的优点在于能避免三角网结果中出现“极瘦” 的三角形。

**Voronoi 图** 又称泰森多边形，由 Delaunay 三角网中连接两相邻点线段的中垂线组成的连续
多边形组成。

**sphtriangulate** 读取一个或者多个经纬度坐标文件并进行球面 Delaunay 三角化。**-Qv**
选项可进步一生成 Voronoi 图。通常，多边形输出结果为闭合的并且可填充，使用 |-T| 选项
则输出构成多边形的弧段而非多边形。

语法
----

**gmt sphtriangulate**
[ *table* ]
[ |-A| ]
[ |-C| ]
[ |-D| ]
[ |-L|\ *unit* ]
[ |-N|\ *file* ]
[ |-Q|\ **d**\|\ **v** ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

可选选项
--------

.. _-A:

**-A**
    计算球面三角的面积或多边形（见 |-Q| ）的面积并输出到段信息中 [默认不计算面积]。
    面积单位见 |-L| 选项。

.. _-C:

**-C**
    用于节省内存。该模块默认在运算过程中同时保存地理坐标和笛卡尔坐标，但对于大型数据
    集，这可能会占据很大内存，因此使用该选项可以只保留其中一种坐标以节省内存，必要的
    时候 GMT 会自动实现坐标转换。

.. _-D:

**-D**
    用于删掉重复点 [默认不删除]。

.. _-L:

**-L**\ *unit*
    指定距离和面积计算的单位，可选项包括 **e** (m)， **f** (foot)， **k** (km)，
    **M** (mile)，**n** (nautical mile)，**u** (survey foot)，或 **d** (spherical degree)。
    除非设置了 **-je** ，否则使用球面近似距离；在这种情况下，计算面积前将纬度转换为
    自定义的纬度。当单位设置为度时，面积的结果为球面度。

.. _-N:

**-N**\ *file*
    将多边形信息写到 *file* 文件中。对于Delaunay 三角网，相关信息包括：每个三角形三个
    定点的编号（若设置 |-A| 还包括三角形面积）；对于 Voronoi ，包括节点坐标（ |-A| ）
    选项使用同上。如果输出文件格式为 ASCII，这些信息都显示在段信息中，并可将整个结果输出
    到标准输出，无需使用 |-N| 选项；如果输出文件为二进制文件，则 |-N| 选项是必须的。

.. _-Q:

**-Q**\ **d**\|\ **v**
    **d** 选项为计算 Delaunay 三角网，**v** 选项为计算 Voronoi 图 [默认使用 **d** ]。

.. _-T:

**-T**
    将结果输出为弧段 [默认输出闭合的三角形或者多边形]。当使用 |-A| 选项时，同时
    计算弧段的长度并写到段信息中，单位见 |-L| 选项。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

示例
----

从远程数据文件 :file:`hotspots.txt` 中创建球面三角网，并绘制 ::

    gmt sphtriangulate @hotspots.txt -Qd -T | gmt plot -Rg -JG-120/-30/7i -Bafg -W3p -pdf map

三角化 :file:`testdata.txt` 中的点，创建 Voroni 图并绘制 ::

    gmt sphtriangulate testdata.txt -Qv | gmt plot -Rg -JG30/30/6i -L -W1p -Bag -pdf testdata

基于包含多段记录的数据文件 :file:`globalnodes.txt` 计算 Delaunay 三角网，
并计算每个三角形的面积，输出到段信息中 ::

    gmt sphtriangulate globalnodes.txt -Qd -A > global_tri.txt

除上述示例外，`GMT 官方示例 35 <https://docs.generic-mapping-tools.org/6.3/gallery/ex35.html>`__
和 `示例 48 <https://docs.generic-mapping-tools.org/6.3/gallery/ex48.html>`__
也使用了该模块。

注意事项
--------

多边形或三角形面积的计算使用了 STRIPACK 算法。该算法需要输入中不包含重复点。
:doc:`blockmean` 等模块可以将多个接近的点合并成单个点。**sphtriangulate**
的 |-D| 选项也可以删除重复点，但是这通过对点的坐标精确比较实现，对大型
数据集来说，运行可能会很慢。STRIPACK 算法在检测到重复点时，会直接退出执行。

参考文献
--------

Renka, R, J., 1997, Algorithm 772: STRIPACK: Delaunay Triangulation and
Voronoi Diagram on the Surface of a Sphere, *AMC Trans. Math. Software*,
**23**\ (3), 416-434.

相关模块
--------

:doc:`triangulate`,
:doc:`sphdistance`
