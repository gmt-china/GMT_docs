-Ja：Lambert方位等面积投影
==========================

维基链接: https://en.wikipedia.org/wiki/Lambert_azimuthal_equal-area_projection

该投影由Lambert于1772年发展得到，通常用于绘制大区域地图（例如整个大洲或半球），
该投影是方位等面积投影，但不支持透视。在投影的中心畸变为0，离投影中心距离越远，
畸变越大。该投影的参数为::

    -JA<lon>/<lat>/[<distance>/]<width>
    -Ja<lon>/<lat>/[<distance>/]<scale>

- ``<lon>/<lat>`` 投影中心坐标
- ``<distance>`` 投影中心到边界的角度，默认值为90，即距离投影中心各90度，即整个半球
- ``<width>`` 地图宽度
- ``<scale>`` 地图比例尺 ``1:xxxx`` 或 ``<radius>/<latitude>``
  （\ ``<radius>`` 是纬线 ``<latitude>`` 与投影中心在图上的距离）

矩形地图
--------

对于此投影而言，经线和纬线通常不是直线，因而不适合用于指定地图边界。因而本例中
通过指定区域的左下角（0ºE/40ºS）和右上角（60ºE/10ºS）的坐标来指定区域范围。

.. literalinclude:: /scripts/J_lambert_az_rect.sh

.. figure:: /images/J_lambert_az_rect.*
   :width: 100%
   :align: center

   使用Lambert方位等面积投影绘制矩形地图

半球地图
--------

要绘制半球地图，需要指定区域范围为整个地球。下图绘制了以南美洲为中心的半球图。

.. literalinclude:: /scripts/J_lambert_az_hemi.sh

.. figure:: /images/J_lambert_az_hemi.*
   :width: 60%
   :align: center

   使用Lambert方位等面积投影绘制半球地图

地球物理学中，在绘制震源机制解时，就是将三维的辐射花样信息投影到一个水平面内。
投影的方式有两种：Schmidt网和Wulff网。其中Schmidt网使用的就是Lambert方位
等面积投影（中心经纬度为0/0），Wulff网使用的则是等角度的立体投影。
两种震源球投影方式如下图所示：

.. figure:: /images/J_stereonets.*
   :width: 100%
   :align: center

   震源球投影：等面积的Schmidt网和等角度的Wulff网