.. index:: ! gshhg
.. include:: common_SYN_OPTs.rst_

gshhg
=====

:官方文档: :doc:`gmt:supplements/gshhg/gshhg`
:简介: 从 GSHHG 或 WDBII 数据文件中提取数据

**gshhg** 读取海岸线文件（GSHHG）或者政治边界和河流（WDBII），并输出结果。
该模块会自动处理不同数据集之间的差异。可以设置是否显示段头部信息，头部
信息的格式为 ::

    ID npoints hierarchical-level source area f_area west east south north container ancestor

- *hierarchical-level* 海岸线多边形的级别，从 1（海岸线）到 4（湖中岛等）。

- *source* 来源为 W（World Vector Shoreline）或者 C（CIA World Data Bank II），
  如果湖泊是河流中的湖泊，将使用小写字母。

- *west east south north* 是矩形边界。

- *area* 是多边形区域的面积，单位为 km^2

- *f\_area* 为其父多边形的面积。

- *container* 为包含此多边形 ID 的 ID，如果没有，设置为 -1

- *ancestor* 是 full 分辨率数据集中多边形的 ID，通过该分辨率数据产生当前多边形。
  如果当前多边形也为 full 分辨率数据，则没有祖先，因此设置为 -1

对于线数据，其头部信息格式为 ::

    ID npoints hierarchical-level source west east south north

更详细的信息见 `技术细节`_

语法
----

**gmt gshhg** *binaryfile.b* [ |-A|\ *min* ] [ |-G| ] [ |-I|\ *id* ]
[ |-L| ] [ |-N|\ *level* ] [ |-Q|\ **e**\|\ **i** ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT--| ]

必选选项
--------

*binaryfile.b*
    GSHHG 或 WDBII 二进制数据文件，随 GSHHG 数据补充文件一起分发。
    可以使用 5 种标准分辨率（full, high, intermediate, low, crude）。

可选选项
--------

.. _-A:

**-A**\ *min*
    输出面积大于等于 *min* 的特征 [默认输出所有多边形]

.. _-G:

**-G**
    在数据段前加 % ，后加 NaN 以便输出数据可以被 Matlab 或和 Octave 导入

.. _-I:

**-I**\ *id*
    只输出 ID 为 *id* 的特征信息。使用 **-Ic** 仅输出所有的大陆，见
    下面的 `特定多边形`_

.. _-L:

**-L**
    只输出多边形或者线段的段头部信息 [默认同时输出段信息和数据]

.. _-N:

**-N**\ *level*
    只输出 *level* 级别的数据特征 [默认输出所有的级别]

.. _-Q:

**-Qe**\|\ **i**
    控制如何处理河流中的湖泊（即河流足够大，中间形成湖泊）。
    **-Qe** 排除这些湖泊；
    **-Qi** 为 **-Qe** 的相反操作，即只包含这种湖泊 [默认输出所有多边形]。

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-ocols.rst_

示例
----

将整个 intermediate 分辨率的 GSHHG 二进制文件转换为 Matlab 可使用的格式 ::

    gmt gshhg gshhs_i.b -G > gshhs_i.txt

在 full 分辨率河流数据集中提取段头部信息 ::

    gmt gshhg wdb_rivers_f.b -L > riverlisting.txt

从 high 分辨率数据中提取湖泊，但不包含河流形成的湖泊 ::

    gmt gshhg gshhs_h.b -Qe -N2 > all_lakes.txt

特定多边形
----------

全球范围内的较大的多边形：

====== =================================
  ID   Landmass
====== =================================
  0    Eurasia
  1    Africa
  2    North America
  3    South America
  4    Antarctica (AC grounding line)
  5    Antarctica (AC ice line)
  6    Australia
  7    Greenland
  8    New Guinea
  9    Borneo
 10    Madagascar
 11    Baffin Island
 12    Indonesia
====== =================================

数据文件
--------

