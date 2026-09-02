-Jj：Miller圆柱投影
===================

维基链接：https://en.wikipedia.org/wiki/Miller_cylindrical_projection

此投影由Osborn Maitland Miller于1942年提出，该投影既不是保角也不是等面积。
所有的经线和纬线都是直线。该投影是Mercator与其他圆柱投影之间的折衷。在此投影中，
纬线之间的间距使用了Mercator公式并乘以0.8倍的真实纬度，因而避免了极点的奇点，
然后再将结果除以0.8。

该投影的参数为::

    -JJ<lon>/<width>
    -Jj<lon>/<scale>

``<lon>`` 为中心经度，默认为地图区域的中心。

.. gmtplot::
    :caption: 使用Miller圆柱投影绘制世界地图

    gmt pscoast -R-90/270/-80/90 -Jj1:400000000 -Bx45g45 -By30g30 -Dc -A10000 \
                -Gkhaki -Wthinnest -P -Sazure > GMT_miller.ps
