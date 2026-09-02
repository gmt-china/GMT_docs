.. _grid-registration:

网格配准
========

GMT中的2D网格文件，在确定了网格范围和网格间隔后，网格线会出现在
:math:`x = x_{min}, x_{min} + x_{inc}, x_{min} + 2 \cdot x_{inc}, \ldots, x_{max}`
和 :math:`y = y_{min}, y_{min} + y_{inc}, y_{min} + 2 \cdot y_{inc}, \ldots, y_{max}` 处。
而节点的位置有两种选择，即网格线配准（gridline registration）和像素配准（pixel registration）。
GMT默认使用的是网格线配准方式。

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_registration.png
   :width: 75%
   :align: center

   GMT网格配准方式

   （左）网格线配准；（右）像素配准。

.. note::

   大多数原始观测数据都采样网格线配准方式，而有时经过处理的数据会以像素配准
   方式发布。尽管两种配准方式可以互相转换，但转换过程中会降低Nyquist采样率，
   压制一些高频信息。因而如果你可以控制，应尽量避免配准转换。

网格配准方式
------------

网格线配准
~~~~~~~~~~

在网格线配准方式下，节点（图中黑色圆圈）中心位于网格线的交叉点处，节点的值代表
了长宽为 :math:`x_{inc} \cdot y_{inc}` 的单元（图中红色区域）内的平均值。
这种情况下，节点数目与网格范围和间隔的关系为：

.. math::

   \begin{array}{ccl}
   nx & =  &       (x_{max} - x_{min}) / x_{inc} + 1       \\
   ny & =  &       (y_{max} - y_{min}) / y_{inc} + 1
   \end{array}

左图中nx=ny=4。

像素配准
~~~~~~~~

在像素配准方式下，节点（图中黑色圆圈）位于网格单元的中心，即网格点之间的区域，
节点的值代表了每个单元（图中红色区域）内的平均值。在这种情况下，节点数目与
网格范围和间隔的关系为：

.. math::

   \begin{array}{ccl}
   nx & =  &       (x_{max} - x_{min}) / x_{inc}   \\
   ny & =  &       (y_{max} - y_{min}) / y_{inc}
   \end{array}

因而，对于相同的网格区域和网格间隔而言，像素配准比网格线配准要少一列和一行数据。
右图中nx=ny=3。

配准方式转换
------------

GMT提供了多种方式实现像素配准与网格配准的互相转换。

一种是使用 :doc:`/module/grdedit` **-T** 选项将网格区域调整半个网格间隔并修改
配准方式，该方法不改变原有数据点，但改变了网格区域。

另一种方式是使用 :doc:`gmt:grdsample` **-T** 对原始数据做重采样。这种方法保留了
网格的区域范围，但在重采样时会丢失数据中的高频信息。

下图展示了为何在重采样过程中会丢失高频信息。图a中展示了一个沿着X轴的剖面。
粗黑线为Nyquist频率下的X分量，在每个离散网格点处的值用红色圆圈表示。
为了对配准方式进行转换，需要在相隔的网格节点中间（即红色三角形）进行重采样。
显然，红色三角形的值始终为0，因而Nyquist频率所对应的高频信息在重采样的过程中
丢失了。而对于低频信息而言（图中细线），蓝色圆圈为原始数据，蓝色三角为重采样时的
采样点，因而低频信息得到了有效保留。图b给出了将像素配准转换为网格配准时重采样的
转换函数，其显示了在重采样过程中，低频部分会保留，而高频部分振幅会被衰减。

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_grid2pix.png
   :width: 75%
   :align: center
