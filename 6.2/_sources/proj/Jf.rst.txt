-JF: Azimuthal gnomonic
=======================

维基链接：https://en.wikipedia.org/wiki/Gnomonic_projection

Azimuthal gnomonic（球心方位投影）是一个从中心投影到与表面相切的一个平面的透视投影。
此投影既不等面积也不保角，且在半球的边界处有很大畸变。
事实上，对于指定的中心而言，只能绘制不超过半球的区域。
但从投影中心出发的方向是真实的。大圆弧会被投影成直线。

该投影的参数为：

**-JF**\ *lon*/*lat*\ [/*distance*]/*width*
或
**-Jf**\ *lon*/*lat*\ [/*distance*]/*scale*


- *lon*/*lat* 投影中心的经纬度
- *distance* 地图边界到投影中心的角度，默认值为 60 度
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*）

.. gmtplot::
    :caption: 球心方位投影
    :width: 50%

    gmt coast -Rg -JF-120/35/60/12c -B30g15 -Dc -A10000 -Gtan -Scyan -Wthinnest -png GMT_gnomonic
