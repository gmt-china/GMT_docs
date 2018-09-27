-Jc：Cassini圆柱投影
====================

维基链接：https://en.wikipedia.org/wiki/Cassini_projection

此圆柱投影由César-François Cassini de Thury于1745年在调查法国时提出。
其偶尔也被称为Cassini-Soldner投影，因为后者提供了更加精确的数学分析得到了椭球下的公式。

此投影既不保角也不等面积，而是介于二者之间的一种投影方式。沿着中心经线的畸变最小，
适合绘制南北方向区域范围较大的地图。其中，中心经线、距离中心经线90度的两条经线
以及赤道是直线，其余经线和纬线都是复杂的曲线。

该投影方式的参数为::

    -JC<lon>/<lat>/<width>
    -JC<lon>/<lat>/<scale>

其中， ``<lon>/<lat>`` 为中心的经纬度。


示例如下：

.. literalinclude:: /scripts/J_cassini.sh

.. figure:: /images/J_cassini.*
   :width: 100%
   :align: center

   Cassini投影绘制Sardinia岛