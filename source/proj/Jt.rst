-JT: Transverse Mercator
========================

维基链接：https://en.wikipedia.org/wiki/Transverse_Mercator_projection

Transverse Mercator（横轴 Mercator 投影）由 Johann Heinrich Lambert 于 1772 年提出。
该投影中，圆柱与某条经线相切。
在该经线处无畸变，离中心经线越远畸变越大，距离中心经线 90 度处的经线畸变达到无穷。
中心经线和赤道都是直线，其余经线和纬线则是复杂曲线。

该投影的参数:

**-JT**\ *lon*\ [/*lat*]/*width*
或
**-Jt**\ *lon*\ [/*lat*]/*scale*

- *lon* 中心经线
- *lat* 原点的纬度 [默认为赤道]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

地图缩放因子默认值为 1，可以通过修改参数 :term:`PROJ_SCALE_FACTOR` 以自定义。

.. gmtplot::
    :caption: 矩形横向 Mercator 地图
    :width: 75%

    gmt coast -R20/30/50/45+r -Jt35/0.5c -Bag -Dl -A250 -Glightbrown -Wthinnest -Sseashell -png GMT_transverse_merc

.. gmtplot::
    :caption: 全球横向 Mercator 地图
    :width: 65%

    gmt coast -R0/360/-80/80 -JT330/-45/10c -Ba30g -BWSne -Dc -A2000 -Slightblue -G0 -png GMT_TM
