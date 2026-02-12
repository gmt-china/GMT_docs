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

- *lon* 是投影中心经线 [默认为地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上1厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用Mollweide投影绘制全球地图
    :width: 85%

    gmt coast -Rd -JW12c -Bg -Dc -A10000 -Gtomato1 -Sskyblue -png GMT_mollweide
