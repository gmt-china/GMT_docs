:author: 田冬冬, 陈箫翰
:date: 2026-01-11

.. index:: ! segy2grd
.. program:: segy2grd

segy2grd
=============

:官方文档: :doc:`gmt:supplements/segy/segy2grd`
:简介: 将 SEGY 文件转换为网格文件

**segy2grd** 用于读取 IEEE SEGY 文件并创建二进制网格文件。它可以执行简单的映射(相当于 xyz2grd -Z)，或者在单个网格单元包含 SEGY 文件中多个样本值的情况下进行更复杂的平均值计算。

如果某些节点没有填充数据，**segy2grd** 会进行报告。这些未被约束的节点会被设置为用户指定的值[默认值为 NaN]。对于包含多个值的节点，将被设为这些值的平均值。

语法
--------

**gmt segy2grd**
*segyfile*
:option:`-G`\ *grdfile*
:option:`-I`\ *increment*
:option:`-R`\ *region*
[ :option:`-A`\ [**n**\|\ **z**] ]
[ :option:`-D`\ *paras* ]
[ :option:`-L`\ [*nsamp*] ]
[ :option:`-M`\ [*ntraces*] ]
[ :option:`-Q`\ **x**\|\ **y**\ *value* ]
[ :option:`-S`\ [*header*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-r`\ *reg* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

*segyfile* 
    *segyfile* 是一个 IEEE 浮点数格式的 SEGY 文件。所有的道集都假定从 0 时间/深度域开始。

必须选项
------------------

.. include:: explain_grd_out.rst_

.. option:: -I

**-I**\ *x_inc*\ /[*y_inc*]
    *x_inc* [以及可选的 *y_inc*] 是网格间距。可以在数值后添加 **m** 表示分钟，或添加 **s** 表示秒。

.. include:: explain_-R.rst_

可选选项
------------------

.. option:: -A

**-A**\ [**n**\|\ **z**]
    将属于同一节点(相同坐标)的多个值相加(等同于 **-Az**)。
    添加 **n** 则仅统计分配到每个节点的数据点数量。
    [默认情况下(不使用 :option:`-A` 选项)会计算平均值]。该选项不用于简单映射。

.. include:: explain_-D_cap.rst_

.. option:: -L

**-L**\ [*nsamp*]
    使用 *nsamp* 覆盖每道的采样点数

.. option:: -M

**-M**\ [*ntraces*]
    设定要读取的道数。默认尝试读取10000道。
    :option:`-M`\ 0 将读取二进制头中指定的道数，
    :option:`-M`\ *ntraces* 将尝试仅读取 *n* 道。

.. option:: -Q

**-Q**\ **x**\|\ **y**\ *value*
    根据不同指令可用于更改两种不同的设置:

        - **-Qx**\ *x-scale* ：对道头中的坐标应用缩放因子 *x-scale* ，使其匹配 :option:`-R` 中指定的坐标范围
        - **-Qy**\ *s_int* ：当 SEGY 文件中的采样间隔不正确时，指定采样间隔为 *s_int* 。可重复使用。

.. option:: -S

**-S**\ [*header*]
    设置可变间距。 *header* 可以是 **c** 表示 CDP(共同深度点)，**o** 表示偏移量，
    或 **b**\ *number* 表示从第 *number* 字节开始的4字节浮点数。
    如果未设置 :option:`-S`，则假定样本按照 :option:`-I` 提供的 *x_inc* , *y_inc* 进行均匀间隔。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_
..

    同时将没有输入 SEGY 覆盖的节点设置为该值 [默认值为 NaN]。

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_


示例
--------

从一个等间距的 SEGY 文件 test.segy 创建网格文件，读取每道上 18-25 秒时间域(或千米深度域)的数据，第一道会被假定位于 X=198 的位置::

    gmt segy2grd test.segy -I0.1/0.1 -Gtest.nc -R198/208/18/25

从 SEGY 文件 test.segy 创建网格文件，根据 CDP 编号定位道集，其中每千米有 10 个 CDP，采样间隔为 0.1。由于网格间隔大于 SEGY 文件的采样间隔，因此单个样本将在网格单元内进行平均::

    gmt segy2grd test.segy -Gtest.nc -R0/100/0/10 -I0.5/0.2 -Qx0.1 -Qy0.1

相关模块
--------

:doc:`grd2xyz`,
:doc:`segy`,
:doc:`xyz2grd`
