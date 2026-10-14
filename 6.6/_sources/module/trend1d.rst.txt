:author: 周茂, 陈箫翰
:date: 2026-01-13

.. index:: ! trend1d
.. program:: trend1d

trend1d
=======

:官方文档: :doc:`gmt:trend1d`
:简介: 为 xy[w] 数据拟合多项式/傅里叶模型 y = f(x)

**trend1d** 从输入文件或标准输入中读取 *x, y* [和 *w*]，并使用最小二乘拟合拟合回归模型 *y = f(x) + e* 。
*f(x)* 的函数形式可以为多项式、傅里叶级数或者二者的混合，拟合可以通过对数据的迭代加权逐渐变稳健。
还可以搜索 *f(x)* 中能显著降低 *y* 的方差的项数。

语法
----

**gmt trend1d**
[ *table* ]
:option:`-F`\ **xymrw**\|\ **p**\|\ **P**\|\ **c**
:option:`-N`\ [**p**\|\ **P**\|\ **f**\|\ **F**\|\ **c**\|\ **C**\|\ **s**\|\ **S**\|\ **x**]\ *n*\ [,...][**+l**\ *length*][**+o**\ *origin*][**+r**]
[ :option:`-C`\ *condition_number* ]
[ :option:`-I`\ [*confidence_level*] ]
[ :option:`-T`\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ :option:`-T`\ *file*\|\ *list* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**+s**] ]
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

**-F**\ **xymrw**\|\ **p**\|\ **P**\|\ **c**
    在 {**x y m r w**} 中按任意顺序指定最多五个字母，以指定输出的列。

    - **x** ：x 坐标
    - **y** ：y 坐标
    - **m** ： *f(x)*
    - **r** ：残差，y - m
    - **w** ：拟合中使用的权重

    **注意**：如果包含 **m** ，则按 **x** 递增顺序对输出进行排序（无论是否选择 **x** ）。

    也可以使用 **-Fp** 输出包含多项式模型系数的记录，或 **-FP** 输出归一化多项式模型系数，或 **-Fc** 输出归一化切比雪夫模型系数。

.. option:: -N

**-N**\ [**p**\|\ **P**\|\ **f**\|\ **F**\|\ **c**\|\ **C**\|\ **s**\|\ **S**\|\ **x**]\ *n*\ [,...][**+l**\ *length*][**+o**\ *origin*][**+r**]
    设置模型的每个组成部分，每个部分通过逗号分隔。其中每部分的格式
    均为 **T**\ *n* 的形式，其中 **T** 为基函数，*n* 为多项式的阶数
    或者 Fourier 序列的项数。**T** 可以为如下选择：

    - **p** ：多项式，包含常数项以及各阶项，最大阶数为 *n*
    - **P** ：多项式，只包含 :math:`x^n` 项
    - **f** ： *n* 项 Fourier 序列
    - **c** ： *n* 项 Cosine 序列
    - **s** ： *n* 项 Sine 序列
    - **F** ：单个 Fourier 分量，阶数为 *n*
    - **C** ：单个 Cosine 分量，阶数为 *n*
    - **S** ：单个 Sine 分量，阶数为 *n*

    默认情况下，x 原点 *origin* 和周期 *length* 分别被设置为中间点和数据的整个范围。使用
    **+o**\ *origin* 和 **+l**\ *length* 可修改上述默认值。在获取
    基函数前，首先对 x 进行归一化的处理。
    三角基函数都使用 :math:`x' = 2\pi(x-\mbox{origin})/\mbox{length}` 归一化，
    多项式使用 :math:`x' = 2(x-\mbox{origin})/\mbox{length}` 归一化。追加
    **+r** 选项可获得更加稳健的解。[默认使用最小二乘拟合]。使用 :option:`-V`
    选项可看到模型的文本展示。

可选选项
--------

.. option:: -C

**-C**\ *condition_number*
    设置矩阵解的最大允许条件数 (condition number)。
    **trend1d** 拟合阻尼最小二乘模型，仅保留特征值谱中最大特征值与最小特征值之比为 *condition_number* 的那部分。
    [默认值：*condition_number* = 1.0e06]

.. option:: -I

