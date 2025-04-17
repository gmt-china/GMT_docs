-Js：立体等角投影
=================

维基链接：https://en.wikipedia.org/wiki/Stereographic_projection

此投影是保角方位投影，主要用于绘制南北极区域。在两极，所有经线都是直线，纬线则是圆弧。

该投影的参数：

**-JS**\ *lon*/*lat*\ [/*distance*]/*width*
或
**-Js**\ *lon*/*lat*\ [/*distance*]/*scale*

- *lon*/*lat* 投影中心的经纬度
- *distance* 地图边界到投影中心的角度，默认值为90度
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*\ ）

默认情况下使用的地图比例因子为0.996。尽管你可以通过 :term:`PROJ_SCALE_FACTOR` 修改
地图比例因子，然而，当标准纬线被指定后，该比例因子则会被自动计算。

极区立体地图
------------

下面的示例中，投影中心为北极，地图边界与经线和纬线完全重合。

.. gmtplot::
    :caption: 极区立体保角投影
    :width: 85%

    gmt coast -R-30/30/60/72 -Js0/90/12c/60 -B10g -Dl -A250 -Groyalblue -Sseashell -png GMT_stereographic_polar

矩形立体地图
------------

与Lambert方位等面积投影类似，也可以通过指定地图区域左下角和右上角的坐标来绘制一个矩形区域。

.. gmtplot::
    :caption: 矩形边界下的极区立体保角投影
    :width: 75%

    gmt begin GMT_stereographic_rect pdf,png
    gmt set MAP_ANNOT_OBLIQUE lon_horizontal,lat_horizontal,tick_extend,tick_normal
    gmt coast -R-25/59/70/72+r -JS10/90/11c -B20g -Dl -A250 -Gdarkbrown -Wthinnest -Slightgray
    gmt end

一般立体地图
------------

.. gmtplot::
    :caption: 一般立体投影
    :width: 75%

    gmt begin GMT_stereographic_general pdf,png
    gmt set MAP_ANNOT_OBLIQUE separate
    gmt coast -R100/-42/160/-8+r -JS130/-30/12c -Bag -Dl -A500 -Ggreen -Slightblue -Wthinnest
    gmt end