gshhg 读取的文件为原始的二进制多边形文件，可通过
`NCEI Shoreline Coastline Resources <https://www.ngdc.noaa.gov/mgg/shorelines/>`_ 或
`SOEST GSHHG Site <https://www.soest.hawaii.edu/pwessel/gshhg>`_ 获得。
需要注意的是，这里的数据和 gmt 中 :doc:`gmtselect`，:doc:`grdlandmask`，
以及 :doc:`coast` 模块用的 NetCDF 格式的数据是不同的

技术细节
--------

希望使用自己程序访问 GSHHG 和 WDBII 数据的用户可以查看 gmt 源码中的 :file:`gshhg.c` 和
:file:`gshhg.h` 并熟悉他们的数据格式。GMT 并没有用来读取这些文件的 MATLAB 代码，但 Mathworks
和 IDL 都存在此类工具。但是，这些工具一般都不频繁更新，因此，随着数据文件的更新，这些
工具可能已经失效。因此，在这里给出一些技术细节。

**GSHHG**

GSHHG (The Global Self-consistent, Hierarchical, High-resolution Geography Database) 最初为 GSHHS，是一个海岸线数据库。
其中包含大陆和岛屿（1 级）、湖泊（2 级）、湖中岛（3 级）以及湖中岛中湖（4 级）
共 4 个等级的封闭多边形，使用 |-N| 选项可以提取对应级别的数据。

一级数据：大陆的 ID 序号在最前面，可以通过 **-Ic** 选项提取，其中欧亚大陆、非洲、北美、
南美、南极和澳大利亚的 ID 分别为 0 到 5，按面积大小排序。

二级数据有两组：常规的湖和河流内的湖泊；后者中湖泊是河流的一部分，这只有在河流特别宽的时
候才出现，使用 |-Q| 选项可以操作这些多边形。

所有分辨率数据均没有自相交。并且对所有的多边形计算了面积，面积计算的方法为：以多边形的中心
使用兰伯特等积投影，椭球设置为 WGS-84，然后计算投影后的面积。

GMT 使用 GSHHG 作为背景数据，然后使用与分辨率有关的网格将多边形分块，在程序运行中需要这些
多边形时，则将不同块中的数据重新组成封闭的多边形。有关其他更多的 GSHHG 处理方法，见
Wessel & Smith (1996)。

**WDBII**

WDBII 数据集主要包含河流和各类边界，其中的线段没有任何顺序，因此，不能只提取与一条河流或者国家相关的信息。
该数据集使用 Douglas-Peucker 算法从 full 分辨率的数据中派生出了其他 4 个较低分辨率的数据，因此，
随着分辨率的降低，自相交的可能性变大。WDBII 和 GSHHG 中都含有河流中的湖泊数据，想要访问
这两个数据集的用户可以使用段标题的结构来识别这些特征，并且这些河流中湖泊也是 WDBII 中唯一
的封闭多边形。

河流文件中有很多级别：

    - 河流中的湖泊（0）

    - 永久主要河流（1），其他主要河流（2），更小的主要河流（3），

    - 次要河流（4）

    - 主要间歇性河流（5），其他主要间歇性河流（6），更小的间歇性河流（7）

    - 主要运河（10），次要运河（11），灌溉类型运河（12）

边界文件分为三个级别：

    - 国家边界（1）

    - 国内边界（2）

    - 国际海洋边界（3）

通过 |-N| 选项可提取对应类别的数据。

参考文献
--------

Douglas, D. H., and T. K. Peucker, 1973, Algorithms for the reduction of
the number of points required to represent a digitized line of its
caricature, *Can. Cartogr., 10*, 112–122.

Gorny, A. J., 1977, *World Data Bank II General User GuideRep. PB
271869*, 10pp, Central Intelligence Agency, Washington, DC.

Soluri, E. A., and V. A. Woodson, 1990, World Vector Shoreline, *Int.
Hydrograph. Rev., LXVII(1)*, 27–35.

Wessel, P., and W. H. F. Smith, 1996, A global, self-consistent,
hierarchical, high-resolution shoreline database, *J. Geophys. Res.,
101(B4)*, 8741–8743.

相关模块
--------

:doc:`coast`
