:author: 何星辰
:date: 2025-10-18

.. index:: ! grdrotater
.. program:: grdrotater
.. include:: common_SYN_OPTs.rst_

grdrotater
=============

:官方文档: :doc:`gmt:supplements/spotter/grdrotater`  
:简介: 地理网格的有限旋转重构

**grdrotater** 读取一个地理网格，并根据给定的总重建旋转参数对其进行重建。
用户可以提供一个多段线格式的裁剪多边形文件；
此时仅使用该多边形内的网格区域来确定重建后的区域范围。
如果旋转区域不是整个地球，还会返回重建区域的轮廓线。

语法
--------

**gmt grdrotater** *ingrid*
:option:`-E`\ *rot_file*\|\ *lon*/*lat*/*angle*\ [**+i**]
:option:`-G`\ *outgrid*
[ :option:`-A`\ *region* ]
[ :option:`-D`\ *rotoutline* ]
[ :option:`-F`\ *polygonfile* ]
[ :option:`-N` ]
[ :option:`-R`\ *region* ]
[ :option:`-S` ]
[ :option:`-T`\ *ages* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-b`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-n`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_grd_in.rst_

.. include:: explain_rots.rst_

.. include:: explain_grd_out.rst_

可选选项
------------------

.. option:: -A

**-A**\ *region*
    直接指定旋转后网格的区域范围。默认情况下，输出网格的范围与旋转后的区域完全匹配；
    使用 :option:`-A` 可将输出范围裁剪或扩展为指定的 *region*。

.. option:: -D

**-D**\ *rotoutline*
    指定输出旋转后网格轮廓线的文件名。它表示网格在指定时间重建后的轮廓。
    若涉及多个重建时间，则 *rotoutline* 必须包含 C 格式化说明符来输出时间。
    若仅指定一个时间且未使用 :option:`-D`，则轮廓将输出到标准输出（除非使用 :option:`-N`）。

.. option:: -F

**-F**\ *polygonfile*
    指定一个闭合的多段线多边形文件，定义网格内需要投影的区域
    [默认投影整个网格]。
    **注意**：如果同时给出 :option:`-F` 和 :option:`-R`，则以 :option:`-R` 为准。

.. option:: -N

**-N**
    不输出旋转后的多边形轮廓线 [默认将其写入标准输出，或通过 :option:`-D` 写入文件]。

.. |Add_-Rgeo| unicode:: 0x20 .. 仅为占位符
.. include:: explain_-Rgeo.rst_

.. option:: -S

**-S**
    仅旋转多边形轮廓线，而不旋转网格（若未提供网格文件，则必须使用 :option:`-F`）。

.. option:: -T

**-T**\ *ages*
    设置所需的重建时间：
    - 对于单个时间，直接追加数值；
    - 对于等间隔的时间范围，格式为 **-T**\ *start*\ /\ *stop*\ /\ *inc*；
    若希望 *inc* 表示“点数”，请追加 **+n**。
    - 若为不等间距时间序列，请通过文件第一列提供，例如 **-T**\ *agefile*。
    若未指定 :option:`-T` 且 :option:`-E` 指定了旋转文件，则默认使用旋转文件中的时间作为重建时间。


.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_colon.rst_

.. include:: explain_-n.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_help.rst_

.. include:: explain_grdresample2.rst_

.. include:: explain_geodetic.rst_

示例
--------

要将网格 *topo.nc* 和多边形 *clip_path.txt* 的数据旋转，
使用极点 (135.5, -33.0)、旋转角度 37.3° 的总重建旋转，并采用双三次插值，运行::

    gmt grdrotater topo.nc -E135.5/-33/37.3 -V -Fclip_path.txt -Grot_topo.nc > rot_clip_path.txt

要将网格 *faa.nc* 按 *rotations.txt* 文件的旋转参数反旋转至 32 Ma，并使用双线性插值，运行::

    gmt grdrotater faa.nc -Erotations.txt -T32 -V -Grot_faa.nc -nl > rot_faa_path.txt

若仅希望查看网格 *large.nc* 在相同旋转下的轮廓线，可运行::

    gmt grdrotater large.nc -Erotations.txt -T32 -V -S | gmt plot -Rg -JH180/6i -B30 -W0.5p | gv -

要将 *topo.nc* 网格按 *rotations.txt* 旋转文件回转至 100 Ma，
并每 10 Myr 生成一次重建网格及轮廓，运行::

    gmt grdrotater topo.nc -Erotations.txt -T10/100/10 -V -Grot_topo_%g.nc -Drot_topo_path_%g.txt

假设你已将 *gridA.nc* 和 *gridB.nc* 分别使用
多边形 *polyA.txt* 与 *polyB.txt* 限定区域，
并分别应用旋转 A = (123W,22S,16.4) 与 B = (108W,16S,-14.5)，
得到旋转后的 *rot_gridA.nc* 与 *rot_gridB.nc*。
要确定两者旋转后区域的重叠范围，可使用 :doc:`grdmath`::

    gmt grdmath 1 rot_gridA.nc ISNAN SUB 1 rot_gridB.nc ISNAN SUB 2 EQ = overlap.nc

网格 *overlap.nc* 在重叠区域的值为 1，其他区域为 0。
可以将其用作掩码，或通过 :doc:`grdcontour` :option:`-D` 提取轮廓多边形。

备注
--------

GMT 附带了 EarthByte 旋转模型 `Global_EarthByte_230-0Ma_GK07_AREPS.rot`。
若需使用其他旋转文件，可创建一个环境变量 **GPLATES_ROTATIONS**，
并将其指向相应的旋转文件路径。

相关模块
--------

:doc:`backtracker`,
:doc:`grdcontour`,
:doc:`pmodeler`,
:doc:`grdmath`,
:doc:`grdpmodeler`,
:doc:`grdspotter`,
:doc:`hotspotter`,
:doc:`originater`,
:doc:`rotconverter`
