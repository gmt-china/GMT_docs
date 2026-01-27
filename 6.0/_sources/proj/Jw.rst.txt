-Jw：Mollweide投影
==================

维基链接：https://en.wikipedia.org/wiki/Mollweide_projection

此投影是伪圆柱等面积投影，由Karl Brandan Mollweide于1805年提出。
纬线是不等间隔分布的直线，经线是等间隔分布的椭圆弧。比例尺仅在南北纬40度44分
纬线上才是真实的。此投影主要用于绘制全球的数据分布图。

该投影的参数为：

**-JW**\ [*lon*/]\ *width*
或
**-Jw**\ [*lon*/]\ *scale*

*lon* 为中心经线，默认值为地图区域的中心。

.. gmtplot::
    :caption: 使用Mollweide投影绘制全球地图
    :width: 85%

    gmt coast -Rd -JW4.5i -Bg -Dc -A10000 -Gtomato1 -Sskyblue -png GMT_mollweide