**-I**\ [*confidence_level*]
    迭代地增加模型参数的数量，从 1 开始，直到达到 *n_model* 或者模型方差的减小在 *confidence\_level* 水平上不再显著。
    可以仅设置本选项而不附加数字。在这种情况下，拟合将迭代进行，默认置信水平为 0.51。
    或者在 0 到 1 之间设置 *confidence\_level* 。具体请参阅备注部分。
    请注意，模型项是按 :option:`-N` 中给出的顺序添加的，因此应该将最重要的项放在前面。

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ **-T**\ *file*\|\ *list*
    在参数指定的等间距点上对最优拟合回归模型进行求值。
    如果仅给出了 **-T**\ *inc* ，将把 *min* 和 *max* 重置为每个分段的 *x* 值的极值。
    若要完全跳过模型求值，使用 **-T**\ 0。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**+s**]
    从输入数据的第 3 列读取权重，进行加权最小二乘拟合，或者在进行迭代稳健拟合时以这些权重作为起始值。
    附加 **+s** 则把读取的数据当作一倍 sigma 的不确定度，并按照 1/:math:`\sigma^2` 计算权重。

.. include:: explain_-bi.rst_
..

    默认值为 2 列，如果设置了 :option:`-W` 则为 3 列。

.. include:: explain_-bo.rst_
..

    默认值为 :option:`-F` 指定的 1-5 列。

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

.. include:: explain_precision.rst_

注意事项
--------

如果包含了多项式模型，且多项式为全阶（否则仍使用 *x* 的幂），则 *x* 的定义域将被平移并缩放至 [-1, 1]，基函数将采用切比雪夫（Chebyshev）多项式。
在待求逆矩阵的形式上，切比雪夫多项式具有数值优势，能够得到更精确的解。
*n* 阶切比雪夫多项式在 [-1, 1] 内有 *n+1* 个极值点，且在这些点上的值均为 -1 或 +1。
因此，多项式模型系数的大小可以直接进行比较。
**注意**：稳定的模型系数是切比雪夫系数。在 Verbose 模式下也会给出 *a + bx + cxx + ...* 形式的对应多项式系数。
但用户必须意识到，当阶数超过 7 或 8 时，这些系数是不稳定的。更多讨论请参阅《数值算法》（Numerical Recipes）。
有关切比雪夫多项式的求值，请参阅 :doc:`math` 。

:option:`-N`\ ...\ **+r** （稳健）和 :option:`-I` （迭代）选项通过 *F* 检验来评估模型失拟卡方值（Chi-Squared）改善的显著性。
默认置信限制设置为 0.51。可以通过 :option:`-I` 选项进行修改。
用户可能会惊讶地发现，在大多数情况下，通过增加模型项数所实现的方差减小在极高置信度下并不显著。
例如，在 120 个自由度下，卡方值必须降低 26% 或更多，才能在 95% 置信水平下具有显著性。
如果只要卡方值在减小就想继续迭代，请将 *confidence_level* 设置为 0。

为了使稳健（robust）方法生效，需要一个较低的置信限制（例如默认值 0.51）。该方法通过迭代地对数据重新加权来减小异常值的影响。
权重基于中位数绝对偏差（Median Absolute Deviation）和 *Huber* [1964] 提出的公式，当模型残差符合无异常值的正态分布时，其效率为 95%。
这意味着在每次迭代中，异常值的影响仅略微减小。因此，卡方值的减小并不十分显著。如果该过程需要多次迭代才能成功减弱它们的影响，则 *F* 检验的显著性水平必须保持在较低水平。

示例
----

在数据 data.xy 中移去线性趋势::

    gmt trend1d data.xy -Fxr -Np1 > detrended_data.xy

在上述结果中，剔除粗差，获得更加稳健的趋势估计结果::

    gmt trend1d data.xy -Fxr -Np1+r > detrended_data.xy

拟合模型 y(x) = a + bx^2 + c * cos(2*pi*3*(x/l) + d * sin(2*pi*3*(x/l)，
基函数周期设置为 15 ::

    gmt trend1d data.xy -Fxm -NP0,P2,F3+l15 > model.xy

寻找稳健 Fourier 内插中所有显著的项数 ::

    gmt trend1d data.xy -Nf20+r -I -V

参考文献
--------

Huber, P. J., 1964, Robust estimation of a location parameter, *Ann.
Math. Stat.*, **35**, 73-101.

Menke, W., 1989, Geophysical Data Analysis: Discrete Inverse Theory,
Revised Edition, Academic Press, San Diego.

相关模块
--------

:doc:`trend2d`,
:doc:`regress`,
:doc:`grdtrend`,
:doc:`math`
