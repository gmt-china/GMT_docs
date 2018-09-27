-Jl：Lambert圆锥保角投影
========================

维基链接：https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection

此投影由Heinrich Lambert于1772年提出，主要用于绘制东西方向范围很大的地图。
与Albers投影不同的是，Lambert投影不是等面积的。纬线是共圆心的圆弧，经线是这些
圆的等间隔分布的半径。与Albers投影类似，只有两条标准纬线是无畸变的。

该投影的参数为::

    -JB<lon>/<lat>/<lat1>/<lat2>/<width>
    -Jb<lon>/<lat>/<lat1>/<lat2>/<scale>

- ``<lon>`` 和 ``<lat>`` 是投影中心的位置
- ``<lat1>`` 和 ``<lat2>`` 是两条标准纬线

Lambert保角投影场用于绘制美国地图，两个固定的标准纬线是33ºN和45ºN。

.. literalinclude:: /scripts/J_lambert_conic.sh

.. figure:: /images/J_lambert_conic.*
   :width: 100%
   :align: center

   Lambert保角圆锥投影

投影中心的选取并不影响投影，但其指定了哪一条经线垂直于地图。