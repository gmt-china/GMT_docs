:author: 姚家园, 田冬冬, 陈箫翰
:date: 2026-01-03

.. index:: ! grdtrend
.. program:: grdtrend

grdtrend
==========

:官方文档: :doc:`gmt:grdtrend`
:简介: 拟合网格的趋势面并计算残差

**grdtrend** 读取一个二维网格文件，并利用可选权重的最小二乘法对这些数据拟合一个低阶多项式趋势。趋势面由下式定义：

.. math::

    m_1 + m_2x + m_3y + m_4xy + m_5x^2 + m_6y^2 + m_7x^3 + m_8x^2y + m_9xy^2 + m_{10}y^3.

用户必须通过 :option:`-N`\ *n_model* 指定要使用的模型参数数量。
:option:`-N`\ *3* 拟合双线性趋势，:option:`-N`\ *6* 拟合二次曲面，依此类推。在 :option:`-N` 选项后附加 **+r** 执行稳健拟合。
在这种情况下，程序将根据稳健尺度估计迭代地对数据重新加权，以便收敛到一个对离群值不敏感的解。
当需要从具有非零均值的“残差”中分离出“区域”场时（例如区域表面上的局部山脉），这会非常方便。
可以选择拟合仅沿 *x* 或 *y* 轴变化的趋势，在这种情况下，可以选择从 1（常数）到 4（三次）的 *n_model*。

如果数据文件中有设置为 NaN 的值，这些值在拟合期间将被忽略。如果写入输出文件，在相同位置也将包含 NaN。

语法
--------

**gmt grdtrend**
*ingrid*
:option:`-N`\ *n_model*\ [**+r**][**+x**\|\ **y**]
[ :option:`-D`\ *diff.nc* ]
[ :option:`-R`\ *region* ]
[ :option:`-T`\ *trend.nc* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *weight.nc* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

必须选项
--------

.. option:: -N

**-N**\ *n_model*\ [**+r**][**+x**\|\ **y**]
    *n_model* 设置要拟合的最高模型参数的 ID。附加 **+r** 以进行稳健拟合。
    附加 **+x** 或 **+y** 以分别仅拟合依赖于 *x* 项或 *y* 项的模型。
    即 :math:`m_1 + m_2x + m_3x^2 + m_4x^3` 或 :math:`m_1 + m_2y + m_3y^2 + m_4y^3` 。
    请注意，对于一维拟合， *n_model* 取值只能是 1-4，但对于二维曲面拟合，可以是 1-10。

可选选项
--------

.. option:: -D

**-D**\ *diff.nc*
    将残差（输入减去拟合）结果写到网格文件 *diff.nc* 中。

.. include:: explain_-R.rst_

.. option:: -T

**-T**\ *trend.nc*
    将拟合得到的趋势文件写到网格文件 *trend.nc* 中。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *weight.nc*\ [**+s**]
    如果 *weight.nc* 存在，则读取并用于求解加权最小二乘问题 [默认：普通最小二乘拟合]。
    附加 **+s** 以改为读取数据不确定度（ :math:`1 \sigma` ）并按 :math:`1/\sigma^2` 创建权重。
    如果在 :option:`-N` 里选择了稳健拟合选项，稳健拟合中使用的权重将被写入 *weight.nc*。

.. include:: explain_help.rst_

备注
-------

:math:`x` 和 :math:`y` 的范围将被平移并缩放至 [-1, 1]，且基函数由勒让德多项式构建。这些在待求逆矩阵的形式上具有数值优势，并允许获得更精确的解。
**注意**：使用 :option:`-V` 列出的模型参数是勒让德多项式系数。它们在数值上不等同于上文描述的等式中的 :math:`m_j`。
上文的描述是为了让用户能够将 :option:`-N` 与多项式曲面的阶数对应起来。如果需要使用报告的系数来计算趋势，请参阅 :doc:`grdmath`。

示例
----

从夏威夷周边区域的远程网格数据文件 @earth_relief_05m 中移除平面趋势，并将结果写入 hawaii_residual.nc::

    gmt grdtrend @earth_relief_05m -R180/240/10/40 -N3 -Dhawaii_residual.nc

对 hawaii_topo.nc 进行双三次曲面的稳健拟合，将结果写入 hawaii_trend.nc，并将所使用的权重写入 hawaii_weight.nc，同时报告细节::

  gmt grdtrend hawaii_topo.nc -N10+r -Thawaii_trend.nc -Whawaii_weight.nc -V

相关模块
----------------

:doc:`grdfft`,
:doc:`grdfilter`,
:doc:`grdmath`