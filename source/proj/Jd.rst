-JD: Equidistant conic
======================

维基链接：https://en.wikipedia.org/wiki/Equidistant_conic_projection

Equidistant conic（等距圆锥投影）由希腊哲学家 Claudius Ptolemy 于公元 150 年提出。
其既不是保角也不是等面积，而是两种的折衷。在所有经线以及标准纬线上比例尺没有畸变。

该投影的参数为：

**-JD**\ *lon0*/*lat0*/*lat1*/*lat2*/*width*
或
**-Jd**\ *lon0*/*lat0*/*lat1*/*lat2*/*scale*

- *lon*/*lat* 投影中心位置
- *lat1*/*lat2* 两条标准纬线
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上1厘米对应真实地球 *xxxx* 厘米）

等距圆锥投影常用于绘制小国家的地图集。

.. gmtplot::
    :caption: 等距圆锥地图投影
    :width: 85%

    gmt begin GMT_equidistant_conic
    gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0.15c
    gmt coast -R-88/-70/18/24 -JD-79/21/19/23/12c -Bag -Di -N1/thick,red -Glightgreen -Wthinnest
    gmt end show
