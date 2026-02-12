-j 选项
=======

**-j** 选项用于控制球面上两点间距离的计算方式。其语法为：

    **-j**\ **e**\|\ **f**\|\ **g**

在计算地球或其它星体上任意两点间的距离时，GMT 提供了三种不同的计算方式：
Flat Earth 距离、大圆路径距离和测地距离。

- **-jg** 将地球当做球体，用大圆路径公式计算球面距离，GMT默认使用此方式
- **-jf** 使用Flat Earth公式计算球面距离
- **-je** 使用测地公式计算球面距离，计算距离时考虑了地球椭率

三种方法的计算精度由低到高，计算速度由高到低。
用户可以根据自己的需求选择适合的距离计算方式。

Flat Earth距离
--------------

地球上任意两点 A 和 B 的 Flat Earth 距离计算公式：

.. math::

   d_f = R \sqrt{(\theta_A - \theta_B)^2 + (\cos \left [ \frac{\theta_A + \theta_B}{2} \right ] \Delta \lambda)^2}

其中 R 是地球平均半径（由参数 :term:`PROJ_MEAN_RADIUS` 控制），
:math:`\theta` 是纬度，
:math:`\Delta \lambda = \lambda_A - \lambda_B` 是经度差。
式中地理坐标的单位均是弧度，且需要考虑到跨越经度的周期性问题。

该方法的特点是计算速度快但精度不高，适用于纬度相差不大且对计算效率要求比较高的情况。

大圆路径距离
------------

该方法将地球近似为一个半径为R的球，地球上任意两点 A 和 B 的大圆路径距离可以用
`Haversine 公式 <https://en.wikipedia.org/wiki/Haversine_formula>`_ 计算：

.. math::

   d_g = 2R \sin^{-1}  {\sqrt{\sin^2\frac{\theta_A - \theta_B}{2} + \cos
   \theta_A \cos \theta_B \sin^2 \frac{\lambda_A - \lambda_B}{2}} }

该方法是 GMT 默认使用的距离计算方法，适用于大多数情况。

有两个 GMT 参数可以控制大圆路径距离的计算细节，分别是：

- :term:`PROJ_MEAN_RADIUS` 地球平均半径
- :term:`PROJ_AUX_LATITUDE` 指定将大地纬度转换为多个适合球状
  近似的辅助纬度中的其中一个

需要注意，这两个选项仅当 :term:`PROJ_ELLIPSOID` 不为 **sphere** 时才有效。

测地距离
--------

地球上两点间的精确距离可以用 Vincenty (1975) 的完全椭球公式计算。
该方法计算得到的距离精度最高精确到 0.5 毫米，同时也是计算速度的最慢的方式。

除了 Vincenty 完全椭球公式外，还可以将参数 :term:`PROJ_GEODESIC`
设置成 **Rudoe** （GMT4所使用的计算公式）或 **Andoyer** （近似公式，精确到10米量级）
以使用不同的计算公式。
