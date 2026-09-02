-JL: Lambert conic conformal
============================

维基链接：https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection

Lambert conic conformal（Lambert 圆锥保角投影）由 Johann Heinrich Lambert 于 1772 年提出，
主要用于绘制东西方向范围很大的地图。
与 Albers 投影不同的是，Lambert 投影不是等面积的。
纬线是共圆心的圆弧，经线是这些圆的等间隔分布的半径。
与 Albers 投影类似，只有两条标准纬线是无畸变的。
投影中心的选取并不影响投影，但其指定了哪一条经线垂直于地图。

该投影的参数为：

**-JL**\ *lon0*/*lat0*/*lat1*/*lat2*/*width*
或
**-Jl**\ *lon0*/*lat0*/*lat1*/*lat2*/*scale*

- *lon0* 和 *lat0* 是投影中心的位置
- *lat1* 和 *lat2* 是两条标准纬线
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

Lambert 保角投影场用于绘制美国地图，两个固定的标准纬线是 33°N 和 45°N。

.. gmtplot::
    :caption: Lambert 保角圆锥投影
    :width: 85%

    gmt begin GMT_lambert_conic
    gmt set MAP_FRAME_TYPE fancy FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0.15c
    gmt coast -R-130/-70/24/52 -JL-100/35/33/45/12c -Bag -Dl -N1/thick,red -N2/thin -A500 -Gtan -Wthinnest,white -Sblue
    gmt end show
