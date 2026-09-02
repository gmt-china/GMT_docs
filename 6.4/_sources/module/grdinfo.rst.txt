.. index:: ! grdinfo
.. include:: common_SYN_OPTs.rst_

grdinfo
=======

:官方文档: :doc:`gmt:grdinfo`
:简介: 提取网格文件的基本信息

**grdinfo** 模块读取一个2D网格文件并报告网格文件的相关信息。能提取的信息包括：

- X、Y、Z的最大和最小值
- 最大/最小Z值所在的位置
- X、Y的网格间隔
- X和Y方向节点数目
- 均值、标准差
- 中位数、绝对中位差（median absolute deviation）
- the mode (Least Median of Squares; LMS), LMS scale of *z*
- 值为NaN的节点数
- 网格配准方式
- 网格类型（笛卡尔数据或地理数据）

语法
----

**gmt grdinfo** *grdfiles*
[ |-C|\ [**n**\|\ **t**\] ]
[ |-D|\ [*xoff*\ [/*yoff*]][**+i**] ]
[ |-E|\ [**x**\|\ **y**][**+h**\|\ **H**\|\ **l**\|\ **L**] ]
[ |-F| ]
[ |-I|\ [*dx*\ [/*dy*]\|\ **b**\|\ **i**\|\ **r**] ]
[ |-L|\ [**0**\|\ **1**\|\ **2**\|\ **p**\|\ **a**] ]
[ |-M| ]
[ |SYN_OPT-R| ]
[ |-T|\ [*dz*]\ [**+a**\ [*alpha*]]\ [**+s**] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT--| ]

必选选项
--------

*grdfile*
    一个或多个网格文件名

可选选项
--------

.. _-C:

**-C**\ [**n**\|\ **t**\]
    将输出信息以Tab分隔显示在一行中。输出格式为::

        name w e s n z0 z1 dx dy nx ny [x0 y0 x1 y1] [med scale] [mean std rms] [n_nan] registration gtype

    默认只输出前13列。方括号中的信息仅当使用 **-M**、**-L1**、**-L2**、**-M**
    选项时才会输出。

    使用 **-Ct** 则将文件名 *name* 放在最后一列；使用 **-Cn** 则只输出数值列。

    *registration* 为网格的配准方式，0表示网格线配准，1表示像素配准；
    *gtype* 表示数据类型，0表示笛卡尔数据，1表示地理数据。

    若与 |-I| 选项一起使用，则输出格式为::

        NF w e s n z0 z1

    其中 *NF* 是总网格数目。

.. _-D:

**-D**\ [*xoff*\ [/*yoff*]][**+i**]
    将网格区域划分为多个子区域，并报告子区域的范围。

    子区域大小为 *dx* 乘 *dy*，由 |-I| 选项控制。
    *xoff/yoff* 用于指定多个子区域之间的重叠区域。
    **+i** 子选项表明若该子区域内无数据则忽略该区域。
    若使用 |-C| 选项则以 *w e s n* 格式输出每个子区域的区域范围，
    使用 **-Ct** 则在最后一列以 **-R**\ *w/e/s/n* 格式输出子区域数据范围。

    |-D| 选项示例::

        $ gmt grdinfo @earth_relief_30m -D -I180/90
        -R-180/0/-90/0
        -R0/180/-90/0
        -R-180/0/0/90
        -R0/180/0/90

    |-D| 与 |-C| 一起使用::

        $ gmt grdinfo @earth_relief_30m -D -I180/90 -C
        -180	0	-90	0
        0	180	-90	0
        -180	0	0	90
        0	180	0	90

.. _-E:

**-E**\ [**x**\|\ **y**][**l**\|\ **L**\|\ **u**\|\ **U**]
    报告每一列（**-Ex**）或每一行（**-Ey**）的极值。

    - **+u**\|\ **U** : 寻找每一列的极大值 [默认行为]
    - **+l**\|\ **L** : 寻找每一列的极小值

    其中，大写的 **+L** 表示寻找正值中最小的一个；
    大写的 **+U** 表示寻找负值中最大的一个。

.. _-F:

**-F**
    以每行输出一个信息的方式的输出信息。该选项不得与 |-C| 一起使用。

.. _-I:

**-I**\ [*dx*\ [/*dy*]\|\ **b**\|\ **i**\|\ **r**]
    报告网格数据的区域范围

    使用 **-I**\ *dx*/*dy* 会先获取网格的区域范围，并对该范围做微调使得其是 *dx*
    和 *dy* 的整数倍，并以 **-R**\ *w/e/s/n* 的形式输出。

    - **-Ir** 以 **-R**\ *w/e/s/n* 输出真实的网格区域范围
    - **-Ii** 以 **-R**\ *w/e/s/n* 输出 **img** 补充包生成的网格文件的精确范围
    - **-Ib** 输出区域范围对应的四个顶点的坐标
    - |-I| 不加任何选项以 **-I**\ *xinc*\ [/*yinc*] 形式输出网格间隔

    |-I| 选项示例::

        $ gmt grdinfo @earth_relief_30m -I
        -I30m

        $ gmt grdinfo @earth_relief_30m -Ir
        -R-180/180/-90/90

        $ gmt grdinfo @earth_relief_30m -Ib
        -180	-90
        180	-90
        180	90
        -180	90
        -180	-90

.. _-L:

**-L**\ [**0**\|\ **1**\|\ **2**\|\ **p**\|\ **a**]
    报告Z值的其他信息。该选项可多次使用。

    - **-L0**\ : 扫描整个数据并报告Z值的范围，而不仅仅只是从网格的头段中读取Z值范围
    - **-L1**\ : 输出中位数以及L1 scale （L1 scale= 1.4826\*Median Absolute Deviation）
    - **-L2**\ : 输出均值、标准差以及均方根
    - **-Lp**\ : 输出 mode (Least Median of Squares; LMS) 和 LMS scale
    - **-La**\ : 输出以上全部信息

    注意，对于像素配准的地理网格数据而言，每个节点代表的区域面积随着纬度的增加
    而减小，此时GMT报告的是网格文件在球面平均下的统计值。

.. _-M:

**-M**
    寻找并报告Z值最小和最大值所对应的坐标，以及值为NaN的网格点的数目

.. _-R:

**-R**\ *w/e/s/n*
    从网格文件中取出一个子区域，并报告该子区域的信息。
    若指定的区域范围超过了网格边界，则只提取公共区域内的为网格信息。

.. _-T:

**-T**\ [*dz*]\ [**+a**\ [*alpha*]]\ [**+s**]
    以 **-T**\ *zmin/zmax* 或 **-T**\ *zmin/zmax/dz* 的格式输出Z值范围

    若只使用 |-T| 选项，则以 **-T**\ *zmin/zmax* 格式输出Z值范围；
    若使用 *dz* 则先提取Z的最小最大值，并做微调使得最值是 *dz* 的整数倍，并
    以 **-T**\ *zmin/zmax/dz* 格式输出。

    其它子选项：

    - **+a**\ *alpha* 对网格文件中的值进行排序，并去除极值两端的部分数据。*alpha*
      为要去除的数据的百分比，默认值为 2。即去除数据 0.5*\ *alpha* 和
      100 - 0.5*\ *alpha* 的数据，并据此修改Z值范围。
    - **+s** 根据Z值的绝对最大值，输出一个关于0对称的范围

    示例::

        $ gmt grdinfo @earth_relief_30m -T
        -T-9458/5888

        $ gmt grdinfo @earth_relief_30m -T100
        -T-9500/5900/100

        $ gmt grdinfo @earth_relief_30m -T100+s
        -T-9500/9500/100

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_help.rst_

示例
----

::

    $ gmt grdinfo @earth_relief_30m.grd
    earth_relief_30m.grd: Title: Earth Relief at 30 arc minutes
    earth_relief_30m.grd: Command: grdfilter SRTM15+V2.nc -Fg55.6 -D1 -I30m -rg -Gearth_relief_30m.grd=ns --IO_NC4_DEFLATION_LEVEL=9 --PROJ_ELLIPSOID=Sphere
    earth_relief_30m.grd: Remark: Obtained by Gaussian Cartesian filtering (55.6 km fullwidth) from SRTM15+V2.nc [Tozer et al., 2019; https://doi.org/10.1029/2019EA000658]
    earth_relief_30m.grd: Gridline node registration used [Geographic grid]
    earth_relief_30m.grd: Grid file format: ns = GMT netCDF format (16-bit integer), CF-1.7
    earth_relief_30m.grd: x_min: -180 x_max: 180 x_inc: 0.5 (30 min) name: longitude n_columns: 721
    earth_relief_30m.grd: y_min: -90 y_max: 90 y_inc: 0.5 (30 min) name: latitude n_rows: 361
    earth_relief_30m.grd: z_min: -9458 z_max: 5888 name: elevation (m)
    earth_relief_30m.grd: scale_factor: 1 add_offset: 0
    earth_relief_30m.grd: format: netCDF-4 chunk_size: 145,181 shuffle: on deflation_level: 9

从输出中可以看到很多信息：

- 网格文件中的标题信息；
- 生成该网格文件的命令；
- 网格文件的配准方式，此处为Gridline配准；
- 数据格式为 **ns** 即16位整型；
- 数据中X维度的最小值x_min、最大值x_max、网格间隔x_inc以及数据点数nx；
- 数据中Y维度的最小值y_min、最大值y_max、网格间隔y_inc以及数据点数ny；
- 数据中Z值的最小值z_min和最大值z_max以及其他信息；

相关模块
--------

:doc:`grd2cpt`,
:doc:`grd2xyz`,
:doc:`grdedit`
