:author: 何星辰
:date: 2025-10-19

.. index:: ! grdspotter
.. program:: grdspotter
.. include:: common_SYN_OPTs.rst_

grdspotter
=============

:官方文档: :doc:`gmt:supplements/spotter/grdspotter`  
:简介: 从重力或地形网格创建 CVA 网格

**grdspotter** 读取一个包含残余海底地形或重力数据的网格文件，
并使用指定的旋转文件从每个超过最小值的节点计算流线。然后，
这些流线与由每个网格节点表示的棱柱体积进行卷积，
并相加以生成累积火山振幅网格（CVA）[*Wessel*, 1999; 2008]。

语法
--------

**gmt grdspotter** *ingrid*
|-E|\ *rot_file*\|\ *lon*/*lat*/*angle*\ [**+i**]
|-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
[ :option:`-A`\ *agegrid* ]
[ |-D|\ **i**\|\ **p**\ *grid* ]
[ |-L|\ *IDgrid* ]
[ |-M| ]
[ |-N|\ *upper_age* ]
[ |-Q|\ *IDinfo* ]
[ |-S| ]
[ |-T|\ **t**\|\ **u**\ *fixed_val* ] [
[ |SYN_OPT-V| ]
[ |-W|\ *n\_try* ]]
[ **-Z**\ *z_min*\ [/*z_max*\ [/*z_inc*]] ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_grd_in.rst_

.. include:: explain_rots.rst_

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. |Add_-Rgeo| unicode:: 0x20 .. 仅为占位符
.. include:: explain_-Rgeo.rst_

可选选项
------------------

.. _-A:

**-A**\ *agegrid*
    提供一个与输入数据网格配准的地壳年龄网格。
    这些年龄将作为构建流线时使用的上限年龄 
    [默认将流线延伸到旋转文件中发现的最老年龄；但请参见 |-N|]。

.. _-D:

**-Di**\|\ **p**\ *grid*
    对于 **-Di**，我们使用流线来确定沿每条流线遇到的最大 CVA，
    并在起始节点处创建包含这些值的数据重要性（DI）网格。
    对于 **-Dp**，我们将使用流线来确定每个节点在 CVA 最大值处的流线年龄，
    并在起始节点处创建预测年龄（PA）网格。可重复使用。

.. _-L:

**-L**\ *IDgrid*
    提供一个与输入数据网格配准的网格，其中包含每个节点的海山链 ID。
    此选项要求同时使用 |-Q|。

.. _-M:

**-M**
    当使用 |-D| 和/或 |-P| 时，不尝试将所有流线保留在内存中。
    如果内存不足，可以使用此选项在计算时动态生成流线。
    由于我们无法重用为 CVA 步骤计算的流线，因此会变慢。
    不能与 |-W| 或 |-Z| 的多切片模式一起使用。

.. _-N:

**-N**\ *upper_age*
    为地壳年龄未知（即 NaN）的节点设置上限年龄 [无上限年龄]。另见 :option:`-A`。

.. _-Q:

**-Q**\ *IDinfo*
    可给出 (1) 单个 ID，或 (2) 包含 ID 列表的文件名 [默认使用所有 ID]。
    文件中的每一行应为 TAG ID [w e s n]。
    可选的 *w/e/s/n* 缩放框表示仅当在该区域内时才跟踪流线 [默认使用 :option:`-R` 设置的区域]。
    需要 |-L|。

.. _-S:

**-S**
    将生成的 CVA 网格归一化为 CVA 最大值的百分比。这也会归一化 DI 网格（如果请求）。

.. _-T:

**-T**\ **t**\|\ **u**\ *fixed_val*
    选择调整年龄的方法；可重复。选择 **-Tt** 截断通过 :option:`-A` 
    选项提供的超过 |-N| 设置上限的地壳年龄 [不截断]，
    或选择 |-T|\ **u**\ *fixed_val* 表示在节点通过 |-Z| 所隐含的测试后，
    在计算中使用此 *fixed_val* 替代 [默认使用各个节点值]。

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *n\_try*
    获取 *n_try* 次最大 CVA 位置的自助法估计；
    经度和纬度结果写入标准输出 [默认无自助法]。不能与 |-M| 一起使用。

.. _-Z:

**-Z**\ *z_min*\ [/*z_max*\ [/*z_inc*]]
    忽略 z 值低于 *z_min* [0] 且可选高于 *z_max* [无穷大] 的节点。
    给出 *z_min/z_max/z_inc* 可为每个 *z* 切片生成单独的
    CVA 网格 [默认生成一个 CVA 网格]。多切片模式不能与 |-M| 一起使用。

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

示例
--------

要从太平洋地形网格 Pac_res_topo.nc 创建一个 CVA 图像，
使用 DC85.txt 欧拉极点文件，并仅输出指定区域的网格，运行::

    gmt grdspotter Pac_res_topo.nc -EDC85.txt -GCVA.nc -R190/220/15/25 -I2m -N145 -Tt -V

然后可使用 :doc:`grdimage` 进行绘图。

备注
--------

GMT 提供了 EarthByte 旋转模型 Global_EarthByte_230-0Ma_GK07_AREPS.rot。
若要使用其他旋转文件，请创建一个名为 **GPLATES_ROTATIONS** 的环境变量，指向替代的旋转文件。

相关模块
--------

:doc:`gmt`,
:doc:`grdimage`,
:doc:`project`,
:doc:`mapproject`,
:doc:`backtracker`,
:doc:`pmodeler`,
:doc:`grdpmodeler`,
:doc:`grdrotater`,
:doc:`hotspotter`,
:doc:`originater`

参考文献
--------

Wessel, P., 1999, "Hotspotting" tools released, EOS Trans. AGU, 80 (29), p. 319.

Wessel, P., 2008, Hotspotting: Principles and properties of a plate
tectonic Hough transform, Geochem. Geophys. Geosyst. 9(Q08004):
https://doi.org/10.1029/2008GC002058.
