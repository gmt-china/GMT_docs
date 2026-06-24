.. index:: ! gmtregress
.. include:: common_SYN_OPTs.rst_

gmtregress
==========

:贡献者: |周茂|
:最近更新日期: 2024-10-23

----

:官方文档: :doc:`gmt:gmtregress`
:简介: 一维数据线性回归

**regress** 读取一个或多个表数据（也可从标准输入读取），确定每个分段最佳的线性[加权]
回归模型 :math:`y(x) = a + b x` 。用户可自己指定输出哪些数据和模型。默认情况下，将
所有的输入数据作为一个整体来确定模型，但也可将数据分为等间距的数据段，在每段分别确定
模型。除了确定最贴近的模型外，该模块还可以输出所有可能的不同斜率的回归模型，这在分析
居于很多离群数据时非常有用。

.. note::

    如果用户需要对 x 和 y 坐标的对数结果做拟合，可以使用 |SYN_OPT-i| 选项在读数据后
    将其转换为对数坐标

语法
----

**gmt regress** [ *table* ] [ |-A|\ [*min*\ /*max*\ /*inc*][**+f**\ [**n**\|\ **p**]] ]
[ |-C|\ *level* ]
[ |-E|\ **x**\|\ **y**\|\ **o**\|\ **r** ]
[ |-F|\ *flags* ]
[ |-N|\ **1**\|\ **2**\|\ **r**\|\ **w** ]
[ |-S|\ [**r**] ]
[ |-T|\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ |-T|\ *file*\|\ *list* ]
[ |SYN_OPT-V| ]
[ |-W|\ [**w**]\ [**x**]\ [**y**]\ [**r**] ]
[ |-Z|\ [**+**\|\ **-**]\ *limit* ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_
..
    
    前两列为分别为 *x* 和 *y*。在设置 |-W| 和 |-E| 时，需要另外的 1-3
    列作为数据的误差估计，或他们之间的相关系数（见 |-W|）。

可选选项
--------

.. _-A:

**-A**\ [*min*\ /*max*\ /*inc*][**+f**\ [**n**\|\ **p**]]
    该选项存有两种用法：(1) 使用该选项计算一个回归模型的范围，而不是计算最优的模型。
    即以 *inc* 计算线段斜率角度在 *min* 到 *max*

.. _-W:

**-W**\ [**w**]\ [**x**]\ [**y**]\ [**r**]

.. _-Z:

**-Z**\ [±]\ *limit*


.. include:: explain_-V.rst_

.. include:: explain_help.rst_

.. include:: explain_-aspatial.rst_

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

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

.. include:: explain_array.rst_


注意事项
--------

1. 输出段的头部信号包含计算得到的所有统计信息，这些信息的顺序为：点的个数、
   x 坐标的平均值、y 坐标的平均值、拟合直线的角度、misfit、斜率、截距、
   斜率的标准差、截距的标准差。对于 **-Ey** 的情况，同时输出

2. 对于直线拟合之外的更一般的线性模型的回归，请参阅 :doc:`gmtmath` 的 **-A**
   选项以及 **LSQFIT** 或者 **SVDFIT** 操作符。


示例
----

参考文献
--------

Bevington, P. R., 1969, *Data reduction and error analysis for the physical sciences*,
336 pp., McGraw-Hill, New York.

Draper, N. R., and H. Smith, 1998, *Applied regression analysis*, 3rd ed., 736 pp.,
John Wiley and Sons, New York.

Rousseeuw, P. J., and A. M. Leroy, 1987, *Robust regression and outlier detection*,
329 pp., John Wiley and Sons, New York.

York, D., N. M. Evensen, M. L. Martinez, and J. De Basebe Delgado, 2004, Unified
equations for the slope, intercept, and standard errors of the best straight line,
*Am. J. Phys.*, 72(3), 367-375.

相关模块
--------

:doc:`gmtmath`,
:doc:`trend1d`,
:doc:`trend2d`
