-JPoly: (American) polyconic
============================

维基链接：https://en.wikipedia.org/wiki/Polyconic_projection

(American) polyconic（多圆锥投影）既不是等面积也不是保角投影，沿着中心经线处畸变为 0。
所有纬线的比例尺都是真实的，但其余经线则存在畸变。

.. gmtplot::
    :caption: 多圆锥投影
    :width: 75%

    gmt coast -R-180/-20/0/90 -JPoly/10c -Bx30g10 -By10g10 -Dc -A1000 -Glightgray -Wthinnest -png GMT_polyconic
