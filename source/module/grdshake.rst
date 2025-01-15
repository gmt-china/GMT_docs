.. index:: ! grdshake
.. include:: common_SYN_OPTs.rst_

grdshake
========

:官方文档: :doc:`gmt:supplements/seis/grdshake`
:简介: 使用 Vs30 速度模型计算地表峰值速度、加速度、烈度。

语法
----

**gmt grdshake** *ingrid* |-G|\ *outgrid*
|-L|\ *fault.dat*
|-M|\ *mag*
[ |-C|\ *a,v,i* ]
[ |-F|\ *mecatype* ]
[ |SYN_OPT-R| ]

必选选项
-------

*ingrid*
    Vs30 速度模型网格文件

.. _-G:

**-G**\ *outgrid*
    输出文件名。如果通过 |\-C| 设置了多个分量，
    则 <outgrid> 必须包含 %%s 以格式化分量代码。
    
.. _-L:

**-L**\ *fault.dat*
    断层坐标文件名

.. _-M:

**-M**\ *mag*
    地震事件的震级


可选选项
--------

.. _-C:

**-C**\ *a,v,i*
    以逗号隔开的需要计算的分量 (多个分量要求在 |-G| 有对应设置)。
    可以选择 *a*\ (cceleration，加速度)， *v*\ (elocity，速度)， *i*\ (ntensity，烈度) [默认为 *i*]。

.. _-F:

**-F**\ *1*\|\ *2*\|\ *3*\|\ *4*
    选择震源机制类型 ( **-F**\1 或 **-F**\2 ...)
       - 1 未知 [默认值]
       - 2 走滑
       - 3 正断层
       - 4 逆冲

.. _-R:

.. |Add_-R| replace:: This defines the subregion to be operated out.
.. include:: ../../explain_-R.rst_

.. _-V:

.. |Add_-V| unicode:: 0x20 .. just an invisible code
.. include:: ../../explain_-V.rst_

.. include:: ../../explain_-icols.rst_

.. include:: ../../explain_colon.rst_

.. include:: ../../explain_help.rst_


Examples
--------

To compute the intensity grid using the previously computed Vs30 velocities (*vs30.grd*) of an
event with magnitude 7 occurred along a fault whose trace is coordinates are provide in the
*line.dat* file, do::

    gmt grdshake vs30.grd -Gshake_intensity.grd -Lline.dat -Ci -M7 -V


See Also
--------

:doc:`grdvs30`,
:doc:`gmt </gmt>`
