三种距离计算方式
================

在计算地球或其它星体上任意两点间的距离时，GMT 提供了三种不同的计算方式。
这三种方式在精度和效率上各有权衡，用户可以根据自己的需求选择适合的距离计算方式。

Flat Earth距离
--------------

地球上任意两点 A 和 B 的 Flat Earth 距离计算公式：

.. math::

   d_f = R \sqrt{(\theta_A - \theta_B)^2 + \cos \left [ \frac{\theta_A +
   \theta_B}{2} \right ] \Delta \lambda^2}

其中 R 是地球平均半径（由参数 :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 控制），
:math:`\theta` 是纬度，
:math:`\Delta \lambda = \lambda_A - \lambda_B` 是经度差。
式中地理坐标的单位均是弧度，且需要考虑到跨越经度的周期性问题。

该方法的特点是计算速度快但精度不高，适用于纬度相差不大且对计算效率要求比较高的情况。

可以通过在距离量前加上前缀 ``-`` 指定使用该方法计算两点间的距离。对于某些只需要
指定距离单位而不需要指定具体距离值的情况下，则可以在距离单位前加上前缀 ``-``
表示该距离用 Flat Earth 方法计算。比如，\ ``-S-50M`` 表示设定搜索半径为50海里，
其中距离用 Flat Earth 方法计算。

大圆路径距离
------------

该方法将地球近似为一个半径为R的球，地球上任意两点 A 和 B 的大圆路径距离可以用
`Haversine 公式 <https://en.wikipedia.org/wiki/Haversine_formula>`_ 计算：

.. math::

   d_g = 2R \sin^{-1}  {\sqrt{\sin^2\frac{\theta_A - \theta_B}{2} + \cos
   \theta_A \cos \theta_B \sin^2 \frac{\lambda_A - \lambda_B}{2}} }

该方法是 GMT 默认使用的距离计算方法，适用于大多数情况。
比如，\ ``-S5000f`` 表示距离为 5000 英尺。

有两个 GMT 参数可以控制大圆路径距离的计算细节，分别是：

- :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 地球平均半径
- :ref:`PROJ_AUX_LATITUDE <PROJ_AUX_LATITUDE>` 指定将大地纬度转换为多个适合球状
  近似的辅助纬度中的其中一个

需要注意，这两个选项仅当 :ref:`PROJ_ELLIPSOID <PROJ_ELLIPSOID>` 不为 ``sphere`` 时才有效。

测地距离
--------

地球上两点间的精确距离可以用 Vincenty (1975) 的完全椭球公式计算。
该方法计算得到的距离精度最高精确到 0.5 毫米，同时也是计算速度的最慢的方式。

可以通过在距离或距离单位前加上前缀 ``+`` 来指定用该方法计算距离。
比如，\ ``-S+20k`` 表示用该方法计算的20千米的距离。

除了 Vincenty 完全椭球公式外，还可以将参数 :ref:`PROJ_GEODESIC <PROJ_GEODESIC>`
设置成 ``Rudoe`` （GMT4所使用的计算公式）或 ``Andoyer`` （近似公式，精确到10米量级）
以使用不同的计算公式。

总结
----

GMT 在计算距离时有三种算法：FLAT Earth距离、大圆路径距离和测地距离。
三种方法的计算精度由低到高，计算速度由高到低。

对于一个距离量，比如 ``40k``\ ，默认使用大圆弧距离，可以使用 ``-40k``
表示 FLAT Earth 距离，\ ``+40k`` 表示测地距离。
