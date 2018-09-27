-Js：立体等角投影
=================

维基链接：https://en.wikipedia.org/wiki/Stereographic_projection

此投影是保角方位投影，主要用于绘制南北极区域。在两极，所有经线都是直线，纬线则是圆弧。

该投影的参数::

    -JS<lon>/<lat>[/<distance>]/<width>
    -Js<lon>/<lat>[/<distance>]/<scale>

- ``<lon>/<lat>`` 投影中心的经纬度
- ``<distance>`` 地图边界到投影中心的角度，默认值为90度
- ``<scale>`` 可以是 ``1:xxxx`` 也可以是 ``<radius>/<latitude>``
  （ ``<radius>`` 是投影中心到纬线 ``<latitude>`` 在图上的距离），
  还可以是 ``<slat>/1:xxxx`` （指定在标准纬线 ``<slat>`` 处的比例尺）

极区立体地图
------------

下面的示例中，投影中心为北极，地图边界与经线和纬线完全重合：

.. literalinclude:: /scripts/J_stereographic_polar.sh

.. figure:: /images/J_stereographic_polar.*
   :width: 100%
   :align: center

   极区立体保角投影

矩形立体地图
------------

与Lambert方位等面积投影类似，也可以通过指定地图区域左下角和右上角的坐标来绘制
一个矩形区域：

.. literalinclude:: /scripts/J_stereographic_rect.sh

.. figure:: /images/J_stereographic_rect.*
   :width: 100%
   :align: center

   矩形边界下的极区立体保角投影

一般立体地图
------------

.. literalinclude:: /scripts/J_stereographic_general.sh

.. figure:: /images/J_stereographic_general.*
   :width: 100%
   :align: center

   一般立体投影