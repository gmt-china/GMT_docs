-Je：方位等距投影
=================

维基链接：https://en.wikipedia.org/wiki/Azimuthal_equidistant_projection

方位投影最显著的特征是在图上测量的从中心到任意一点的距离是真实的。因而，地图上
以投影中心为圆心的圆在真实地球上与投影中心是等距离的。同时，从中心出发的任意
方向也是真实的。该投影常用于展示多个地理位置与指定点的距离图。

该投影的参数为：

**-JE**\ *lon0*/*lat0*\ [*/horizon*]/*width*
或
**-Je**\ *lon0*/*lat0*\ [*/horizon*]/*scale*

- *lon*/*lat* 投影中心的经纬度
- *distance* 是边界距离投影中心的度数，默认值为180，即绘制全球图
- *scale* 可以取 1:*xxxx* 格式，也可以是 *radius*/*latitude*
  （表示从投影中心到 纬线 *latitude* 在图上的距离为 *radius*\ ）

下图中，投影中心为100°W/40°N，离投影中心180度的点在图中的最外边界处。

.. gmtplot::
    :caption: 使用等距方位投影绘制全球图
    :width: 50%

    gmt coast -Rg -JE-100/40/4.5i -Bg -Dc -A10000 -Glightgray -Wthinnest -png GMT_az_equidistant
