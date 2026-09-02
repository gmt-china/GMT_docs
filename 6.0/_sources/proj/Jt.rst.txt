-Jt：横向Mercator投影
=====================

维基链接：https://en.wikipedia.org/wiki/Transverse_Mercator_projection

此投影由Lambert于1772年提出。该投影中，圆柱与某条经线相切。在该经线处无畸变。
离中心经线越远畸变越大，距离中心经线90度处的经线畸变达到无穷。中心经线和赤道
都是直线，其余经线和纬线则是复杂曲线。

该投影的参数:

**-JT**\ *lon*\ [/*lat*]/*width*
**-Jt**\ *lon*\ [/*lat*]/*scale*

*lon* 中心经线，\ *lat* 原点的纬度，默认值为赤道。

地图缩放因子默认值为1，可以通过修改参数 :term:`PROJ_SCALE_FACTOR`
以实现自定义。

.. gmtplot::
    :caption: 矩形横向Mercator地图
    :width: 75%

    gmt coast -R20/30/50/45r -Jt35/0.18i -Bag -Dl -A250 -Glightbrown -Wthinnest -Sseashell -png GMT_transverse_merc


.. gmtplot::
    :caption: 全球横向Mercator地图
    :width: 65%

    gmt coast -R0/360/-80/80 -JT330/-45/3.5i -Ba30g -BWSne -Dc -A2000 -Slightblue -G0 -png GMT_TM
