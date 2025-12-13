:author: 何星辰
:date: 2025-10-20

.. index:: ! hotspotter
.. include:: common_SYN_OPTs.rst_

.. program:: hotspotter

hotspotter
=============

:官方文档: :doc:`gmt:supplements/spotter/hotspotter`  
:简介: 从海山位置创建 CVA 网格


**hotspotter** 从 *table* [或标准输入] 读取 
(longitude, latitude, amplitude, radius, age) 记录，
并使用指定的阶段旋转或总重建旋转计算流线。这些流线与海山的形状进行卷积
（使用振幅和半径 = 6σ 的高斯形状），并叠加以生成累积火山振幅网格（CVA）。
关于如何读取 (latitude, longitude, ...) 文件，请参见选项 **-:** [*Wessel*, 1999; 2008]。

语法
--------

**gmt hotspotter** [*table*]
|-E|\ *rot_file*\|\ *ID1-ID2*\|\ *lon*/*lat*/*angle*\ [**+i**]
|-G|\ *outgrid*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-N|\ *upper_age* ]
[ |-S| ] [ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

.. include:: explain_intables.rst_

.. include:: explain_rots.rst_

.. include:: explain_grd_out.rst_

.. include:: explain_-I.rst_

.. |Add_-Rgeo| unicode:: 0x20 .. 仅为占位符
.. include:: explain_-Rgeo.rst_

可选选项
------------------

.. option:: -D

**-D**\ *factor*
    修改沿流线的采样间隔。默认值 [0.5] 使每个网格单元内大约有 2 个点。
    较小的因子将提高分辨率，但会增加处理时间。

.. option:: -N

**-N**\ *upper_age*
    设置地壳年龄未知（即 NaN）的海山的上限年龄 [默认无上限年龄]。

.. option:: -S

**-S**
    将结果 CVA 网格归一化为 CVA 最大值的百分比。

.. option:: -T

**-T**
    截断超过通过 |-N| 设置的上限年龄的海山年龄 [默认不截断]。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_geodetic.rst_

示例
--------

要从文件 *seamounts.txt* 中的太平洋 (*x, y, z, r, t*) 数据创建一个 CVA 图像，
使用 DC85.txt 欧拉极点，运行::

    gmt hotspotter seamounts.txt -EDC85.txt -GCVA.nc -R130/260/-66/60 -I10m -N145 -T -V

然后可以使用 :doc:`grdimage` 绘制该文件。

备注
--------

GMT 随附地球字节旋转模型 **Global_EarthByte_230-0Ma_GK07_AREPS.rot**。
要使用其他旋转文件，请创建名为 **GPLATES_ROTATIONS** 的环境变量，并将其指向备用的旋转文件。

相关模块
--------

:doc:`gmt`,
:doc:`grdimage`,
:doc:`grdrotater`,
:doc:`grdspotter`,
:doc:`project`,
:doc:`mapproject`,
:doc:`backtracker`,
:doc:`pmodeler`,
:doc:`grdpmodeler`,
:doc:`grdrotater`,
:doc:`originater`

参考文献
--------

Wessel, P., 1999, "Hotspotting" tools released, EOS Trans. AGU, 80 (29), p. 319.

Wessel, P., 2008, Hotspotting: Principles and properties of a plate
tectonic Hough transform, Geochem. Geophys. Geosyst. 9(Q08004):
https://doi.org/10.1029/2008GC002058.
