-JCyl_stere: Cylindrical stereographic
======================================

维基链接：https://en.wikipedia.org/wiki/Gall_stereographic_projection

Cylindrical stereographic（圆柱立体投影）不像其它的圆柱投影那样令人关注，
但由于其相对简单且能够克服其它圆柱投影的缺点（比如高纬度的畸变），故而仍然被使用。
立体投影是透视投影，将整个球沿着赤道上的对跖点投影到一个圆柱上。
该圆柱于两条距赤道等间距的标准纬线处穿过球体。

该投影的参数为：

**-JCyl_stere**/[*lon*\ [/*lat*]]/*width*
或
**-Jcyl_stere**/[*lon*\ [/*lat*]]/*scale*

- *lon* 中心经线 [默认为绘图区域的中心经线]
- *lat* 标准纬线 [默认是赤道。若使用，则必须指定中心经线]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

一些比较流行的标准纬线的选择如下：

+---------------------------------------------------------+-------------+
+=========================================================+=============+
| Miller's modified Gall                                  | 66.159467°  |
+---------------------------------------------------------+-------------+
| Kamenetskiy's First                                     | 55°         |
+---------------------------------------------------------+-------------+
| Gall's stereographic                                    | 45°         |
+---------------------------------------------------------+-------------+
| Bolshoi Sovietskii Atlas Mira or Kamenetskiy's Second   | 30°         |
+---------------------------------------------------------+-------------+
| Braun's cylindrical                                     | 0°          |
+---------------------------------------------------------+-------------+

.. gmtplot::
    :caption: 使用 Gall 立体投影绘制世界地图
    :width: 85%

    gmt begin GMT_gall_stereo pdf,png
    gmt set FORMAT_GEO_MAP dddA
    gmt coast -R-180/180/-60/80 -JCyl_stere/0/45/12c -Bxa60f30g30 -Bya30g30 -A5000 -Wblack -Gseashell4 -Santiquewhite1
    gmt end
