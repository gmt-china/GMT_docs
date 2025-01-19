.. index:: ! segy2grd
.. include:: common_SYN_OPTs.rst_

segy2grd
=============

:官方文档: :doc:`gmt:supplements/segy/segy2grd`
:简介: 

**segy2grd** 用于读取 IEEE SEGY 文件并创建二进制网格文件。它可以执行简单的映射(相当于 xyz2grd -Z)，或者在单个网格单元包含 SEGY 文件中多个样本值的情况下进行更复杂的平均值计算。

如果某些节点没有填充数据，**segy2grd** 会进行报告。这些未被约束的节点会被设置为用户指定的值[默认值为 NaN]。对于包含多个值的节点，将被设为这些值的平均值。

语法
--------

**gmt segy2grd**
*segyfile*
|-G|\ *grdfile*
|SYN_OPT-I|
|SYN_OPT-R|
[ |-A|\ [**n**\|\ **z**] ]
[ |-D|\ |SYN_OPT-D2| ]
[ |-L|\ [*nsamp*] ]
[ |-M|\ [*ntraces*] ]
[ |-Q|\ **x**\|\ **y**\ *value* ]
[ |-S|\ [*header*] ]

必须选项
------------------

*segyfile* 
    *segyfile* 是一个 IEEE 浮点数格式的 SEGY 文件。所有的道集都假定从 0 时间/深度域开始。

.. _-G:

**-G**outgrid
    输出的网格文件名

.. _-I:

**-I**\ *x_inc*\ [*y_inc*]
    *x_inc* [以及可选的 *y_inc*] 是网格间距。可以在数值后添加 **m** 表示分钟，或添加 **s** 表示秒。

可选选项
------------------

.. _-A:

**-A**\ [**n**\|\ **z**]
    将属于同一节点(相同坐标)的多个值相加(等同于 **-Az**)。
    添加 **n** 则仅统计分配到每个节点的数据点数量。
    [默认情况下(不使用 **-A** 选项)会计算平均值]。该选项不用于简单映射。

.. _-D:

.. include:: ../../explain_-D_cap.rst_

.. _-L:

**-L**
    Let *nsamp* override number of samples in each trace.

.. _-M:

**-M**\ [*ntraces*]
    Fix number of traces to read in. Default tries to read 10000 traces.
    **-M**\ 0 will read number in binary header, **-M**\ *ntraces* will
    attempt to read only *n* traces.

.. _-Q:

**-Q**\ **x**\|\ **y**\ *value*
    Can be used to change two different settings depending on the directive:
       **-Qx**\ *x-scale* applies scalar *x-scale* to coordinates in trace
       header to match the coordinates specified in |-R|.

       **-Qy**\ *s_int* specifies sample interval as *s_int* if incorrect in the SEGY file.
       Repeatable.

.. _-S:

**-S**\ [*header*]
    Set variable spacing; *header* is **c** for cdp, **o** for offset, or **b**\ *number*
    for 4-byte float starting at byte *number*. If |-S| not set, assumes even
    spacing of samples at the *x_inc, y_inc* supplied with |-I|.

.. |Add_-V| replace:: |Add_-V_links|
.. include:: /explain_-V.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. |Add_-di| replace:: Also sets nodes with no input SEGY coverage to this value
    [Default is NaN].
.. include:: ../../explain_-di.rst_

.. |Add_nodereg| unicode:: 0x20 .. just an invisible code
.. include:: ../../explain_nodereg.rst_

.. include:: ../../explain_help.rst_

Examples
--------

To create a grid file from an even spaced SEGY file test.segy, try::

    gmt segy2grd test.segy -I0.1/0.1 -Gtest.nc -R198/208/18/25 -V

Note that this will read in 18-25s (or km) on each trace, but the
first trace will be assumed to be at X=198

To create a grid file from the SEGY file test.segy, locating traces
according to the CDP number, where there are 10 CDPs per km and the
sample interval is 0.1, try::

    gmt segy2grd test.segy -Gtest.nc -R0/100/0/10 -I0.5/0.2 -V -Qx0.1 -Qy0.1

Because the grid interval is larger than the SEGY file sampling, the
individual samples will be averaged in bins

See Also
--------

:doc:`gmt </gmt>`, :doc:`grd2xyz </grd2xyz>`,
:doc:`grdedit </grdedit>`, :doc:`segy`,
:doc:`xyz2grd </xyz2grd>`
