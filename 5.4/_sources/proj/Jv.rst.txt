-Jv：Van der Grinten投影
========================

维基链接：https://en.wikipedia.org/wiki/Van_der_Grinten_projection

此投影由Alphons J. van der Grinten于1904年提出，其既不等面积也不保角。
中心经线和赤道都是直线，其余经线则是圆弧，仅在赤道处比例尺是真实的，
主要用于在一个圆内展示整个世界地图。

该投影的参数为::

    -JV<lon>/<width>
    -Jv<lon>/<scale>

``<lon>`` 是投影中心经线，默认值为地图区域的中心。

.. gmtplot::
    :caption: 使用Van der Grinten投影绘制全球图

    gmt pscoast -Rg -JV4i -Bxg30 -Byg15 -Dc -Glightgray -A10000 -Wthinnest -P > GMT_grinten.ps
