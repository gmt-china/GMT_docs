-Jh：等面积Hammer投影
=====================

维基链接：https://en.wikipedia.org/wiki/Hammer_projection

等面积Hammer投影由Ernst von Hammer于1892年提出，也被称为Hammer-Aitoff投影（Aitoff投影与之看起来相似，但不等面积）。投影后的边界是一个椭圆，赤道和中心经线是执行，其余纬线和经线都是复杂曲线。

该投影的参数为::

    -JH[<lon>/]<width>
    -Jh[<lon>/]<scale>

``<lon>`` 是中心经线，默认位于地图区域的中心。

.. gmtplot::
    :caption: 使用Hammer投影绘制全球地图

    gmt pscoast -Rg -JH4.5i -Bg -Dc -A10000 -Gblack -Scornsilk -P > GMT_hammer.ps
