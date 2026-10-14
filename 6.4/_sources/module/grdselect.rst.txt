.. index:: !grdselect
.. include:: common_SYN_OPTs.rst_

grdselect
=========

:贡献者: |周茂|
:最近更新时间: 2022-12-11

----

:官方文档: :doc:`gmt:grdselect`
:简介: 使用一定的空间标准对 2—D 网格、图像或 3-D 网格进行范围筛选或者确定并集

**grdselect** 读取一个或者多个图像或者网格，可对数据数据xxx


语法
----

**gmt grdselect** *source1 source2 ...*
[ |-A|\ **i**\|\ **u**\ [**+il**\|\ **h**\|\ *inc*] ]
[ |-C|\ *pointfile* ]
[ |-D|\ *inc* ]
[ |-E|\ [**b**] ]
[ |-F|\ *polygonfile*\ [**+i**\|\ **o**] ]
[ |-G| ]
[ |-I|\ [**C**][**D**][**F**][**L**][**N**][**R**][**W**][**Z**][**r**] ]
[ |-L|\ *linefile* ]
[ |-M|\ *margins* ]
[ |-N|\ **l**\|\ **h**\ [*n*] ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*wmin*\ /*wmax*] ]
[ |-Z|\ [*zmin*\ /*zmax*]] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必须选项
--------

.. include:: explain_grd_in.rst_

.. note::
    
    不可将 2—D 和 3—D 文件融合

可选选项
--------

.. _-A:

**-A**\ **i**\|\ **u**\ [**+il**\|\ **h**\|\ *inc*]
    - **i** 求交集
    - **u** 求并集

    可追加 **+i** 子选项，将经纬度方向的间隔进行一定程度的舍入以应用到最终的区域。
    **l** 和 **h** 分别采用最小的网格间隔或者最大的网格间隔，或者可以指定间隔 *inc* 。
    如果不使用 |-A| ，则只列出所有通过以下选项 |-C| |-D| |-F| |-L| |-N| |-R| |-W|
    |-Z| 设置的测试的文件名，与 |-I| 同时使用，则列出未通过测试的文件名

.. _-C:

**-C**\ *pointfile*
    指定一个多段点文件 *pointfile* ，列出至少包含文件中一个点的网格。如果
    输入网格为 3-D，则会检查 *pointfile* 中的点是否包含 z 坐标，然后检查
    其是否位于网格中

.. _-D:

**-D**\ *inc*
    只列出网格间隔为 *inc* 的网格

.. _-E:

**-E**\ [**b**]
    格式化输出数据，所有字段以制表符分隔置于同一行。其格式为：
    *w e s n {b t} v0 v1* 。只有输入数据为 3-D 网格时，才输出括号中的字段。
    默认输出 -Rw/e/s/n{/b/t} 字符串。追加 **b** 选项可输出区域范围的闭合
    多边形。*v0 v1* 为区域内所有数据的数值范围。如果输入网格的分辨率不同，
    则需要使用 **-A+i** 指定输出分辨率，若使用 **Eb** ，则无需 **-A+i**
    选项

.. _-F:

**-F**\ *polygonfile*\ [**+i**\|\ **o**]
    指定一个多段闭合多边形文件。列出所有至少与其中一个多边形有交集的网格。
    使用 **+i** 和 **+o** 分别列出完全位于多边形内和外的网格。如果输入数据
    为 3-D，则忽略 z 方向。

.. _-G:

**-G**
    为了列出所有信息，强制下载所有可能的的远程文件的区块

.. _-I:

**-I**\ [**C**][**D**][**F**][**L**][**N**][**R**][**W**][**Z**][**r**]
    反转选择结果：

    - **C** 列出不包含 |-C| 设置的任何点的网格
    - **D** 列出和 |-D| 指定的分辨率不匹配的网格
    - **F** 列出不与 |-F| 指定多边形存在交集的网格
    - **N** 列出不满足 |-N| 选项的网格
    - **R** 列出不与 |-R| 相交的网格
    - **W** 列出不在 |-W| 范围内的网格
    - **Z** 列出不在 |-Z| 范围内的网格
    - **r** 列出不与 |SYN_OPT-r| 指定的配准方式相同的网格

.. _-L:

**-L**\ *linefile*
    指定一个多段线文件，列出至少被其中的一条线穿过的网格。如果输入网格为 3-D，
    则忽略 z 方向

.. _-M:

**-M**\ *margins*
    扩展通过 |-A| 输出的网格范围，扩展大小为 *margins* ，其可以设置为单个值，
    即在所有方向均使用相同大小的扩展；也可设置为斜杠分隔的两个值，即分别设置
    x 和 y 方向的扩展；也可设置为斜杠分隔的 4 个值，分别设置西东南北四个方向
    的扩展。默认不使用扩展。对于地理坐标网格，可使用 **d** , **m** 或 **s**
    分别表示度分秒。

.. _-N:

**-N**\ **l**\|\ **h**\ [*n*]
    - **h** 只列出至少含有 *n* 个 NaN 值的网格
    - **l** 只列出最多含有 *n* 个 NaN 值的网格

    *n* 默认为 0。该选项不能用于图片

.. include:: explain_-R.rst_
    
    列出与 |-R| 选项设置的范围重合的网格

.. _-W:

**-W**\ [*wmin*]\ /[*wmax*]
    只列出数据范围在 *wmin* 到 *wmax* 的网格，如果没给出 *wmin*, 则默认为
    -infinity，没给出 *wmax* ，则默认为 +infinity

.. _-Z:

**-Z**\ [*zmin*]\ /[*zmax*]
    与 |-W| 相同，但用于 z 值

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

示例
----

寻找所有网格的并集，并在最终结果中扩展 2 度::

    gmt grdcut @earth_relief_01d -R1/3/1/3 -Gsubset1.nc
    gmt grdcut @earth_relief_01d -R2/5/2/5 -Gsubset2.nc
    gmt grdselect *.nc -Au -M2

寻找所有网格的交集::

    gmt grdselect *.nc -Ai

寻找所有网格的交集，并将结果扩展 2 度，然后输出边界多边形::

    gmt grdselect *.nc -Ai -M2 -Eb > wesn_polygon.txt

列出所有至少包含 10 个 NaN 值的像素配准方式的网格::

    gmt grdselect *.nc -Nh10 -rp

列出完全位于 wesn_polygon.txt 中包含的多边形内的网格::

    gmt grdselect *.nc -Fwesn_polygon.txt+i

相关模块
--------

:doc:`gmtselect`,
:doc:`grd2xyz`,
:doc:`grdedit`,
:doc:`grdinfo`
