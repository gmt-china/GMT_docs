:author: 何星辰, 田冬冬
:date: 2025-10-12

.. index:: ! fzblender
.. program:: fzblender

fzblender
=============

:官方文档: :doc:`gmt:supplements/gsfml/fzblender`
:简介: 生成平滑的加权混合 FZ 轨迹

**fzblender** 是 (Global Seafloor Fabric and Magnetic Lineation Project)
的一部分。(简称 `GSFML <https://www.soest.hawaii.edu/PT/GSFML>`_ )。
它读取由 :doc:`fzanalyzer` 生成的分析文件，并可选择沿轨迹对结果进行滤波。
然后，基于指定的信号代码， **fzblender** 将生成一个最优断裂带（FZ）轨迹，
该轨迹是用户原始数字化轨迹与一个或多个由 :doc:`fzanalyzer`
得到的模型轨迹的加权混合。混合过程依据模型轨迹的质量指标：

* 当质量指标高时，倾向于使用模型轨迹；
* 当质量指标低时，倾向于使用数字化轨迹；
* 中间值则产生加权混合效果。

分析结果通常从 :doc:`fzanalyzer` 生成的文件 *prefix*\_analysis.txt 中读取；
混合结果将写入文件 *prefix*\_blend.txt。如果提供了 :option:`-D` 选项，
中间的滤波分析文件还可以写入 *prefix*\_filtered.txt。

语法
--------

**gmt fzblender**
[ :option:`-D` ]
[ :option:`-E`\ *sfilter* ]
[ :option:`-F`\ *pfilter* ]
[ :option:`-I`\ *FZid* ]
[ :option:`-Q`\ *q_min*/*q_max* ]
[ :option:`-S`\ **b**\|\ **d**\|\ **e**\|\ **t**\|\ **u**\ [*weight*] ]
[ :option:`-T`\ *prefix* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ *acut*/*vcut*/*fcut*/*wcut* ]


可选选项
------------------

.. option:: -D

**-D**
    不删除滤波后的输出文件，而是将其保存为 *prefix*\_filtered.txt。
    [默认情况下，我们会删除这些中间文件]。

.. option:: -E

**-E**\ *sfilter*
    在主滤波完成后应用二次滤波。若先应用稳健滤波移除大尺度异常值，
    可能会在短尺度产生噪声，此时二次滤波会很有用。
    有关滤波器的指定方法，请参见 :option:`-F`。

.. option:: -F

**-F**\ *pfilter*
    设置沿轨迹的主滤波器。可选择卷积或非卷积滤波器。
    附加滤波器指令后跟完整（6-sigma） *宽度*。可用卷积滤波器包括：

    - **b**：Boxcar：所有权重相等。
    - **c**：Cosine Arch：权重沿余弦拱曲线分布。
    - **g**：Gaussian：权重按高斯函数给出。

    非卷积滤波器包括：

    - **m**：中值（Median）：返回中值。
    - **p**：最大似然概率（模式估计器）：返回众数。如果存在多个众数，
        则返回它们的平均值。可在滤波宽度后附加 **+l** 或 **+u**，分别返回最低或最高的众数值。
    - **l**：下限（Lower）：返回所有值的最小值。
    - **L**：正下限（Lower）：仅返回所有正值中的最小值。
    - **u**：上限（Upper）：返回最大值。
    - **U**：负上限（Upper）：仅返回所有负值中的最大值。

    对于 **L** 或 **U**，如果没有数据通过初始符号测试，则滤波器返回 0.0。

.. option:: -I

**-I**\ *FZid*
    默认情况下，会分析所有 FZ 的横剖面。
    你也可以使用 :option:`-I` 指定特定的 *FZid*（第一个 *FZid* 为 0）。

.. option:: -Q

