-Jpoly：多圆锥投影
==================

维基链接：https://en.wikipedia.org/wiki/Polyconic_projection

此投影既不是等面积也不是保角投影，沿着中心经线处畸变为0。所有纬线的比例尺都是真实的，
但其余经线则存在畸变。

.. gmtplot::
    :caption: 多圆锥投影

    gmt pscoast -R-180/-20/0/90 -JPoly/4i -Bx30g10 -By10g10 -Dc -A1000 -Glightgray \
                -Wthinnest -P > GMT_polyconic.ps
