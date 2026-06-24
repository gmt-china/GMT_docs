.. index:: ! grdgravmag3d
.. include:: common_SYN_OPTs.rst_

grdgravmag3d
=============

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/grdgravmag3d`
:简介: 使用 Okabe 方法计算一个（或两个）网格形成的重力异常

**grdgravmag3d** 可以计算网格中包含的实体形成的重力异常/磁异常。
该算法计算速度一般，但可以计算任意复杂形状造成的异常。

语法
----

**gmt grdgravmag3d** *grdfile_top* [*grdfile_bot*] [ |-C|\ *density* ]
[ |-E|\ *thickness* ]
[ |-F|\ *xy_file* ]
[ |-G|\ *outgrid* ]
[ |-H|\ *args* ]
[ |SYN_OPT-I| ]
[ |-L|\ *z_obs* ]
[ |-Q|\ [**n**\ *n_pad*]\|\ [*pad_dist*]\|\ [*region*] ]
[ |SYN_OPT-R| ]
[ |-S|\ *radius* ]
[ |SYN_OPT-V| ]
[ |-Z|\ *level*\ [**b**\|\ **t**] ]
[ |SYN_OPT-f| ]
[ **-x**\ *+a|n|-n* ]
[ |SYN_OPT--| ]

必选选项
--------

*grdfile_top* [*grdfile_bot*]
    输入地形网格文件，输出结果为重力异常。如果输入 2 个网格文件，则计算两个地形
    网格围成的体积的重力异常或者磁异常。

.. _-C:

**-C**\ *density*
    设置物体密度，单位为 kg/m^3。该选项与 **-H** 不能同时使用

.. _-F:

**-F**\ *xy_file*
    计算位于 *xy_file* 文件中的点上的异常值。该选项与 **-G** 选项不能同时使用

.. _-G:

**-G**\ *outgrid*\ [=\ *ID*][**+d**\ *divisor*][**+n**\ *invalid*]
[**+o**\ *offset*\|\ **a**][**+s**\ *scale*\|\ **a**]
[:*driver*\ [*dataType*][**+c**\ *options*]]
    
    输出网格名，计算实体对该网格中点的异常值。各子选项含义见
    `网格文件 <https://docs.gmt-china.org/latest/grid/read/#id1>`__ 。

可选选项
--------

.. _-E:

**-E**\ *thickness*
    设置层厚度为 *thickness* ，单位为 m，默认为 500 m

.. _-H:

**-H**\ *f_dec/f_dip/m_int/m_dec/m_dip* 

**-H+m**\ *magfile*  

**-Hx**\|\ **y**\|\ **z**\|\ **h**\|\ **t** 

**-H+i**\|\ **g**\|\ **r**\|\ **f**\|\ **n**
    设置计算磁异常的参数（可以使用多次）
      
      *f_dec/f_dip* 地磁偏角/倾角

      *m_int/m_dec/m_dip*  物体磁强度/偏角/倾角

    或者使用网格模式

      **+m**\ *magfile* 其中 *magfile* 为磁强度文件

    以下选行用于计算分量

      **x**\|\ **X**\|\ **e**\|\ **E**  计算东西分量

      **y**\|\ **Y**\|\ **n**\|\ **N**  计算南北分量

      **z**\|\ **Z**  计算垂直分量

      **h**\|\ **H**  计算水平分量

      **t**\|\ **T**\|\ **f**\|\ **F**  计算整个场

    如果计算磁异常时，假定环境磁场不为常数，则可以使用 IGRF 设置可变的磁倾角和偏角，
    即 **-H+i**\|\ **g**\|\ **r**\|\ **f**\|\ **n**

.. include:: explain_-I.rst_

.. _-L:

**-L**\ *z_obs*
    设置观测水平面，默认为 0，同时也是计算异常的高度面

.. _-Q:

**-Q**\ [**n**\ *n_pad*]\|\ [*pad_dist*]\|\ [*region*]
    基于 **-R** 选项扩展计算区域

      **-Qn**\ *n_pad* 扩展边缘 *n_pad* * dx[/dy] 大小的范围，*n_pad* 为点数

      **-Q**\ *pad_dist* 只在东西方向分别扩展 *pad_dist* 大小的范围，*pad_dist* 为距离

      **-Q**\ *region* 与 **-R** 选项语法相同

.. include:: explain_-R.rst_


.. _-S:

**-S**\ *radius*
    以 km 为单位设置搜索半径，仅在两网格模式或者 **-E** 时有效，默认为 30 km。该选项通过
    不计算与当前节点距离大于 *radius* 的棱柱的影响来加快计算速度，但会导致结果不准确。

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ *level*\ [**b**\|\ **t**]
    设置参考平面，默认 *level* = 0。计算时将使用该参考面与地形网格构成的区域形成的异常。
    参考面在水平方向穿过地形网格时，使用 **-Zb** 或 **Zt** 将分别计算参考面与地形网格
    构成的区域的下部或者上部形成的异常。

.. include:: explain_-f.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

网格距离单位
------------

如果输入的笛卡尔网格的水平方向距离的单位不是米，可以通过对输入文件名
**+u**\ *unit* 来将指定的单位转换为米。例如：对输入文件 **+uk** 将会把
输入网格的 x 和 y 坐标的单位从 km 转换为 m。如果输入网格为地理网格，可以
通过 |SYN_OPT-f| 将单位转换为米

示例
----

计算桑迪岛及其附近海山造成的重力异常 ::

    gmt grdgravmag3d sandy_bat.grd -C1700 -Z-4300 -fg -I1m -Gsandy_okb.grd -V

假定某区域磁场强度为 :file:`mag.grd` 文件中的值，计算 :file:`bat.grd` 地形网格形成的
磁场的垂直分量，其中磁场的倾角和偏角由 IGRF 定义，计算过程中使用 4 核加速计算 ::

    gmt grdgravmag3d bat.grd -E10000 -Gcomp_Z.grd -Hz -H+n -H+mmag.grd -x4 -V -S50

参考文献
--------

Okabe, M., Analytical expressions for gravity anomalies due to
polyhedral bodies and translation into magnetic anomalies, *Geophysics*,
44, (1979), p 730-741.

相关模块
--------

:doc:`gmtgravmag3d`,
:doc:`talwani3d`,
:doc:`talwani2d`
