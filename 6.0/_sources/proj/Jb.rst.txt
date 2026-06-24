-Jb：Albers圆锥等面积投影
=========================

维基链接：https://en.wikipedia.org/wiki/Albers_projection

此投影由Albers于1805年提出，主要用于绘制东西方向范围很大的地图，尤其是美国地图。

此投影是圆锥、等面积投影。纬线是不等间隔分布的同心圆，在地球南北极处分布较密。
经线则是等间隔分隔，并垂直切割纬线。

在两条标准纬线处，比例尺和形状的畸变最小；在两者之间，沿着纬线的比例尺太小；
在两者外部，沿着经线的比例尺则太大。沿着经线，则完全相反。

该投影方式的参数为：

**-JB**\ *lon*/*lat*/*lat1*/*lat2*/*width*
或
**-Jb**\ *lon*/*lat*/*lat1*/*lat2*/*scale*

- *lon* 和 *lat* 是投影中心的位置
- *lat1* 和 *lat2* 是两条标准纬线

下图绘制了台湾附近的区域，投影中心位于125°E/20°N，25度和45度纬线是两条标准纬线。

.. gmtplot::
    :caption: Albers圆锥等面积投影
    :width: 75%

    gmt begin GMT_albers pdf,png
    gmt set MAP_GRID_CROSS_SIZE_PRIMARY 0
    gmt coast -R110/140/20/35 -JB125/20/25/45/5i -Bag -Dl -Ggreen -Wthinnest -A250
    gmt end
