.. index:: ! grdtrend

grdtrend
==========

:官方文档: :doc:`gmt:grdtrend`
:简介: 拟合网格的趋势面并计算残差

该命令会读取一个2D网格文件，并用最小二乘方法拟合一个低阶多项式趋势面。
多项式趋势面的定义为：

.. math::

    m_1 + m_2x + m_3y + m_4xy + m_5x^2 + m_6y^2 + m_7x^3 + m_8x^2y + m_9xy^2 + m_{10}y^3.

必选选项
--------

``<gridfile>``
    2D网格文件名

``-N<n_model>[+r]``
    指定要拟合的模型。

    ``<n_model>`` 指定要拟合的模型的参数个数。例如 ``-N3`` 表示bilinear趋势，
    ``-N6`` 表示 quadratic趋势面。加上 ``+r`` 表示robust拟合，此时，程序会根据
    robust scale estimate多次迭代，给数据重新赋予权重，以得到一个对outliers
    不敏感的解。

可选选项
--------

``-D<diff.nc>``
    将残差（输入减去拟合）结果写到网格文件中

``-T<trend.nc>``
    将拟合得到的趋势文件写到网格文件 ``<trend.nc>`` 中

``-W<weight.nc>``
    若 ``<weight.nc>`` 存在，则读取该文件，并求解一个有权重的最小二乘问题。
    默认为常规的最小二乘拟合。若 ``-N`` 选项中指定了robust拟合，则robust拟合中
    所使用的权重会写到文件 ``<weight.nc>`` 中。

示例
----

从网格文件中移除线性趋势，并将结果写到残差文件中::

    gmt grdtrend hawaii_topo.nc -N3 -Dhawaii_residual.nc

对网格文件做bicubic面的robust拟合::

    gmt grdtrend hawaii_topo.nc -N10r -Thawaii_trend.nc -Whawaii_weight.nc -V
