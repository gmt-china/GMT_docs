-Jt：横向Mercator投影
=====================

维基链接：https://en.wikipedia.org/wiki/Transverse_Mercator_projection

此投影由Lambert于1772年提出。该投影中，圆柱与某条经线相切。在该经线处无畸变。
离中心经线越远畸变越大，距离中心经线90度处的经线畸变达到无穷。
中心经线和赤道都是直线，其余经线和纬线则是复杂曲线。

该投影的参数::

    -JT<lon>[/<lat>]/<width>
    -Jt<lon>[/<lat>]/<scale>

``<lon>`` 中心经线， ``<lat>`` 原点的纬度，默认值为赤道。

地图缩放因子默认值为1，可以通过修改参数 :ref:`PROJ_SCALE_FACTOR <PROJ_SCALE_FACTOR>` 以实现自定义。

.. literalinclude:: /scripts/J_transverse_merc.sh

.. figure:: /images/J_transverse_merc.*
   :width: 100%
   :align: center

   矩形横向Mercator地图

.. literalinclude:: /scripts/J_TM.sh

.. figure:: /images/J_TM.*
   :width: 100%
   :align: center

   全球横向Mercator地图