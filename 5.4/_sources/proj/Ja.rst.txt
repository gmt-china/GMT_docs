-Ja：Lambert方位等面积投影
==========================

维基链接: https://en.wikipedia.org/wiki/Lambert_azimuthal_equal-area_projection

该投影由Lambert于1772年发展得到，通常用于绘制大区域地图（例如整个大洲或半球），
该投影是方位等面积投影。在投影的中心畸变为0，离投影中心距离越远，
畸变越大。该投影的参数为::

    -JA<lon>/<lat>/[<distance>/]<width>
    -Ja<lon>/<lat>/[<distance>/]<scale>

- ``<lon>/<lat>`` 投影中心坐标
- ``<distance>`` 投影中心到边界的角度，默认值为90，即距离投影中心各90度，即整个半球
- ``<width>`` 地图宽度
- ``<scale>`` 地图比例尺 ``1:xxxx`` 或 ``<radius>/<latitude>``
  （\ ``<radius>`` 是纬线 ``<latitude>`` 与投影中心在图上的距离）

矩形地图
--------

对于此投影而言，经线和纬线通常不是直线，因而不适合用于指定地图边界。因而本例中
通过指定区域的左下角（0ºE/40ºS）和右上角（60ºE/10ºS）的坐标来指定区域范围。

.. gmtplot::
    :caption: 使用Lambert方位等面积投影绘制矩形地图

    gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_GRID_CROSS_SIZE_PRIMARY 0
    gmt pscoast -R0/-40/60/-10r -JA30/-30/4.5i -Bag -Dl -A500 -Gp300/10 \
                -Wthinnest -P > GMT_lambert_az_rect.ps

半球地图
--------

要绘制半球地图，需要指定区域范围为整个地球。下图绘制了以南美洲为中心的半球图。

.. gmtplot::
    :caption: 使用Lambert方位等面积投影绘制半球地图

    gmt pscoast -Rg -JA280/30/3.5i -Bg -Dc -A1000 -Gnavy -P > GMT_lambert_az_hemi.ps

震源辐射花样
------------

地震学在绘制震源机制解时，就是将三维的辐射花样信息投影到一个水平面内。
投影的方式有两种：Schmidt网和Wulff网。其中Schmidt网使用的就是Lambert方位
等面积投影（中心经纬度为0/0），Wulff网使用的则是等角度的立体投影。
两种震源球投影方式如下图所示：

.. gmtplot:: /scripts/GMT_stereonets.sh
    :show-code: false
    :caption: 震源球投影：等面积的Schmidt网和等角度的Wulff网
