-Jw：Mollweide投影
==================

维基链接：https://en.wikipedia.org/wiki/Mollweide_projection

此投影是伪圆柱等面积投影，由Karl Brandan Mollweide于1805年提出。纬线是不等间隔
分布的直线，经线是等间隔分布的椭圆弧。比例尺仅在南北纬40度44分纬线上才是真实的。
此投影主要用于绘制全球的数据分布图。

该投影的参数为::

    -JW[<lon>/]<width>
    -Jw[<lon>/]<scale>

``<lon>`` 为中心经线，默认值为地图区域的中心。

.. literalinclude:: /scripts/GMT_mollweide.sh

.. figure:: /images/GMT_mollweide.*
   :width: 100%
   :align: center

   使用Mollweide投影绘制全球地图