**-Q**\ *q_min*/*q_max*
    设置在混合结果中使用的质量指数范围。质量指数 *q(d)* 在 *q_min* （0 或差）
    到 *q_max* （1 或很好）之间连续变化，沿 FZ 轨迹的距离 *d* 变化。
    分配给模型 FZ 轨迹的质量权重为*w_q(d)* = (*q(d)* - *q_min*) / (*q_max* - *q_min*)，
    若 *w_q(d)* > *q_max* 则 *w_q(d)* = 1，
    若 *w_q(d)* < *q_min* 则 *w_q(d)* = 0。
    可通过 :option:`-Q` 改变此权重分配。分配给数字化 FZ 轨迹的质量权重为
    *w_q(d)* = 1 - mean{模型质量权重}（参见 :option:`-S`）。质量指数的计算请参见 :option:`-Z`。

.. option:: -S

**-Sb**\|\ **d**\|\ **e**\|\ **t**\|\ **u**\ [*weight*]
    指定希望混合的模型和数据轨迹及其相对自定义权重 [默认均为 1]。
    可对每条轨迹重复此选项。如果指定了多条模型轨迹，
    则首先根据其质量指标和权重进行平均，再与数字化轨迹混合（如指定）。
    因此，分配给数字化轨迹的质量指数为 *q_r* = 1 - mean(模型质量指数)。
    最终混合是加权平均，同时考虑质量指数和自定义权重（如指定）。选择以下指令：

    - **b**：最优槽/边缘模型混合的槽位置。
        使用“Atlantic”、“Pacific”和“Compression”风格的综合模型对数据进行最佳拟合。
    - **d**：沿轨迹的经验槽位置。
    - **e**：最优槽/边缘模型混合的最大斜率位置。
    - **t**：仅使用“Atlantic”风格槽模型的最佳拟合。
    - **u**：用户的原始数字化轨迹。

    除了混合后的 FZ 位置，我们还输出 FZ 宽度估计以及 FZ 两侧 1σ 边界轨迹。

.. option:: -T

**-T**\ *prefix*
    设置所有输出文件的文件名前缀 [fztrack]。

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**\ *acut*/*vcut*/*fcut*/*wcut*
    我们将尝试为每个模型分配一个单一质量指数 *Q*，以总结模型拟合的优劣。
    该分配依赖四个需经验确定的阈值：

    - *a_cut*：交叉剖面模型的最小峰谷振幅（单位 Eotvos）[25]
    - *v_cut*：模型提供的最小方差降低（%）[50]
    - *f_cut*：模型计算的最小 F 统计量 [50]
    - *w_cut*：典型 FZ 槽宽（单位 km）[15]

    目前，前三个量用于生成五级质量指数（0-1），如下：

    1. Very Good（非常好）：模型参数均超过阈值
    2. Good（好）：幅度和方差降低超过阈值
    3. Fair（一般）：仅方差降低超过阈值
    4. Poor（差）：仅幅度超过阈值
    5. Bad（差）：未满足任何标准

    我们分别为槽模型和混合模型计算质量指数。对于经验槽模型，
    只估计峰谷振幅 *A* 和槽宽 *W*。这里，将比值 (*A*/*a_cut*) / (*W*/*w_cut*) 的
    反正切（:math:`\tan^{-1}`）缩放至 0-1 范围，并四舍五入到最接近 0.25 的倍数。

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_help.rst_

输出列
--------

**fzblender** 输出 10 列数据，
分别为 *lon, lat, dist, shift, width, qweight, lon_l, lat_l, lon_r, lat_r*。
其中，*lon, lat* 包含沿距离 *dist* 的混合轨迹，*width* 为跨轨宽度，
*shift* 为相对于原点的偏移。混合结果的质量权重为 *qweight*，
最后四列给出了 FZ 左/右边界的坐标。

滤波
--------

滤波总是在 FZ 端点附近的数据上进行。
我们使用 :doc:`filter1d` 的 **-E** 选项，将结果延伸至端点。
由于我们对的数据列可能包含明显的趋势（例如经度随沿线距离的变化），
因此在滤波前会先去除线性趋势，滤波后再恢复趋势。
然而，在解释靠近 FZ 端点的混合结果时应保持谨慎。
你可以通过使用 :option:`-D` 选项保存滤波后的剖面，更直接地检查滤波效果。

注意事项
--------

需要注意的是，在 :option:`-S` 的各指令中，**e** 与众不同，
它反映了基于理论预测的 FZ 位置估计，即 FZ 横切可能对应于 VGG 最陡坡度的位置。
因此，该位置会与槽中心偏移几公里（除非混合主要为 “Atlantic” 风格），
将其与其他指令组合使用通常效果不佳。最好单独使用，并配合滤波。

示例
--------

要生成数字化轨迹、经验槽位置和槽模型位置的加权平均，
并为经验位置赋权 2，模型槽赋权 1，同时读取文件 Pac_analysis.txt，
先应用宽度为 70 km 的中值滤波，再应用 50 km 的高斯滤波，可以使用以下命令::

    gmt fzblender -Su1 -Sd2 -St1 -Fm70 -Eg50 -TPac


要沿 FZ 轨迹生成最大坡度位置的平滑轨迹，对同一文件使用相同滤波器，可运行::

    gmt fzblender -Se -Fm70 -Eg50 -TPac


相关模块
--------

:doc:`fzanalyzer`,
:doc:`fzinformer`,
:doc:`fzmapper`,
:doc:`fzmodeler`,
:doc:`fzprofiler`,
:doc:`filter1d`,
:doc:`mlconverter`

参考文献
--------

Wessel, P., Matthews, K. J., Müller, R. D., Mazzoni,
A., Whittaker, J. M., Myhill, R., Chandler, M. T.,2015,
"Semiautomatic fracture zone tracking", *Geochem. Geophys.
Geosyst.*, 16 (7), 2462–2472.https://doi.org/10.1002/2015GC005853.
