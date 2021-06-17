-Je：方位等距投影
=================

维基链接：https://en.wikipedia.org/wiki/Azimuthal_equidistant_projection

方位投影最显著的特征是在图上测量的从中心到任意一点的距离是真实的。因而，地图上
以投影中心为圆心的圆在真实地球上与投影中心是等距离的。同时，从中心出发的任意
方向也是真实的。该投影常用于展示多个地理位置与指定点的距离图。

该投影的参数为：

**-JE**\ *lon0*/*lat0*\ [*/distance*]/*width*
或
**-Je**\ *lon0*/*lat0*\ [*/distance*]/*scale*

- *lon*/*lat* 投影中心的经纬度
- *distance* 是边界距离投影中心的度数，默认值为180，即绘制全球图
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*\ ）

下图中，投影中心为100°W/40°N，离投影中心180度的点在图中的最外边界处。

.. gmtplot::
    :caption: 使用等距方位投影绘制全球图
    :width: 50%

    gmt coast -Rg -JE-100/40/12c -Bg -Dc -A10000 -Glightgray -Wthinnest -png GMT_az_equidistant

.. _gmt-JE-example:

在以台站为核心的研究中（例如接收函数、S波分裂等），经常需要绘制以台站为中心的地震分布图。
下面的例子展示了地震相对于台站的距离以及方位角分布图的画法：

.. gmtplot::
    :width: 70%
    
    #!/bin/bash
    # 假定台站位于 105/30 处
    stlo=105
    stla=30
    # 使用-JE投影，其后面的四个参数分别是: 中心经度/中心纬度/最大震中距/图片宽度
    J=E$stlo/$stla/90/10c

    gmt begin map png,pdf
    gmt set FORMAT_GEO_MAP=+D
    gmt coast -J$J -Rg -A10000 -Ggrey
    # 绘制台站位置（三角形）
    echo $stlo $stla | gmt plot -St0.4c -Ggreen -Bya180
    # 绘制地震震源位置
    gmt plot -Sa0.4c -Gyellow -W0.1p << EOF
    145 30
    160 40
    60 40
    80 -10
    EOF
    # 绘制30和60度等震中距线
    echo $stlo $stla 6672 | gmt plot -SE- -W1p,red
    echo $stlo $stla 13344 | gmt plot -SE- -W1p,red
    # 在30, 60, 90度处添加文字
    gmt text -D0c/0.3c << EOF
    $stlo 0 30\232
    $stlo -30 60\232
    $stlo -59.9 90\232
    EOF
    gmt end show