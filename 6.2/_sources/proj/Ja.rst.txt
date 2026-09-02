-JA: Lambert azimuthal equal area
=================================

维基链接: https://en.wikipedia.org/wiki/Lambert_azimuthal_equal-area_projection

Lambert azimuthal equal area（Lambert 方位等面积投影）由 Johann Heinrich Lambert 于 1772 年发展得到。
通常用于绘制大区域地图（例如整个大洲或半球），该投影是方位等面积投影。
在投影的中心畸变为 0，离投影中心越远畸变越大。该投影的参数为：

**-JA**\ *lon*/*lat*/[*distance*/]\ *width*
或
**-Ja**\ *lon*/*lat*/[*distance*/]\ *scale*

- *lon*/*lat* 投影中心坐标
- *distance* 投影中心到边界的角度，默认值为 90，即距离投影中心各 90°，即整个半球
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*）

矩形地图
--------

此投影下，经线和纬线通常不是直线，因而不适合直接用经纬线指定地图边界。
本例中通过指定区域的左下角（0°E/40°S）和右上角（60°E/10°S）的坐标来指定区域范围。
**-R** 中 **+r** 用于告诉 GMT 此处指定的是左下角和右上角的坐标。

.. gmtplot::
    :caption: 使用 Lambert 方位等面积投影绘制矩形地图
    :width: 75%

    gmt begin GMT_lambert_az_rect pdf,png
    gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0
    gmt coast -R0/-40/60/-10+r -JA30/-30/12c -Bag -Dl -A500 -Gp10+r300 -Wthinnest
    gmt end

半球地图
--------

要绘制半球地图，需要指定区域范围为整个地球，此时可以使用 **-Rg** 或 **-Rd**。
下图绘制了以南美洲为中心的半球图。

.. gmtplot::
    :caption: 使用 Lambert 方位等面积投影绘制半球地图
    :width: 40%

    gmt coast -Rg -JA280/30/12c -Bg -Dc -A1000 -Gnavy -png GMT_lambert_az_hemi

震源辐射花样
------------

地震学在绘制震源机制解时，就是将三维的辐射花样信息投影到一个水平面内。
投影的方式有两种：Schmidt 网和 Wulff 网。其中 Schmidt 网使用的就是 Lambert 方位
等面积投影（中心经纬度为 0/0），Wulff 网使用的则是等角度的立体投影（**-JS**）。
两种震源球投影方式如下图所示：

.. gmtplot::
    :show-code: false
    :caption: 震源球投影：等面积的 Schmidt 网和等角度的 Wulff 网
    :width: 75%

    gmt begin J_stereonets pdf,png
    gmt basemap -R0/360/-90/90 -JA0/0/1.75i -Bg15
    echo "180 -90 SCHMIDT" | gmt text -N -D0/-0.2c -F+f12p,Helvetica-Bold+jTC
    gmt basemap -JS0/0/1.75i -Bg15 -X2.75i
    echo "180 -90 WULFF" | gmt text -N -D0/-0.2c -F+f12p,Helvetica-Bold+jTC
    gmt end
