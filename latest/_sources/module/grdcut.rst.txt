:author: 田冬冬, 陈箫翰
:date: 2026-01-01

.. index:: ! grdcut
.. program:: grdcut

grdcut
======

:官方文档: :doc:`gmt:grdcut`
:简介: 从一个网格文件中裁剪出一个子区域的网格文件

**grdcut** 模块可以从一个网格文件中根据条件裁剪出一个新的网格文件。
子区域的选择有如下几种方式：

- :option:`-R` 选项：直接指定子区域的范围
- :option:`-Z` 选项：通过检查网格点的值间接限定子区域的范围
- :option:`-S` 选项：通过指定与特定点的距离间接限定子区域的范围
- :option:`-J` 和 :option:`-R` 选项：对于倾斜投影，可以使用这两个选项获得覆盖整个倾斜区域的子区域
- :option:`-F` 选项：指定一个多边形。可将其边界框用作子区域，也可将多边形内部或外部的网格节点设置为 NaN。

如果输入是 3D netCDF 立方体数据，可以穿过现有节点进行垂直切片。

**注意**：如果输入网格实际上是图像（灰度、RGB 或 RGBA），则选项 :option:`-N` 和 :option:`-Z` 不可用。
而对于多层 GeoTIFF 文件，仅支持 :option:`-R` 、 :option:`-S` 和 :option:`-G` 选项，
即只能裁剪出一个子区域（如果有多个波段，将通过 *gdal_translate* 来实现）。

与 **grdcut** 互补的是 :doc:`grdpaste`，它将沿着共同的边界将两个网格文件（非图像）拼接在一起。

语法
----

**gmt grdcut**
*ingrid*
:option:`-G`\ *outgrid*
:option:`-R`\ *region*
[ :option:`-D`\ [**+t**] ]
[ :option:`-E`\ **x**\|\ **y**\ *coord* ]
[ :option:`-F`\ *polygonfile*\ [**+c**][**+i**] ]
[ :option:`-J`\ *parameters* ]
[ :option:`-N`\ [*nodata*] ]
[ :option:`-S`\ *lon/lat/radius*\ [**+n**] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ [*min/max*]\ [**+n**\|\ **N**\|\ **r**] ]
[ :option:`-f`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_grd_in.rst_

必须选项
------------------

.. include:: explain_grd_out.rst_

.. include:: explain_-R.rst_
..

   指定要截取的网格子区域的范围。

可选选项
--------

.. option:: -D

**-D**\ [**+t**]
    “空运行”：仅报告在给定所选选项的情况下，提取后的网格所具有的区域和增量。
    不创建网格（不允许使用 :option:`-G` ），而是将包含 *west east south north xinc yinc* 的单条数据记录写入标准输出。
    增量将反映输入网格的增量，除非它是没有隐含分辨率的远程网格数据集。
    附加 **+t** 则改为以尾随字符串 "-Rwest/east/south/north -Ixinc/yinc" 的形式接收该信息。

.. option:: -E

**-E**\ **x**\|\ **y**\ *coord*
    沿着 **x** 列坐标 *coord* 或 **y** 行坐标 *coord* 提取一个垂直切片。
    不对节点进行插值，仅穿过现有的立方体节点进行直接切片。

    **注意**：(1) 输入文件必须是 3D netCDF 立方体数据，且 :option:`-E` 仅能与 :option:`-G` 选项配合使用。
    (2) *coord* 必须与立方体中给出的坐标完全匹配。

.. option:: -F

**-F**\ *polygonfile*\ [**+c**][**+i**]
    指定一个多段闭合多边形文件，多边形外部的所有网格节点都将被设置为 NaN。
    附加 **+i** 可反转该操作，即将多边形内部的所有节点设置为 NaN。
    附加 **+c** 以根据多边形的边界框裁剪网格区域。

.. include:: explain_-J.rst_

.. option:: -N

**-N**\ [*nodata*]
    允许新网格的区域范围超过原网格的区域范围。

    一般情况下，若指定的区域范围大于输入网格的区域范围，超出的部分会被自动忽略，
    实际的输出网格的区域范围会自动适应输入网格的区域范围。使用 :option:`-N` 选项，
    则超出的区域范围内，网格节点会被赋以指定的值，默认赋值为NaN，也可以自己
    指定其值为 *nodata*。

.. option:: -S

**-S**\ *lon/lat/radius*\ [**+n**]
    指定圆心位置（*lon/lat*）及其半径（*radius*，可指定 `距离单位`_\ ），
    程序会自动计算出一个包含了圆上及圆内所有网格点的矩形区域。
    **+n** 表示将所有矩形区域内但不在圆内的节点的值设为NaN。

.. include:: explain_-V.rst_

.. option:: -Z

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

.. include:: explain_grd_coord.rst_

注意事项
------------

如果输入文件是具有多个数据波段的 GeoTIFF 文件，则输出格式将取决于对保留波段的选择：
如果未指定任何波段（默认考虑所有可用波段）或者选择了多个波段，则输出文件可以是一个新的 GeoTIFF 文件（如果提供了 .tif[f] 扩展名），
也可以是一个多波段 netCDF 文件（如果提供了 .nc 或 .grd 扩展名）。
如果从输入 GeoTIFF 中选择了单个波段，GMT 通常会将其作为单个网格层读取，并据此写入 netCDF 网格（除非附加了其他网格格式说明符）。
但是，如果输出文件名具有 .tif[f] 扩展名，则会将其写入为单波段 GeoTIFF。所有 GeoTIFF 输出操作均通过 GDAL 的 *gdal_translate* 完成。

示例
------------

使用 :option:`-R` 选项直接指定子区域的范围::

    gmt grdcut @earth_relief_02m -Gregion_0_30_-30_30.nc -R0/30/-30/30

使用 :option:`-S` 选项生成一个包含了原点(45,30)周围 500 km 以内的所有点的矩形区域，
并设置矩形区域内圆外的节点值为NaN::

    gmt grdcut @earth_relief_06m -Goutput.nc -S45/30/500k+n

对于一个倾斜投影的地图，由于 **grdcut** 获得的区域是由经线、纬度划分出来的
矩形区域，而倾斜投影地图的边界不是由经纬线构成的，所以需要使用 :option:`-J` 和 :option:`-R`
选项指定一个更大的矩形区域以包含倾斜投影地图的研究区域::

    gmt grdcut @earth_relief_02m -R160/20/220/30+r -Joc190/25.5/292/69/1 -Gdata.nc

相关模块
------------

:doc:`grdclip`,
:doc:`grdfill`,
:doc:`grdinfo`,
:doc:`grdpaste`,
:doc:`surface`
