.. index:: ! xyz2grd
.. include:: common_SYN_OPTs.rst_

xyz2grd
=======

:官方文档: :doc:`gmt:xyz2grd`
:简介: 将XYZ数据或Z数据转换成网格文件

**xyz2grd** 读取一个或多个Z数据或XYZ数据，并将其转换成二进制网格文件。
若某些节点没有数据值，则这些节点会被赋值为NaN；
若某个节点由多个数据值，则该节点的值为所有数据点的平均值。

注意，该模块只是将已存在的数据转换为网格数据，并不具备网格化/插值功能。
若需要网格化功能，可以使用模块
:doc:`gmt:surface`、
:doc:`gmt:greenspline`、
:doc:`gmt:nearneighbor`
或 :doc:`gmt:triangulate`。

语法
----

**gmt xyz2grd** [ *table* ]
|-G|\ *grdfile*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ [**d**\|\ **f**\|\ **l**\|\ **m**\|\ **n**\|\ **r**\|\ **S**\|\ **s**\|\ **u**\|\ **z**] ]
[ |-D|\ [**+x**\ *xname*][**+y**\ *yname*][**+z**\ *zname*][**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*][**+t**\ *title*][**+r**\ *remark*] ]
[ |-J|\ *parameters* ]
[ |-S|\ [*zfile*] ]
[ |SYN_OPT-V| ]
[ |-Z|\ [*flags*] ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

`table`
    输入表数据。可以只包含Z值，也可以包含 (x,y,z) 值。可以是ASCII格式，也可以是二进制格式。
    XYZ数据不要求排序。如果只包含Z值，则必须使用 |-Z| 选项。

.. _-G:

**-G**\ *grdfile*
    生成的网格文件名

.. _-I:

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ [**d**\|\ **f**\|\ **l**\|\ **m**\|\ **n**\|\ **r**\|\ **S**\|\ **s**\|\ **u**\|\ **z**]
    多个数据落在同一个网格节点内时的处理方式。

    默认情况下，若有多个数据落在同一个网格节点内，会将这些数据的均值作为该
    节点的值。使用该选项可以修改这一行为（当使用 |-Z| 选项时，该选项会被忽略）：

    - **-Af** 将第一个落在该节点内的数据值作为节点值
    - **-As** 将最后一个落在该节点内的数据值作为节点值
    - **-Al** 将落在该节点内的所有值的最小值作为节点值
    - **-Au** 将落在该节点内的所有值的最大值作为节点值
    - **-Ad** 将落在该节点内的所有值的最大值和最小值的差作为节点值
    - **-Am** 将落在该节点内的所有值的均值作为节点值
    - **-Ar** 将落在该节点内的所有值的RMS值作为节点值
    - **-AS** 将落在该节点内的所有值的标准差作为节点值
    - **-An** 将落在该节点内的数据数目作为该节点值，该选项仅要求输入数据中有XY值
    - **-Az** 将落在该节点内的所有值的和作为节点值

.. include:: explain_-D_cap.rst_

.. _-J:

**-J**\ *parameters*
    指定投影方式。将投影方式信息保存到netCDF网格文件中。

.. _-S:

**-S**\ [*zfile*]
    对输入的Z文件做字节序转换并输出到标准输出或保存到文件 *zfile* 中。
    该选项只做字节序转换，不生成网格文件。该选项必须与 |-Z| 选项一起使用。

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ [*flags*]
    指定Z数据的格式。

    对于Z数据而言，由于没有XY坐标信息，因而Z数据中必须提供所有节点处的值且按照
    一定的顺序排列。输入Z值的顺序由 *flags* 决定。
    在确定数据的排列顺序时，需要指定数据的起点以及数据排序的方向。

    -  **数据起点**：可以取网格的四个顶点中的任意一个作为起点，四个顶点分别用
       **TL**、**TR**、**BL**\ 和 **BR** 表示，
       其中 **T** 代表 Top，**B** 代表Bottom，**L** 代表Left，**R** 代表Right。
    -  **排序方式**\：选取数据顶点之后，数据可以是行优先也可以是列优先，所以有两种
       排序方式。若是行优先，则 T|B 位于 L|R 的前面；若列优先，则 L|R 位于 T|B 的前面。

    对于网格线配准的数据，若数据在X方向是周期性的但输入数据中并不包含x=xmax处的
    冗余列，则加上 **x**；若数据在Y方向是周期性的但输入数据中并不包含y=ymax处的
    冗余行，则加上 **y**；加上 **s**\ *n* 用于跳过数据中最前面的 *n* 个字节；
    若需要转换数据的字节序，则加上 **w**。

    除此之外，还需要再加上一个字符表征数据类型：

    - ``A``: ASCII表示，每行一个或多个浮点数
    - ``a``: ASCII表示，每行一项，不仅可以处理浮点数还可以处理日期时间数据和经纬度数据
    - ``c``: int8_t，有符号单字节字符
    - ``u``: uint8_t，无符号单字节字符
    - ``h``: int16_t，有符号双字节整型
    - ``H``: uint16_t，无符号双字节整型
    - ``i``: int32_t，有符号四字节整型
    - ``I``: uint32_t，无符号四字节整型
    - ``l``: int64_t，长整型（8字节）
    - ``L``: uint64_t，无符号长整型（8字节）
    - ``f``: 4字节单精度浮点型
    - ``d``: 8字节双精度浮点型

    默认的输入数据格式为 **-ZTLa**。需要注意，**-Z** 选项仅对Z数据有效。

.. include:: explain_-bi.rst_
..

   该选项仅适用于XYZ数据。对于Z数据，应使用 |-Z| 选项。

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_
..

   该选项不适用于二进制数据。

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_


示例
----

将ASCII文件转换为网格数据::

    gmt xyz2grd hawaii_grv.xyz -D+xdegree+ydegree+zGal+t"Hawaiian Gravity"+r"GRS-80 Ellipsoid used" \
        -Ghawaii_grv_new.nc -R198/208/18/25 -I5m -V

将二进制格式的XYZ文件（单精度）转换为网格文件::

    gmt xyz2grd raw.b -D+xm+ym+zm -Graw.nc -R0/100/0/100 -I1 -V -Z -bi3f

将USGS DEM数据转换为网格数据::

    gmt xyz2grd topo30.b -D+xm+ym+zm -Gustopo.nc -R234/294/24/50 -I30s -di-9999 -ZTLhw

相关模块
--------

:doc:`grd2xyz`,
:doc:`grdedit`,
:doc:`grdconvert`,
:doc:`gmt:greenspline`,
:doc:`gmt:nearneighbor`,
:doc:`gmt:surface`,
:doc:`gmt:triangulate`
