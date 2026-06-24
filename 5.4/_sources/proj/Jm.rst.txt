-Jm：Mercator投影
=================

维基链接：https://en.wikipedia.org/wiki/Mercator_projection

此投影是圆柱保角投影，沿着赤道无畸变，但两极畸变严重。此投影的主要特点是等方位角的
线是一条直线，这样一条线称为rhumb线或loxodrome。

在常规Mercator投影中，圆柱与赤道相切。若圆柱沿着其他方向与地球相切，则称为横向
Mercator投影或倾斜Mercator投影。

常规的Mercator投影需要的参数如下::

    -JM[<lon>[/<lat>]/]<width>
    -Jm[<lon>[/<lat>]/]<scale>

- ``<lon>`` 中心经线，默认为地图区域的中心
- ``<lat>`` 标准纬线，默认值为赤道。若要指定标准纬线，则必须同时指定中心经线

.. gmtplot::
    :caption: Mercator投影

    gmt set MAP_FRAME_TYPE fancy
    gmt pscoast -R0/360/-70/70 -Jm1.2e-2i -Bxa60f15 -Bya30f15 -Dc -A5000 -Gred \
                -P > GMT_mercator.ps
