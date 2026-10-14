.. index:: ! grdredpol
.. include:: common_SYN_OPTs.rst_

grdredpol
=========

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/grdredpol`
:简介: 计算连续化极（Continuous Reduction To the Pole，RTP）

**grdredpol** 读取一个磁异常文件并计算化极后的异常。
This anomaly is the one that would have been produce if the bodies were 
magnetized vertically and the anomalies were observed at the geomagnetic pole.
标准的 RTP 程序假定磁化方向和地磁场在整个区域是一致的。这些假设对于小区域
来说是合理的，但是大区域不成立。

本模块中的方法是同时在频域和空间域中计算的。这里，将一个大区域分成多个小
区域，在小区域中，磁化和地磁场的变化非常小，可以认为是恒定的。对于每个小
区域，计算其滤波参数并对单独的点使用一阶泰勒级数来重构。


语法
----

**gmt grdredpol** *ingrid*
|-G|\ *rtp_grd*
[ |-C|\ *dec/dip* ]
[ |-E|\ **i**\ *inc_grd* ]
[ |-E|\ **d**\ *dec_grd* ]
[ |-F|\ *m/n* ]
[ |-M|\ **m**\|\ **r** ]
[ |-N| ]
[ |-W|\ *win_width* ]
[ |SYN_OPT-V| ]
[ |-T|\ *year* ]
[ |-Z|\ *filtergrd* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT--| ]

必选选项
--------

*ingrid*\ [=\ *ID*\|\ ?\ *varname*][**+b**\ *band*][**+d**\ *divisor*][**+n**\ *invalid*][**+o**\ *offset*][**+s**\ *scale*]
    输入磁异常网格名。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__

.. _-G:

**-G**\ *rtp_grd*
    RTP 结果网格文件名

可选选项
--------

.. _-C:

**-C**\ *dec/dip*
    使用恒定的偏角和倾角

.. _-E:

**-Ei**\ *inc_grd* **-Ed**\ *dec_grd*
    从 *inc_grd* 和 *dec_grd* 中获取磁化倾角和偏角，默认使用 IGRF 计算。
    **注** ：这两个网格不需要与输入的磁异常一致，范围和分辨率都可以不同。

.. _-F:

**-F**\ *m/n*
    滤波窗口大小，*m* 和 *n* 分别为行和列，默认为 25/25

.. _-M:

**-M**\ **m**\|\ **r**
    设置边界条件，**m**\|\ **r** 分别表示镜像对称或者以边缘对称

.. _-N:

**-N**
    不使用泰勒展开

.. _-R:

**-R**\ *west*/*east*/*south*/*north*
    设置输入点的区域，默认与输入相同

.. _-T:

**-T**\ *year*
    IGRF 程序用于计算每个点的偏角和请教的年份，默认为 2000 年 

.. _-W:

**-W**\ *width*
    滑动窗口的大小，单位为度，默认为 5 度

.. _-Z:

**-Z**\ *filter_grd*
    输出滤波文件

.. include:: explain_-V.rst_

.. include:: explain_-n.rst_

示例
----

假定磁异常文件 :file:`anom.grd` 化极到 2010 历元，:file:`dec.grd` 和 :file:`dip.grd`
分别为磁偏角和磁倾角文件，使用 2 度划分整个区域，并用 45 个系数的滤波器计算 RTP ::

    gmt grdredpol anom.grd -Grtp.grd -W2 -F45/45 -T2010 -Edec.grd/dip.grd -V

计算相同的 RTP，但磁场和磁化向量是平行的，并使用 IGRF 计算 ::

    gmt grdredpol anom.grd -Grtp.grd -W2 -F45/45 -T2010 -V

参考文献
--------

Luis, J.L. and Miranda, J.M., 2008, Reevaluation of magnetic chrons in
the North Atlantic between 35N and 47N: Implications for the formation
of the Azores Triple Junction and associated plateau. *JGR*, VOL.
**113**, B10105, doi:10.1029/2007JB005573
