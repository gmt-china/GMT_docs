.. index:: ! grdvolume
.. include:: common_SYN_OPTs.rst_

grdvolume
=========

:官方文档: :doc:`gmt:grdvolume`
:简介: 计算网格数据中某个等值线所包围的表面积和体积

**grdvolume** 模块读取一个2D网格文件，通过指定某条等值线确定一个Z值平面，并计算由该等值线
约束的区域网格表面积、网格表面到该平面所包围的体积，以及最大平均高度（体积/面积）。
也可以指定一系列等值线，此时该模块会分别计算每个等值线范围内的表面积和体积。

语法
----

**gmt grdvolume** *grdfile*
[ |-C|\ *cval* or |-C|\ *low/high/delta* or |-C|\ **r**\ *low/high* or |-C|\ **r**\ *cval*]
[ |-L|\ *base* ]
[ |SYN_OPT-R| ]
[ |-S|\ [*unit*] ]
[ |-T|\ [**c**\|\ **h**] ]
[ |SYN_OPT-V| ]
[ |-Z|\ *fact*\ [/*shift*] ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT--| ]


必选选项
--------

*grdfile*
    输入的2D网格文件名

可选选项
--------

.. _-C:

**-C**\ *cval* or **-C**\ *low/high/delta* or **-Cr**\ *low/high* or **-Cr**\ *cval*
    指定等值线（Z值平面）以计算由该等值线所包含的表面积、体积以及平均高度（体积/面积）。
    若不使用该选项，则返回整个网格文件的表面积、体积和平均高度。

    该选项有四种不同的语法：

    - **-C**\ *cval* 指定单个等值线并计算等值线内的区域面积、体积和平均高度
    - **-C**\ *low/high/delta* 指定多条等距等值线并计算每个等值线所包含的区域面积、体积和平均高度
    - **-Cr**\ *low/high* 计算两个Z值平面之间的体积
    - **-Cr**\ *cval* 计算  *cval* 到网格最小值范围内的体积

.. _-L:

**-L**\ *base*
    计算体积时加上从 z=\ *base* 到等值线的体积

.. _-S:

**-S**\ [*unit*]
    对于地理网格，默认会将度转换为平面距离，默认单位为米。
    使用该选项指定其它长度单位，则输出的表面积单位为 *unit*\ :math:`^2`，
    输出的体积单位则是 z_unit * *unit*\ :math:`^2`。

.. _-T:

**-T**\ [**c**\|\ **h**]
    找到最大平均高度所对应的等值线

    - **-Th** 找到最大平均高度（体积/面积）所对应的等值线
    - **-Tc** 找到最大曲率（高度vs等值线值）所对应的等值线

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ *fact*\ [/*shift*]
    将数据减去 *shift* 再乘以比例因子 *fact*

.. include:: explain_-f.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_help.rst_

示例
----

计算夏威夷岛中所有陆地部分（高于0等值线）部分的面积（:math:`km^2`）、体积（:math:`km^3`）
和平均高度（km）::

    gmt grdvolume @earth_relief_05m -R190/210/15/25 -C0 -Sk -Z0.001

计算网格表面与等值线 :math:`Z=250m` 之间的体积::

    gmt grdvolume peaks.nc -Se -C250

在等值线100到300范围内，以10为间隔，计算所有等值线所约束的表面积和体积::

    gmt grdvolume peaks.nc -Sk -C100/300/10 > results.d

在等值线100到300范围内，以10为间隔，搜索最大平均高度（即体积与表面积的比）所对应的等值线值::

    gmt grdvolume peaks.nc -Sk -C100/300/10 -Th > results.d

计算湖内从表面到300米深度范围内水的体积::

    gmt grdvolume lake.nc -Cr-300/0

参考文献
--------

Wessel, P., 1998, An empirical method for optimal robust regional-residual
separation of geophysical data, *Math. Geol.*, **30**\ (4), 391-408.

相关模块
--------

:doc:`grdfilter`,
:doc:`grdmask`,
:doc:`grdmath`
