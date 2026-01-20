:author: 陈箫翰
:date: 2026-01-20

.. index:: ! grdshake
.. program:: grdshake

grdshake
==========

:官方文档: :doc:`gmt:supplements/seis/grdshake`
:简介: 使用 Vs30 速度模型计算地表峰值速度、加速度、烈度。

语法
------

**gmt grdshake**
*ingrid*
:option:`-G`\ *outgrid*
:option:`-L`\ *fault.dat*
:option:`-M`\ *mag*
[ :option:`-C`\ *a,v,i* ]
[ :option:`-F`\ *mecatype* ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-i`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]

输入数据
--------

.. include:: explain_grd_in.rst_
..

    Vs30 速度模型网格文件。

必须选项
---------

.. include:: explain_grd_out.rst_
..

    如果通过 :option:`-C` 设置了多个分量，
    则 *outgrid* 必须包含 %%s 以格式化分量代码。

.. option:: -L

**-L**\ *fault.dat*
    发生滑动的断层，它的迹线经纬度坐标文件。
    内容格式与表示线段的格式相同，也可以是多段数据表示的多条线段，表示多个断层同时发生滑动。

.. option:: -M

**-M**\ *mag*
    地震事件的震级

可选选项
---------

.. option:: -C

**-C**\ *a,v,i*
    以逗号隔开的需要计算的分量 (多个分量要求在 :option:`-G` 有对应设置)。
    可以选择 *a*\ (cceleration，加速度)， *v*\ (elocity，速度)， *i*\ (ntensity，烈度) [默认为 *i*]。

.. option:: -F

**-F**\ *1*\|\ *2*\|\ *3*\|\ *4*
    选择震源机制类型 ( :option:`-F`\1 或 :option:`-F`\2 ...)
       - 1 未知 [默认值]
       - 2 走滑
       - 3 正断层
       - 4 逆冲

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_-icols.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
-----

使用计算好的 Vs30 速度模型，针对一次发生在断层上的地震事件（震级为7），
计算地表峰值烈度。其断层迹线坐标保存在 *line.dat* 文件中::

    gmt grdshake vs30.grd -Gshake_intensity.grd -Lline.dat -Ci -M7

计算并绘制发生在红河断裂的一个9级地震，在云贵川三省造成的地表峰值烈度：

.. gmtplot:: grdshake/grdshake_ex1.sh
   :width: 80%
   :align: center

相关模块
---------

:doc:`grdvs30`
