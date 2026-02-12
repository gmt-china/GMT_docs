-Jf：球心方位投影
=================

维基链接：https://en.wikipedia.org/wiki/Gnomonic_projection

此投影是一个从中心投影到与表面相切的一个平面的透视投影。此投影既不等面积也不保角，
且在半球的边界处有很大畸变，但从投影中心出发的方向是真实的。大圆会被投影成直线。

该投影的参数为::

    -JF<lon>/<lat>[/<distance>]/<width>
    -Jf<lon>/<lat>[/<distance>]/<scale>

- ``<lon>/<lat>`` 投影中心的经纬度
- ``<distance>`` 地图边界到投影中心的角度，默认值为60度
- ``<scale>`` 可以是 ``1:xxxx`` 也可以是 ``<radius>/<latitude>``
  （\ ``<radius>`` 是投影中心到纬线 ``<latitude>`` 在图上的距离）

.. gmtplot::
    :caption: 球心方位投影

    gmt pscoast -Rg -JF-120/35/60/4.5i -B30g15 -Dc -A10000 -Gtan -Scyan -Wthinnest \
                -P > GMT_gnomonic.ps
