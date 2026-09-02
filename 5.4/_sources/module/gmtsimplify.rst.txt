.. index:: ! gmtsimplify

gmtsimplify
===========

:官方文档: :doc:`gmt:gmtsimplify`
:简介: 使用Douglas-Peucker算法对线段做简化

该命令可以将一个复杂多边形进行简化，用一条直线代替一系列点，并保证每个点与直线的
偏离都在可容忍的范围内。

选项
----

``-T<tolerance>[<unit>]``
    指定最大所能容忍的误差。默认单位为用户单位，也可以指定其他距离单位。

示例
----

将线段简化，可容忍误差为2千米::

    gmt simplify segment.d -T2k > new_segment.d

将笛卡尔线段简化，可容忍误差为0.45::

    gmt simplify xylines.d -T0.45 > new_xylines.d

参考文献
--------

Douglas, D. H., and T. K. Peucker, Algorithms for the reduction of the
number of points required to represent a digitized line of its
caricature, *Can. Cartogr.*, **10**, 112-122, 1973.
