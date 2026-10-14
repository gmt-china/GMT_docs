.. index:: ! gmtsimplify
.. include:: common_SYN_OPTs.rst_

gmtsimplify
===========

:官方文档: :doc:`gmt:gmtsimplify`
:简介: 使用Douglas-Peucker算法对线段做简化

**gmtsimplify** 模块读取一个或多个数据文件，并使用 Douglas-Peucker 算法对复杂多边形
进行简化，用曲线近似表示为一系列点并减少点的数量，并保证每个点与直线的偏离都在可容忍的范围内。

语法
----

**gmt simplify**
[ *table* ]
|-T|\ *tolerance*
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

.. _-T:

**-T**\ *tolerance*
    指定最大所能容忍的误差，即任意数据点与简化后的线段间的距离小于该值。
    默认单位为用户单位。对于地理数据（例如海岸线）可以指定其它
    `距离单位`。

可选选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

将澳大利亚的高精度海岸线数据简化，容忍误差为500km::

    gmt simplify @GSHHS_h_Australia.txt -T500k

将笛卡尔线段简化，可容忍误差为0.45::

    gmt simplify xylines.d -T0.45 > new_xylines.d

注意事项
--------

**gmtsimplify** 对于线段和闭合多边形的处理方式略有区别。
显式闭合的线段（即线段的首尾坐标相同）会被认为是闭合多边形，
否则视为线段。被当作多边形的线段可以被简化为无面积的3点多边形，
其不会被输出。

BUGS
----

Douglas-Peucker 算法的已知问题是交叉点的处理，即其无法保证简化后的线段不自我交叉，
多个线段也可能互相交叉。此外，当前的算法实现只支持平面距离。

参考文献
--------

Douglas, D. H., and T. K. Peucker, Algorithms for the reduction of the
number of points required to represent a digitized line of its
caricature, *Can. Cartogr.*, **10**, 112-122, 1973.

相关模块
--------

:doc:`gmtconnect`,
:doc:`gmtconvert`,
:doc:`gmtselect`
