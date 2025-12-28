:author: 何星辰
:date: 2025-12-22

.. index:: ! backtracker
.. program:: backtracker
.. include:: common_SYN_OPTs.rst_

backtracker
=============

:官方文档: :doc:`gmt:supplements/spotter/backtracker`  
:简介: 生成前向和后向流线和热点轨迹

**backtracker** 从 *infiles* （或标准输入）中读取 ( *longitude, latitude, age* ) 三列数据，
并使用指定的旋转参数计算旋转后的 ( *x, y, t* ) 坐标。
它可以执行两种操作：
（1）计算最终位置[默认]，
（2）或在初始位置与最终位置之间生成一个采样轨迹（流线或热点轨迹）[*Wessel*, 1999]。

在第一种模式下，输入数据前三列必须为 (longitude, latitude, age)，后续可包含其他字段。
参见 :doc:`/option/colon` 了解如何读取 (latitude, longitude, age) 格式的文件。

语法
--------

**gmt backtracker**
[ *table* ]
:option:`-E`\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]
[ :option:`-A`\ [*young*/*old*] ]
[ :option:`-D`\ **f**\|\ **b** ]
[ :option:`-F`\ *driftfile* ]
[ :option:`-L`\ **f**\|\ **b**\ **F**\|\ **B**\ [*step*] ]
[ :option:`-M`\ [*factor*] ]
[ :option:`-N`\ *upper_age* ]
[ :option:`-Q`\ *fixed_age* ]
[ :option:`-S`\ *filestem* ]
[ :option:`-T`\ *zero_age* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**a**\|\ **t**] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

|No-spaces|

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
------------------

.. include:: explain_rots.rst_

可选选项
------------------

.. option:: -A

**-A**\ [*young*/*old*]
    与 **-Lb**\|\ **f** 联用，用于限制输出轨迹的预测年龄区间，
    仅输出年龄介于 *young* 和 *old* 之间的部分。
    如果使用 **-LB**\|\ **F**，则限制条件适用于阶段编号（id 1 表示最年轻阶段）。
    若未指定区间，则期望输入文件的第 4、5 列分别提供各记录的年龄上下限。

.. option:: -D

**-Df**\|\ **b**
    设置时间方向：**-Df** 表示时间向后（从年轻到年老位置），
    **-Db** 表示时间向前（从年老到年轻位置）[默认]。
    **注意**：对于 **-Db**，输入位置的年龄即为该点的实际年龄；
    而对于 **-Df**，输入的年龄对应的是重建点的时间。

.. option:: -F

**-F**\ *driftfile*
    提供一个包含 (*lon, lat, age*) 记录的文件，描述当前热点随时间的运动历史。
    反演时程序将根据输入的第 3 列（即年龄）插值热点在该时间的位置，
    并据此调整输入点或路径的位置变化[默认无漂移]。
    **注意**：
    (1) 使用 :option:`-F` 时， :option:`-L` 的 *step* 单位为时间（百万年）；
    (2) 漂移仅在回溯点（**-Db**）或预测海山链（**-Df -Lb**）时考虑；
    (3) 不能与 :option:`-M` 同时使用。

.. option:: -L

**-Lf**\|\ **b**\|\ **F**\|\ **B**\ [*step*]
    指定在初始与最终位置之间生成采样路径：
    **-Lf** 绘制粒子流线，**-Lb** 绘制回溯（热点轨迹）。
    追加采样间隔（单位：km）。
    若 *step* < 0 或未指定，则仅返回旋转时间。
    当使用 **-LF** 或 **-LB** 时，
    输出的第 3 列为阶段编号（1 为最年轻阶段）[默认输出沿轨迹预测年龄]。
    可通过 :option:`-D` 控制路径方向。

.. option:: -M

**-M**\ [*factor*]
    将输出的张开角按 *factor* 缩放[默认 0.5]。
    通常用于获取计算流线所需的半扩张速率。

.. option:: -N

**-N**\ *upper_age*
    设置向过去扩展最老阶段旋转的最大时间上限[默认不扩展]。

.. option:: -Q

**-Q**\ *fixed_age*
    为所有位置指定固定年龄。仅需输入 (*lon, lat*) 
    两列[默认期望三列（longitude, latitude, age）]。
    适用于输入为等时线点的情况。

.. option:: -S

**-S**\ *filestem*
    当启用 :option:`-L` 时，轨迹默认以多段文件形式写入标准输出。
    通过指定 *filestem*，可令每条轨迹分别写入 *filestem.#* 文件，其中 *#* 为轨迹编号，
    该编号同时写入输出的第 4 列。

.. option:: -T

**-T**\ *zero_age*
    设置当前时间[默认 0 Ma]。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**a**\|\ **t**]
    旋转给定的输入点 (*lon, lat, time*)，并计算投影点的置信椭圆。
    输入点的时间必须与某个总重建旋转的时间完全匹配，否则该点将被跳过。
    可追加 **t** 或 **a**，分别表示在输出中追加时间或角度。
    在这 2–3 个基本输出后，
    程序将输出方位角、长轴、短轴（单位：km），表示 95% 置信椭圆。
    参见 :option:`-D` 了解旋转方向的控制。

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

示例
--------

要使用 DC85.txt 中的欧拉极点，将文件 *seamounts.txt* 中的
(*x, y, t*) 点回溯到其起源点（假定为热点），运行::

    gmt backtracker seamounts.txt -Db -EDC85.txt > newpos.txt

要从多个包含三列双精度二进制文件的 (*x, y, t*) 点向前预测流线，运行::

    gmt backtracker points.* -Df -EDC85.txt -Lf25 -bo -bi3 > lines.b

该文件可通过 :doc:`plot` 绘制。
若要根据热点运动历史文件 (HIdrift.txt) 和板块总重建旋转集 (PAC_APM.txt)，
计算 0–80 Ma 每 1 Ma 的夏威夷热点轨迹，可运行::

    echo 204 19 80 | gmt backtracker -Df -EPAC_APM.txt -Lb1 > path.txt

要使用 *Doubrovine et al.* [2012] 
的太平洋绝对板块与地幔柱运动模型预测夏威夷-皇帝海山链，运行::

    echo -155.2872 19.3972 80 | gmt backtracker -Df -Lb1 -ED2012.txt -FD2012_HI_drift.txt > traildrift.txt

若要预测在无地幔柱漂移的情况下，由太平洋绝对板块运动模型
*Doubrovine et al.* [2012] 所产生的夏威夷-皇帝海山链，运行::

    echo -155.2872 19.3972 80 | gmt backtracker -Df -Lb1 -ED2012.txt > trail.txt

备注
--------

GMT 自带 EarthByte 旋转模型文件 **Global_EarthByte_230-0Ma_GK07_AREPS.rot**。
若需使用其他旋转文件，请创建名为 **GPLATES_ROTATIONS** 的环境变量，并将其指向所需的旋转文件。

相关模块
--------

:doc:`pmodeler`,
:doc:`grdpmodeler`,
:doc:`grdrotater`,
:doc:`grdspotter`,
:doc:`hotspotter`,
:doc:`mapproject`,
:doc:`originater`,
:doc:`project`,
:doc:`plot`

参考文献
--------

Wessel, P., 1999, "Hotspotting" tools released, EOS Trans. AGU, 80 (29),
p. 319.

Doubrovine, P. V., B. Steinberger, and T. H. Torsvik, 2012, 
Absolute plate motions in a reference frame defined by moving hot spots in the Pacific, 
Atlantic, and Indian oceans, *J. Geophys. Res.*, **117**\ (B09101),
https://doi.org/10.1029/2011jb009072.
