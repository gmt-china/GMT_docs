.. index:: ! earthtide
.. include:: common_SYN_OPTs.rst_

earthtide
=========

:贡献者: |周茂|
:最近更新日期: 2022-10-14

----

:官方文档: :doc:`gmt:supplements/geodesy/earthtide`
:简介: 计算固体地球潮汐网格或者时间序列

计算固体地球潮汐的三个分量，输出网格或者时间序列。同时可以输出太阳和月亮
的经纬度位置。输出可以为网格或者表文件（标准输出），表文件的格式为：
``时间 北向分量 东向分量 垂直分量`` ，分量的单位为米。

语法
----

**gmt earthtide**
|-T|\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ |-T|\ *file*\|\ *list*
|-G|\ *outgrid*
[ |-C|\ *x|e,y|n,z|v* ]
[ |SYN_OPT-I| ]
[ |-L|\ *lon/lat* ]
[ |SYN_OPT-R| ]
[ |-S| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT--| ]

必选选项
--------

以下三个选项必须至少使用其中一个。

.. include:: explain_grd_out.rst_

.. _-S:

**-S**
    输出太阳和月亮的地理坐标以及其距离，单位为米。输出为 Mx7 的矩阵，
    M 为时刻的个数（通过 |-T| 设置），7 列分别代表：时间，太阳经度，
    太阳纬度，太阳距离，月亮经度，月亮纬度，月亮距离

.. _-L:

**-L**\ *lon/lat*
    计算指定位置上的固体地球潮汐的时间序列。坐标必须为大地坐标，默认
    使用 GRS80 椭球（在亚微米的精度水平可以认为与 WGS-84 椭球等同）

可选选项
--------

.. _-C:

**-C**\ **x**\|\ **e**,\ **y**\|\ **n**,\ **z**\|\ **v**
    设置需要计算的固体地球潮汐分量及其保存的网格。该选项需要 |-G| 选项。
    不同选项之间使用逗号分隔：**x** 或 **e** 为东向分量；**y** 或 **n**
    为北向分量，**z** 或 **v** 为垂直分量。例如，**-Ce**,\ **v** 将输出
    写入两个网格，一个为东向分量网格，一个为垂直分量网格。如果设置了
    |-G| ，但不指定 |-C| ，则默认为垂直分量。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

.. _-T:

**-T**\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ |-T|\ *file*\|\ *list*
    指定计算的时间序列的起始时间 *min* ，终止时间 *max* 和步长 *inc* 。

.. include:: explain_-bo.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

.. include:: explain_array.rst_

示例
----

计算 2018 年 6 月 18 日中午，固体地球潮汐垂直分量网格，网格的分辨率为
30 m（使用默认的 |-R| 和 |-I| 选项） ::

    gmt earthtide -T2018-06-18T12:00:00 -Gsolid_tide_up.grd

计算一天的时间序列，起始时间与上例相同，计算位置位于 (-7W,37N)，时间
步长为 1 分钟 ::

    gmt earthtide -T2018-06-18T/2018-06-19T/1m -L-7/37 > solid_tide.dat

获取当前时间太阳和月亮的地理坐标 ::

    gmt earthtide -S

注意事项
--------

#. 所有的输入和输出时间都必须是 UTC 时

参考
----

http://geodesyworld.github.io/SOFTS/solid.htm
