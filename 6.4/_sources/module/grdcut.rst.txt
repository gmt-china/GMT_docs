.. index:: ! grdcut
.. include:: common_SYN_OPTs.rst_

grdcut
======

:官方文档: :doc:`gmt:grdcut`
:简介: 从一个网格文件中裁剪出一个子区域的网格文件

**grdcut** 模块可以从一个网格文件中根据条件裁剪出一个新的网格文件。
子区域的选择有如下几种方式：

- |-R| 选项：直接指定子区域的范围
- |-Z| 选项：通过检查网格点的值间接限定子区域的范围
- |-S| 选项：通过指定与特定点的距离间接限定子区域的范围
- |-J| 和 |-R| 选项：对于倾斜投影，可以使用这两个选项获得覆盖整个倾斜区域的子区域

语法
----

**gmt grdcut** *ingrid* |-G|\ *outgrid*
|SYN_OPT-R|
[ |-J|\ *parameters* ]
[ |-N|\ [*nodata*] ]
[ |-S|\ *lon/lat/radius*\ [**+n**] ]
[ |SYN_OPT-V| ]
[ |-Z|\ [*min/max*]\ [**+n**\|\ **N**\|\ **r**] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*ingrid*
    输入网格文件名

.. _-G:

**-G**\ *outgrid*
    输出网格文件名

可选选项
--------

.. include:: explain_-J.rst_

.. _-N:

**-N**\ [*nodata*]
    允许新网格的区域范围超过原网格的区域范围。

    一般情况下，若指定的区域范围大于输入网格的区域范围，超出的部分会被自动忽略，
    实际的输出网格的区域范围会自动适应输入网格的区域范围。使用 |-N| 选项，
    则超出的区域范围内，网格节点会被赋以指定的值，默认赋值为NaN，也可以自己
    指定其值为 *nodata*。

.. include:: explain_-R.rst_

..

   指定要截取的网格子区域的范围。

.. _-S:

**-S**\ *lon/lat/radius*\ [**+n**]
    指定圆心位置（*lon/lat*）及其半径（*radius*，可指定 `距离单位`_\ ），
    程序会自动计算出一个包含了圆上及圆内所有网格点的矩形区域。
    **+n** 表示将所有矩形区域内但不在圆内的节点的值设为NaN。

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ [*min/max*]\ [**+n**\|\ **N**\|\ **r**]
    确定一个新的矩形区域，使得所有该区域外的节点值都在指定的Z值范围 *min/max* 外。
    *min* 和 *max* 默认值为正负无穷，可以用 **-** 表示无穷。

    默认情况下，值为NaN的节点会被自动忽略。

    - **+n** 表示将 NaN 节点视作在给定的Z值范围之外，则保证了新生成的子区域内是无NaN的
    - **+r** 表示将 NaN 节点视作在给定的Z值范围之内，因而子区域的外部是无NaN的
    - **+N** 若新生成的子区域的某条边界上的所有节点都是NaN，则去除该条边界上的这一行或列

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

使用 |-R| 选项直接指定子区域的范围::

    gmt grdcut @earth_relief_02m -Gregion_0_30_-30_30.nc -R0/30/-30/30

使用 |-S| 选项生成一个包含了原点(45,30)周围 500 km 以内的所有点的矩形区域，
并设置矩形区域内圆外的节点值为NaN::

    gmt grdcut @earth_relief_06m -Goutput.nc -S45/30/500k+n

对于一个倾斜投影的地图，由于 **grdcut** 获得的区域是由经线、纬度划分出来的
矩形区域，而倾斜投影地图的边界不是由经纬线构成的，所以需要使用 |-J| 和 **-R**
选项指定一个更大的矩形区域以包含倾斜投影地图的研究区域::

    gmt grdcut @earth_relief_02m -R160/20/220/30+r -Joc190/25.5/292/69/1 -Gdata.nc

相关
----

- :doc:`grdclip`
- :doc:`grdfill`
- :doc:`grdinfo`
- :doc:`grdpaste`
- :doc:`gmt:surface`
