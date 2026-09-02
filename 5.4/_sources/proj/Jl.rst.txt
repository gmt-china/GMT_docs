-Jl：Lambert圆锥保角投影
========================

维基链接：https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection

此投影由Heinrich Lambert于1772年提出，主要用于绘制东西方向范围很大的地图。
与Albers投影不同的是，Lambert投影不是等面积的。纬线是共圆心的圆弧，
经线是这些圆的等间隔分布的半径。与Albers投影类似，只有两条标准纬线是无畸变的。

该投影的参数为::

    -JL<lon>/<lat>/<lat1>/<lat2>/<width>
    -Jl<lon>/<lat>/<lat1>/<lat2>/<scale>

- ``<lon>`` 和 ``<lat>`` 是投影中心的位置
- ``<lat1>`` 和 ``<lat2>`` 是两条标准纬线

Lambert保角投影场用于绘制美国地图，两个固定的标准纬线是33ºN和45ºN。

.. gmtplot::
    :caption: Lambert保角圆锥投影

    gmt set MAP_FRAME_TYPE FANCY FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0.05i
    gmt pscoast -R-130/-70/24/52 -Jl-100/35/33/45/1:50000000 -Bag -Dl -N1/thick,red \
                -N2/thinner -A500 -Gtan -Wthinnest,white -Sblue -P > GMT_lambert_conic.ps

投影中心的选取并不影响投影，但其指定了哪一条经线垂直于地图。
