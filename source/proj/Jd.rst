-Jd：等距圆锥投影
=================

维基链接：https://en.wikipedia.org/wiki/Equidistant_conic_projection

等距圆锥投影由希腊哲学家Claudius Ptolemy于公元150年提出。其既不是保角也不是等面积，
二者两种的折衷。在所有经线以及标准纬线上比例尺没有畸变。

该投影的参数为::

    -JD<lon>/<lat>/<lat1>/<lat2>/<width>
    -Jd<lon>/<lat>/<lat1>/<lat2>/<scale>

- ``<lon>/<lat>`` 投影中心位置
- ``<lat1>/<lat2>`` 两条标准纬线

等距圆锥投影常用于绘制小国家的地图集。

.. literalinclude:: /scripts/J_equidistant_conic.sh

.. figure:: /images/J_equidistant_conic.*
   :width: 100%
   :align: center

   等距圆锥地图投影
