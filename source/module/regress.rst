:author: 周茂, 陈箫翰，王亮
:date: 2026-02-07

.. index:: ! regress
.. program:: regress

regress
==========

:官方文档: :doc:`gmt:gmtregress`
:简介: 一维数据线性回归

**regress** 读取一个或多个表数据（也可从标准输入读取），确定每个分段最佳的线性[加权]
回归模型 :math:`y(x) = a + b x` 。用户可自己指定输出哪些数据和模型。默认情况下，将
所有的输入数据作为一个整体来确定模型，但也可将数据分为等间距的数据段，在每段分别确定
模型。除了确定最贴近的模型外，该模块还可以输出所有可能的不同斜率的回归模型，这在分析
居于很多离群数据时非常有用。

.. note::

    如果用户需要对 x 和 y 坐标的对数结果做拟合，可以使用 :option:`-i`\ *flags* 选项在读数据后
    将其转换为对数坐标

语法
----

**gmt regress**
[ *table* ]
[ :option:`-A`\ [*min*\ /*max*\ /*inc*][**+f**\ [**n**\|\ **p**]] ]
[ :option:`-C`\ *level* ]
[ :option:`-E`\ **x**\|\ **y**\|\ **o**\|\ **r** ]
[ :option:`-F`\ *flags* ]
[ :option:`-N`\ **1**\|\ **2**\|\ **r**\|\ **w** ]
[ :option:`-S`\ [**r**] ]
[ :option:`-T`\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ :option:`-T`\ *file*\|\ *list* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**w**]\ [**x**]\ [**y**]\ [**r**] ]
[ :option:`-Z`\ [**+**\|\ **-**]\ *limit* ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_intables.rst_
..

    前两列为分别为 *x* 和 *y*。在设置 :option:`-W` 和 :option:`-E` 时，需要另外的 1-3
    列作为数据的误差估计，或他们之间的相关系数（见 :option:`-W`）。

可选选项
--------

.. option:: -A

**-A**\ [*min*\ /*max*\ /*inc*][**+f**\ [**n**\|\ **p**]]

    线性回归是找到使拟合误差（misfit）最小的回归参数（斜率和截距）。

    使用本选项后，会给出一系列不同斜率的回归直线进行系统分析，或将最佳拟合限制在指定的斜率范围内。

    当给出 *min/max/inc* 时，程序会在指定的斜率角度范围内进行扫描：

    - ``min`` ：最小斜率角度（单位：度）
    - ``max`` ：最大斜率角度（单位：度）
    - ``inc`` ：角度步长（单位：度）

    例如 ``-A-90/90/1`` 表示从 −90° 到 +90°，每隔 1° 计算一次回归。

    在扫描模式下，程序并不是只寻找一条最佳直线，而是对**每一个给定的斜率角度**：

    - 根据回归类型参数 ``-E``
    - 根据误差范数参数 ``-N``

    计算该斜率条件下的**最佳截距**（即在斜率固定时，使误差最小的直线位置）。

    对于每个数据段，程序会输出随角度变化的一系列结果，包括：

    - 角度（angle）
    - 拟合误差（E）
    - 斜率（slope）
    - 截距（intercept）

    在所扫描的角度范围内，误差最小的那组模型参数，
    会被写入数据段头部，并在详细输出模式 ``-Vi`` 下报告。

    除了用于“扫描多条直线”外，本选项还可用于**限制最佳拟合的斜率范围**。

    默认情况下，最佳拟合会在所有可能斜率中搜索。
    若添加 ``+f``（``-N2`` 情况除外），则程序只会在当前设定的角度范围内寻找误差最小的回归直线。

    快捷方式如下：

    - ``+fn`` ：只允许在负斜率范围内寻找最佳回归
    - ``+fp`` ：只允许在正斜率范围内寻找最佳回归

    .. figure:: https://docs.generic-mapping-tools.org/6.6/_images/GMT_slopes.png
        :width: 500 px
        :align: center

        扫描斜率 :option:`-A` 以观察使用 LMS ( :option:`-N`\ **r** ) 准则的完全正交回归的不拟合度量 (misfit) 随直线角度的变化情况。这里我们可以看到，最佳解对应的直线角度为 -78.3 度，但在 78.6 度处存在另一个几乎同样好的局部极小值。

.. option:: -C

**-C**\ *level*
    设置用于回归置信带 (confidence bands) 可选计算的置信水平（以 % 为单位）[默认为 95]。该选项仅在 :option:`-F` 包含输出列 **c** 时使用。

.. option:: -E

**-Ex**\|\ **y**\|\ **o**\|\ **r**

    所有的线性回归都是找到拟合误差（misfit）最小时的回归参数（斜率和截距）。
    拟合误差是用各实测数据点的残差（residual）计算得到的。
    本选项设定如何计算残差，可从以下选项中选择：

    - **x** ：拟合误差是实际数据点与拟合直线的水平距离。
    - **y** ：拟合误差是实际数据点与拟合直线的竖直距离。 [默认]。
    - **o** ：拟合误差是实际数据点与拟合直线的垂直距离。
    - **r** ：拟合误差是实际数据点与拟合直线的水平距离和竖直距离的乘积。

    在教材中学习到的线性回归是**y**，也就是本选项的默认值。
    教材中的线性回归默认只有因变量才有误差，所以设定拟合误差为实际数据点与拟合直线的竖直距离。
    如果数据点的自变量存在误差，而因变量不存在误差，则应选择**x**。
    **x**和**y**互为反函数的关系。
    **o**和**r**适用于自变量和因变量都有误差的情形。
    二者的区别是：在自变量和因变量中有一个的误差为0时，**r**的残差会为0，而**o**不会。

    .. figure:: https://docs.generic-mapping-tools.org/6.6/_images/GMT_misfit.png
        :width: 500 px
        :align: center

        四种残差类型。对于 k = x, y 或 o，会最小化 :math:`e_k` 长度的平方和。对于 :option:`-E`\ **r**，则最小化绿色区域的面积之和。

.. option:: -F

**-F**\ *flags*
    选择输出数据的列的组合，输出顺序将与指定的顺序一致。可从以下选项中选择：

    - **x** ：观测值 *x*。
    - **y** ：观测值 *y*。
    - **m** ：模型预测值。
    - **r** ：残差（残差 = 数据减去模型）。
    - **c** ：回归的对称置信区间，参见 :option:`-C` 以指定置信水平。
    - **z** ：标准化残差或所谓的 *z 分数* (*z-scores*)。
    - **w** ：离群值权重（0 或 1）。对于 :option:`-N`\ **w**，这些是重新加权最小二乘法 (Reweighted Least Squares) 的权重。

    默认值为 [**xymrczw**]。

    使用 **-Fp** 会输出包含 12 个模型参数的单条记录::

        npoints xmean ymean angle misfit slope intercept sigma_slope sigma_intercept r R n_effective

    **注意**： *R* 只能在选择 :option:`-E`\ **y** 时设置。

.. option:: -N

**-N1**\|\ **2**\|\ **r**\|\ **w**
    选择计算拟合误差的方法。
    所有的线性回归都是找到拟合误差（misfit）最小时的回归参数（斜率和截距）。
    拟合误差是用各实测数据点的残差（residual）计算得到的。
    本选项设置使用残差计算拟合误差的方法：

    - **1** ： 各数据点的残差的绝对值的和，即残差的:math:`L_1` 范数。
    - **2** ：各数据点的残差的平方的和，即残差的:math:`L_2` 范数的平方（Ordinary Least Squares Regression，简称OLS，就是最小二乘法） 。[默认]。
    - **r** ：LMS，各数据点的残差的平方的中位数（Least Median of Squares Regression，简称LMS）。
    - **w** ：通过LMS识别异常值并移除后的残差的平方和的平均值（Reweighted Least Squares Regression，简称RLS）。

    一般的线性回归使用的是最小二乘法，即本选项的默认值。
    LMS 在处理离群值时更为稳健。
    RLS 是先进行 LMS 回归，用其识别数据中的离群值并分配零权重，然后使用最小二乘法重新进行回归。

.. option:: -S

**-S**\ [**r**]
    限制输出哪些记录。默认情况下，所有数据记录都将按照 :option:`-F` 指定的格式输出。使用本选项排除被回归算法识别为离群值的数据点。
    使用 **-Sr** 来反转此行为，仅输出离群值记录。

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ **-T**\ *file*\|\ *list*
    在参数指定的等间距点处评估最佳拟合回归模型。如果仅给出了 :option:`-T`\ *inc*，将把 *min* 和 *max* 重置为每个分段中 *x* 的极值。
    若要完全跳过模型评估，使用 :option:`-T`\ 0。详细请参见 :doc:`/array` 。

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**w**]\ [**x**]\ [**y**]\ [**r**]
    指定加权回归以及将要提供的权重类型。

    - 如果提供了 *x* 观测值的 1-:math:`\sigma` 不确定度，请附加 **x** 。
    - 如果提供了 *y* 的 1-:math:`\sigma` 不确定度，请附加 **y** 。
    - 如果提供了 *x* 和 *y* 观测值之间的相关性，请附加 **r**。这些列在输入中出现的顺序应紧随必选的 *x* 和 *y* 列之后。

    同时给出 **x** 和 **y** （以及可选的 **r** ）意味着进行正交回归。单独给出 **x** 需要配合使用 :option:`-E`\ **x**，单独给出 **y** 需要配合使用 :option:`-E`\ **y** 。

    通过 :math:`w = 1/\sigma` 的关系将 *x* 和 *y* 的不确定度转换为回归权重 *w* 。使用 **-Ww** 可以把输入列解释为预先计算好的权重。
    **注意** ：相对于回归线的残差将根据给定的权重进行缩放。大多数范数随后会对此加权残差进行平方（ :option:`-N`\ **1** 是唯一的例外）。

.. option:: -Z

**-Z**\ [±]\ *limit*
    更改离群值检测的阈值：当使用 :option:`-N`\ **w** 时，残差 z 分数(z-scores)超过此 *limit* [默认 ±2.5] 的点将被标记为离群值。
    若要仅将负或正的 z 分数视为可能的离群值，请指定带符号的 *limit* 。

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

注意事项
--------

输出的分段头 (segment header) 将包含我们为每个分段计算的各种统计数据。
其顺序依次为： *N* （点数）、 *x0* （加权平均值 x）、 *y0* （加权平均值 y）、 *angle* （直线角度）、 *E* （不拟合度量）、 *slope* （斜率）、 *intercept* （截距）、 *sigma_slope* 以及 *sigma_intercept* 。
对于标准回归 ( :option:`-E`\ **y** )，还会报告皮尔逊相关系数 *r* 和判定系数 *R* 。最后以有效测量数 :math:`n_{eff}` 结束。

对于加权数据，在计算需要最小化的平方回归不拟合度量 :option:`-N`\ **2** 时，使用：

.. math::

    E_2(\nu) = \frac{\sum_{i=1}^n w_i e_i^2}{\sum_{i=1}^n w_i} \frac{n_{eff}}{n_{eff}-2},

其中有效测量数由下式给出：

.. math::

    n_{eff} = \frac{\left (\sum_{i=1}^n w_i\right )^2}{\sum_{i=1}^n w_i^2}.

因此 :math:`\nu = n_{eff} - 2` 是有效自由度。

对于涉及除直线拟合之外更通用的线性模型回归，请参阅 :doc:`math` **-A** 以及 **LSQFIT** 或 **SVDFIT** 算子。

示例
----

返回通过远程文件 hertzsprung-russell.txt 中数据的最佳拟合正交回归线坐标::

    gmt regress @hertzsprung-russell.txt -Eo -Fxm

对 points.txt 中的 *x-y* 数据进行标准最小二乘回归，并返回 x、y 以及带有 99% 置信区间的模型预测值::

    gmt regress points.txt -Fxymc -C99 > points_regressed.txt

若只想获取上述回归的斜率::

    slope=`gmt regress points.txt -Fp -o5`

对数据 rough.txt 进行重新加权最小二乘回归，并返回 x、y、模型预测值以及 RLS 权重::

    gmt regress rough.txt -Fxymw > points_regressed.txt

对数据 crazy.txt 进行正交最小二乘回归，但先对 x 和 y 取对数，然后返回 x、y、模型预测值和标准化残差 (z-scores)::

    gmt regress crazy.txt -Eo -Fxymz -i0-1l > points_regressed.txt

对于同一文件，检查正交 LMS 不拟合度量在 0 到 90 度之间（步长 0.2 度）如何随角度变化::

    gmt regress points.txt -A0/90/0.2 -Eo -Nr > points_analysis.txt

强制正交 LMS 选择具有正斜率的最佳解::

    gmt regress points.txt -A+fp -Eo -Nr > best_pos_slope.txt

参考文献
--------

Bevington, P. R., 1969, *Data reduction and error analysis for the physical sciences*,
336 pp., McGraw-Hill, New York.

Draper, N. R., and H. Smith, 1998, *Applied regression analysis*, 3rd ed., 736 pp.,
John Wiley and Sons, New York.

Rousseeuw, P. J., and A. M. Leroy, 1987, *Robust regression and outlier detection*,
329 pp., John Wiley and Sons, New York.

York, D., N. M. Evensen, M. L. Martinez, and J. De Basebe Delgado, 2004, Unified
equations for the slope, intercept, and standard errors of the best straight line,
*Am. J. Phys.*, 72(3), 367-375.

相关模块
--------

:doc:`math`,
:doc:`trend1d`,
:doc:`trend2d`
