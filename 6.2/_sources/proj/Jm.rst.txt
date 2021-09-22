-JM: Mercator cylindrical
=========================

维基链接：https://en.wikipedia.org/wiki/Mercator_projection

Mercator 投影是各种地图投影中最著名的一个，其由 Gerardus Mercator 于 1569 年提出。
此投影是圆柱保角投影，沿着赤道无畸变，但两极畸变严重。此投影的主要特点是等方位角的
线是一条直线，这样一条线称为 rhumb 线或 loxodrome。

在常规 Mercator 投影中，圆柱与赤道相切。
若圆柱沿着其他方向与地球相切，则称为横向 Mercator 投影或倾斜 Mercator 投影。

常规的 Mercator 投影需要的参数如下：

**-JM**\ [*lon*\ [/*lat*]/]\ *width*
或
**-Jm**\ [*lon*\ [/*lat*]/]\ *scale*

- *lon* 中心经线，默认为地图区域的中心
- *lat* 标准纬线，默认值为赤道。若要指定标准纬线，则必须同时指定中心经线
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: Mercator 投影
    :width: 85%

    gmt begin GMT_mercator pdf,png
    gmt set MAP_FRAME_TYPE fancy+
    gmt coast -R0/360/-70/70 -Jm0.03c -Bxa60f15 -Bya30f15 -Dc -A5000 -Gred
    gmt end
