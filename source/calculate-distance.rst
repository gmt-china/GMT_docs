三种距离计算方式
================

在计算地球任意两点间的距离时，GMT提供了三种不同的计算方式。这三种方式在精度和效率上各有权衡，用户可以根据自己的需求选择适合的距离计算方式。

Flat Earth距离
--------------

地球上任意两点A和B的Flat Earth距离计算公式：

.. math::

     d_f = R \sqrt{(\theta_A - \theta_B)^2 + \cos \left [ \frac{\theta_A +
     \theta_B}{2} \right ] \Delta \lambda^2}, \label{eq:flatearth}

其中R是地球平均半径（由参数 :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 控制）， :math:`\theta` 是纬度， :math:`\Delta \lambda = \lambda_A - \lambda_B` 是经度差。式中地理坐标的单位均是弧度。

该方法的特点计算速度快，但经度不高，适用于纬度相差不大且对计算效率要求比较高的情况。

可以通过在距离量前加上前缀 ``-`` 指定使用该方法计算两点间的距离。某些情况下，只需要指定距离的单位而不需要指定具体的距离值，则可以在距离单位前加上前缀 ``-`` 表示该距离用Flat Earth方法计算。

比如， ``-S-50M`` 表示设定搜索半径为50海里，其中距离用Flat Earth方法计算。

大圆弧距离
----------

地球上任意两点A和B的大圆弧距离可以用Haversine公式计算：

.. math::

     d_g = 2R \sin^{-1}  {\sqrt{\sin^2\frac{\theta_A - \theta_B}{2} + \cos
     \theta_A \cos \theta_B \sin^2 \frac{\lambda_A - \lambda_B}{2}} },
     \label{eq:greatcircle}

该方法是GMT默认使用的计算距离方法，适用于大多数情况。该方法将地球近似为一个半径为R的球，

有两个GMT参数可以控制大圆弧距离的计算： :ref:`PROJ_MEAN_RADIUS <PROJ_MEAN_RADIUS>` 和 :ref:`PROJ_AUX_LATITUDE <PROJ_AUX_LATITUDE>` ，参数的具体含义见相关页面中的说明。

大地测量距离
------------

地球上两点间的距离用Vincenty(1975)的完全椭球公式计算。该方法计算得到的距离精度最高，精确到精确到0.5毫米，同时也是计算速度的最慢的方式。

可以通过在距离或距离单位前加上前缀 ``+`` 来指定用该方法计算距离。比如， ``-S+20k`` 表示用该方法计算的20千米的距离。

除了Vincenty完全椭球公式外，还可以将参数 :ref:`PROJ_GEODESIC <PROJ_GEODESIC>` 设置成 ``Rudoe`` （GMT4所使用的计算公式）或 ``Andoyer`` （近似公式，精确到10米量级）以使用不同的计算公式。

总结
----

GMT在计算距离时有三种算法：FLAT Earth距离、大圆弧距离和大地测量距离。三种方法的计算精度由低到高，计算速度由高到低。

对于一个距离量，比如 ``40k`` ，默认使用大圆弧距离，可以使用 ``-40k`` 表示FLAT Earth距离， ``+40k`` 表示大地测量距离。
