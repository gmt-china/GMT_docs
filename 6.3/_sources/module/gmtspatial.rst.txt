.. index:: ! gmtspatial
.. include:: common_SYN_OPTs.rst_

gmtspatial
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:gmtspatial`
:简介: 对点，线和多边形进行地理空间操作


**gmtspatial** 读取一个或者多个文件，文件中包含线或多边形等特征，对这些
特性进行操作，包括：面积计算，多边形相交等。

语法
----

**gmt spatial** [ *table* ]
[ |-A|\ [**a**\ *min_dist*][*unit*]]
[ |-C| ]
[ |-D|\ [**+a**\ *amax*][**+c\|C**\ *cmax*][**+d**\ *dmax*][**+f**\ *file*][**+p**][**+s**\ *fact*] ]
[ |-E|\ **+p**\|\ **+n** ]
[ |-F|\ [**l**] ]
[ |-I|\ [**e**\|\ **i**] ]
[ -L|\ *dist*\ /*noise*\ /*offset* ]
[ |-N|\ *pfile*\ [**+a**][**+p**\ *start*][**+r**][**+z**] ]
[ |-Q|\ [*unit*][**+c**\ *min*\ [/*max*]][**+h**][**+l**][**+p**][**+s**\ [**a**\|\ **d**]] ]
[ |SYN_OPT-R| ]
[ |-S|\ **b**\ *width*\|\ **h**\|\ **i**\|\ **u**\|\ **s**\|\ **j** ]
[ |-T|\ [*clippolygon*] ]
[ |SYN_OPT-V| ]
[ |-W|\ *dist*\[*unit*][**+f**\|\ **l**] ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

可选选项
--------

.. _-A:

**-A**\ [**a**\ *min_dist*][*unit*]
    空间最邻近分析：计算每个点的最邻近点，并报告点对之间的距离和 ID （ID 是
    以输入顺序从 0 开始计数）。**-Aa** 选项用来筛选距离大于 *min_dist* 的
    点对，输出数据可能会进行一定的平均。如果输出的 ID 为负数，则表示原始的点
    被平均，这里的 ID 的绝对值为取平均过程中第一个点的 ID。

    **注** ：输入数据中假定包含 (*lon, lat*) 或者 (*x, y*)，此外还可以包括
    z 值和权重两列，在进行平均时，会同时计算位置和 z 值的加权平均值。

.. _-C:

**-C**
    和 |-R| 选项同时使用，以 |-R| 确定的范围裁剪多边形，输出结果为闭合的
    多边形（ |-T| 选项可以使用多边形裁剪多边形）

.. _-D:

**-D**\ [**+a**\ *amax*][**+c\|C**\ *cmax*][**+d**\ *dmax*][**+f**\ *file*][**+p**][**+s**\ *fact*]
    检查输入线或者多边形之间是否存在重复，若使用 **+f** 则检查该选项给定的文件
    中的元素是否与输入文件中的元素存在重复。在确定是否重复的时候，GMT 会自动
    考虑精确匹配（相同的个数和坐标），近似匹配（两个特征之间最近点之间的平均
    小于阈值）以及某些特征是否反转。

    - **+a**\ *amax* 设置多边形之间面积差的阈值，若大于 *amax* ，认为不想等，
      小于 *amax* ，则认为近似想等，默认值为 0.01

    - **+c\|C**\ *cmax* 两特征之间的平均距离处除平均长度称为相近比 ，
      设置两条线之间的相近比阈值 *cmax* ，若两条线的平均相近比
      大于该值认为两条线为重复，反之；默认值为 0.01 。
      **C** 选项则使用中值而非平均值

    - **+d**\ *dmax* 设置点距阈值 *dmax* ，大于该值认为为重复点，默认值为 0

    - **+p** 默认情况下会计算一条线和另一条线上所有点之间的距离，如果使用
      **+p** 选项，则只考虑在另一条线（非延长线）有垂直投影的点，这样会减小
      一定的计算量

    - **+s**\ *fact* 设置两条线的长度比值的阈值为 *fact* ，默认为 2，若大于
      值，则两条线分别为子集和超集。

    在进行重复检查时，根据特征的种类，GMT 将会自动选取上述选项中的几项进行判断

.. _-E:

**-E**\ **+p**\|\ **n**
    重置所有多边形顶点的顺序。 **+p** 改为顺时针， **+n** 改为逆时针。

.. _-F:

**-F**\ [**l**]
    强制输入数据变为多边形，如果输入为多边形，则自动实现闭合。使用 **l** 选项
    来确保输入的线段不被识别为多边形

.. _-I:

**-I**\ [**e**\|\ **i**]
    确定所有多边形对之间的相交点的位置。**i** 只计算自相交的多边形的相交点的
    位置， **e** 只计算不同多边形之间的相交点的位置 [默认为都计算]。输出将
    包括相交点的坐标，相对于整段线长度的位置以及两个多边形的名称。

.. _-L:

**-L**\ *dist*\ /*noise*\ /*offset*
    删除经数字化得到的多边形在 |-R| 边界上的线，通过设置 *dist* （单位为 m
    ，默认值为 0），坐标误差 *noise* [1e-10] 以及最大的偏移量 *offset* [1e-10]
    等参数的极限值来判断是否位于边界上。

.. _-N:

**-N**\ *pfile*\ [**+a**][**+p**\ *start*][**+r**][**+z**]
    确定点是否在多边形内。如果在多边形的内部，则报告对应的多边形的 ID，
    *pfile* 为报告的多边形结果。

    - **+a** 表示某条线或多边形的所有点均位于多边形内

    - **+r** 不输出表数据，只报告对应的多边形

    - **+p** 设置初始运行的多边形的 ID 为 *start* ，并在运行中对多边形 ID 进行
      递增，默认 *start* 为 0。除 **+p** 选项为，还可使用 |-Z| 选项或者
      |-L| 选项在头段信息中设置多边形的 ID

    - **+z** 将 ID 作为一列输出，默认只写到头部信息中

.. _-Q:

**-Q**\ [*unit*][**+c**\ *min*\ [/*max*]][**+h**][**+l**][**+p**][**+s**\ [**a**\|\ **d**]]
    测量多边形的面积或者线的长度。对于多边形，还计算其中心位置；对于线，则计算其
    一半长度的位置。面积的计算取决于投影参数 :term:`PROJ_ELLIPSOID` ，应该使用最
    贴合的椭球以获得准确的结果。

    - **+h** 将多边形面积写到段信息中 [默认输出到标准输出]

    - **+c**\ *min*\ [/*max*] 筛选线长度或多边形的面积为 *min* 到 *max* 的目标；
      如果不指定 *max* ，则默认为无穷大

    - **+s**\ [**a**\|\ **d**] 对线长度或多边形面积进行排序， **a** 为升序，
      **d** 为降序，默认为升序

    - **+p** 将多边形闭合从而将所有的输入视为多边形

    - **+l** 将输入视为线而不是多边形，即使是闭合的多边形也视为线

.. include:: explain_-R.rst_

.. _-S:

**-S**\ **b**\ *width*\|\ **h**\|\ **i**\|\ **j**\|\ **s**\|\ **u**
    对多边形进行一定处理。

    - **-Sb**\ *width* 计算缓冲多边形，*width* 为缓冲区的宽度

    - **-Sh** 对带孔的多边形进行标记并重置其顶点顺序（只是为了方便绘制）

    - **-Si** 返回多边形的交集，结果是闭合的

    - **-Su** 返回多边形的并，结果也是闭合的

    - **-Ss** 使用日期变更线（180 度经线）剖分多边形

    - **-Sj** 将使用日期变更线剖分后的多边形合并

    **注1** ：只有 **-Sb**, **-Sh** 和 **-Ss** 已经实现，其他选项还未实现。

    **注2** ：**-Sb** 是纯笛卡尔运算，因此 *width* 的单位和数据单位相同。对
    地理坐标而言，*width* 必须是以度为单位；或者将坐标投影后进行该操作，再
    转换为地理坐标。

.. _-T:

**-T**\ [*clippolygon*]
    使用给定的多边形 *clippolygon* 裁剪多边形，结果可能不是闭合的多边形。
    与 |-R| 选项同时使用时，同时参与裁剪。

.. include:: explain_-V.rst_

.. --W:

**-W**\ *dist*\[*unit*][**+f**\|\ **+l**]
    对多段线的第一段和最后一段以其原本的方位角进行延长， *dist* 为延长距离，
    *unit* 为单位（仅限地理坐标）。 对于地理坐标，可以使用 
    distf\[*unit*]/distl\[*unit*] 语法分别设置起始段和结尾段延长的距离和单位。
    **+f** 和 **+l** 分别表示只在起始段或者结尾段延长，默认在两端都延长。

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_inside.rst_

示例
----

确定远程澳大利亚国界线构成的多边形的中心点和面积 ::

    gmt spatial @GSHHS_h_Australia.txt -fg -Qk

将 :file:`lines.txt` 文件中的线转换为闭合的多边形 ::

    gmt spatial lines.txt -F > polygons.txt

计算 :file:`polygons.txt` 文件中的所有多边形的面积 ::

    gmt spatial polygons.txt -Q > areas.txt

使用与上例同样的文件，将面积写到段头信息中，同时将所有的多边形的顶点顺序转换为
逆时针 ::

    gmt spatial polygons.txt -Q+h -E+p > areas.txt

计算 :file:`janmayen_land_full.txt` 文件中所有多边形的面积，并把面积写到头段信息
中，以面积对这些多边形从大到小排列，并只保留面积大于 1000 平方米的多边形 ::

    gmt spatial -Qe+h+p+c1000+sd -V janmayen_land_full.txt > largest_pols.txt

计算文件 :file:`A.txt` 和文件 :file:`B.txt` 的相交点 ::

    gmt spatial A.txt B.txt -Ie > crossovers.txt

以多边形文件 :file:`B.txt` 裁剪多边形文件 :file:`A.txt` ，输出结果为线 ::

    gmt spatial A.txt -TB.txt > line.txt

如果某多边形中存在有孔的多边形，首先对其中的有孔多边形进行标记并重置顶点顺序，
以便后续的绘图或填充  ::

    gmt spatial file.txt -Sh > organized_file.txt

注意事项
--------

GDAL/GMT 格式的文件被认为是完整的数据集，因此在使用该模块时，不能同时输入多个
该格式的文件。正确的做法是先使用 :doc:`gmt:gmtconvert` 模块转换为普通的表数据，
然后再使用该模块。

相关模块
--------

:doc:`gmt:gmtconvert`，
:doc:`gmtselect`，
:doc:`gmtsimplify`，
