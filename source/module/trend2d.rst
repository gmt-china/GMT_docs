:author: 周茂, 陈箫翰
:date: 2026-01-13

.. index:: ! trend2d
.. program:: trend2d

trend2d
=======

:官方文档: :doc:`gmt:trend2d`
:简介: 将多项式拟合到 xyz[w] 数据，得到 z = f(x,y)

**trend2d** 从输入数据的前三列或前四列读取 *x, y, z* [及 *w*] 值，并利用加权最小二乘法 [*Menke*, 1989] 拟合回归模型 *z = f(x,y) + e* 。
该拟合可通过对数据进行迭代重新加权来实现稳健拟合。还可以查找 *f(x,y)* 中能显著减小 *z* 方差的项数。
*n_model* 的取值范围为 [1,10]，用于拟合如下形式的模型（类似于 :doc:`grdtrend` ）：

.. math::

    z(x,y) = m_1 + m_{2}x + m_{3}y + m_{4}xy + m_{5}x^2 + m_{6}y^2 + m_{7}x^3 +
    m_{8}x^{2}y + m_{9}xy^2 + m_{10}y^3.

必须指定 :option:`-N`\ *n_model* ，即所使用的模型参数数量。
:option:`-N`\ 4 拟合双线性趋势， :option:`-N`\ 6 拟合二次曲面，以此类推。
追加 **+r** 以进行稳健拟合。在这种情况下，程序将基于稳健尺度估计迭代地对数据重新加权，以收敛到对异常值不敏感的解。
当从具有非零均值的“残差”中分离出“区域”场时（例如区域表面上的局部山丘），这可能会非常有用。

语法
----

**gmt trend2d**
[ *table* ]
:option:`-F`\ **xyzmrw**\|\ **p**
:option:`-N`\ *n_model*\ [**+r**]
[ :option:`-C`\ *condition\_number* ]
[ :option:`-I`\ [*confidence\_level*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**+s**\|\ **w**] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
----------------

.. include:: explain_intables.rst_

必须选项
--------

.. option:: -F

**-F**\ **xyzmrw**\|\ **p**
    从集合 {**x y z m r w**} 中按任意顺序选择最多六个字母，以创建 ASCII [或二进制] 输出列。
    **x** = *x*, **y** = *y*, **z** = *z*, **m** = 模型 *f(x,y)*, **r** = 残差 *z* - **m**, **w** = 拟合所用的权重。
    
    使用 **-Fp** 仅报告模型参数。

.. option:: -N

**-N**\ *n_model*\ [**+r**]
    指定模型中的项数 *n_model* 。追加 **+r** 以进行稳健拟合。例如，稳健的双线性模型为 **-N**\ *4*\ **+r**。

可选选项
--------

.. option:: -C

**-C**\ *condition_number*
    设置矩阵解的最大允许条件数。
    **trend2d** 拟合一个阻尼最小二乘模型，仅保留部分特征值谱，使得最大特征值与最小特征值的比值为 *condition_number* 。
    [默认值：*condition_number* = 1.0e06]。

.. option:: -I

**-I**\ [*confidence_level*]
    从 1 开始迭代增加模型参数的数量，直到达到 *n_model*，或者模型的方差减小在 *confidence_level* 置信水平下不显著。
    可以仅设置本选项而不附加数字。在这种情况下，拟合将迭代进行，默认置信水平为 0.51。
    或者在 0 到 1 之间设置 *confidence\_level* 。请参阅备注部分。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**+s**\|\ **w**]
    从输入数据第 4 列读取权重，进行加权最小二乘拟合，或在进行迭代稳健拟合时以这些权重开始。
    追加 **+s** 则把读取的数据当作一倍 sigma 的不确定度，并将权重设为 1/*sigma*\ \ :sup:`2` 。
    **+w** 则为直接使用读到的权重。

.. include:: explain_-bi.rst_
..

    默认值为 3 列，如果设置了 :option:`-W` 则为 4 列。

.. include:: explain_-bo.rst_
..

    默认值为 :option:`-F` 指定的 1-6 列。

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

注意事项
--------

*x* 和 *y* 的定义域将被平移并缩放至 [-1, 1]，基函数由切比雪夫（Chebyshev）多项式构建。
在待求逆矩阵的形式上，这些函数具有数值优势，能够得到更精确的解。
在 **trend2d** 的许多应用场景中，用户的数据在 *x-y* 平面上大致沿一条与 *x* 轴有夹角的直线分布（例如沿公路或船迹采集的数据）。
在这种情况下，通过旋转 *x-y* 轴可以提高精度。 **trend2d** 不会寻找此类旋转；相反，它可能会发现矩阵问题存在秩亏（deficient rank）。
然而，解是利用广义逆（generalized inverse）计算的，结果应该仍然没问题。如果 **trend2d** 显示秩亏，用户应通过图形方式检查结果。
**注意**：使用 :option:`-V` 列出的模型参数是切比雪夫系数；它们在数值上并不等同于上述等式中的 *m* 系数。
上述描述是为了让用户能够将 :option:`-N` 与多项式曲面的阶数相匹配。有关切比雪夫多项式的求值，请参阅 :doc:`grdmath`。

**-N**\ *n_model*\ **+r** （稳健）和 :option:`-I` （迭代）选项通过 *F* 检验来评估模型失拟卡方值（Chi-Squared）改善的显著性。
默认置信限制设置为 0.51，可以通过 :option:`-I` 选项进行修改。
用户可能会惊讶地发现，在大多数情况下，通过增加模型项数所实现的方差减小在极高置信度下并不显著。
例如，在 120 个自由度下，卡方值必须降低 26% 或更多，才能在 95% 置信水平下具有显著性。
如果只要卡方值在减小就想继续迭代，请将 *confidence_level* 设置为 0。

为了使稳健（robust）方法生效，需要一个较低的置信限制（例如默认值 0.51）。该方法通过迭代地对数据重新加权来减小异常值的影响。
权重基于中位数绝对偏差（Median Absolute Deviation）和 *Huber* [1964] 提出的公式，当模型残差符合无异常值的正态分布时，其效率为 95%。
这意味着在每次迭代中，异常值的影响仅略微减小。因此，卡方值的减小并不十分显著。
如果该过程需要多次迭代才能成功减弱它们的影响，则 *F* 检验的显著性水平必须保持在较低水平。

.. include:: explain_precision.rst_

示例
----

通过普通最小二乘法从 data.xyz 中移除平面趋势::

    gmt trend2d data.xyz -Fxyr -N3 > detrended_data.xyz

若仅报告这三个系数::

    gmt trend2d data.xyz -Fp -N3 > parameters.txt

若要使上述平面趋势对异常值具有稳健性::

    gmt trend2d data.xzy -Fxyr -N3+r > detrended_data.xyz

若要找出拟合 data.xyz 时，稳健插值模型中（最多 10 项）有多少项是显著的::

    gmt trend2d data.xyz -N10+r -I -V

参考文献
--------

Huber, P. J., 1964, Robust estimation of a location parameter, *Ann.
Math. Stat.*, **35**, 73-101.

Menke, W., 1989, Geophysical Data Analysis: Discrete Inverse Theory,
Revised Edition, Academic Press, San Diego.

相关模块
--------

:doc:`grdmath`,
:doc:`grdtrend`,
:doc:`trend1d`
