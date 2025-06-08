.. index:: ! trend1d
.. include:: common_SYN_OPTs.rst_

trend1d
=======

:贡献者: |周茂|
:最近更新日期: 2023-02-06

----

:官方文档: :doc:`gmt:trend1d`
:简介: 一维数据的多项式/Fourier 拟合

**trend1d** 从输入文件或标准输入中读取 *x, y* [和 *w*]，并使用最小二乘
拟合 *y = f(x) + e* 模型。其中 *f(x)* 可以为多项式或者 Fourier 或者二者
的混合，拟合可以通过对数据的迭代加权逐渐变稳健。

语法
----

**gmt trend1d** [ *table* ]
|-F|\ **xymrw**\|\ **p**\|\ **P**\|\ **c**
|-N|\ *params*
[ |-C|\ *condition_number* ]
[ |-I|\ [*confidence_level*] ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+s**] ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. _-F:

**-F**\ **xymrw**\|\ **p**\|\ **P**\|\ **c**
    指定输出的列。

    - **x** x 坐标
    - **y** y 坐标
    - **m** *f(x)*
    - **r** 残差，y - m
    - **w** 权重

    - **p** 输出多项式模型系数
    - **P** 输出归一化的多项式模型系数
    - **c** 归一化的 Chebyshev 模型系数

.. _-N:

**-N**\ [**p**\|\ **P**\|\ **f**\|\ **F**\|\ **c**\|\ **C**\|\ **s**\|\ **S**\|\ **x**]\ *n*\ [,...][**+l**\ *length*][**+o**\ *origin*][**+r**]
    设置模型的每个组成部分，每个部分通过逗号分隔。其中每部分的格式
    均为 **T**\ *n* 的形式，其中 **T** 为基函数，*n* 为多项式的阶数
    或者 Fourier 序列的项数。**T** 可以为如下选择：

    - **p** 多项式，包含常数项以及各阶项，最大阶数为 *n*
    - **P** 多项式，只包含 *x^n* 项
    - **f** *n* 项 Fourier 序列
    - **c** *n* 项 Cosine 序列
    - **s** *n* 项 Sine 序列
    - **F** 单个 Fourier 分量，阶数为 *n*
    - **C** 单个 Cosine 分量，阶数为 *n*
    - **S** 单个 Sine 分量，阶数为 *n*

    默认情况下，x 原点和周期分别被设置为中间点和数据的整个范围。使用
    **+o**\ *origin* 和 **+l**\ *length* 可修改上述默认值。在获取
    基函数前，首先对 x 进行归一化的处理。
    三角基函数都使用 *x*' = (2*pi*(*x-origin*\ )/*length*) 归一化，
    多项式使用 *x*' = 2*(*x-x_mid*)/(*xmax - xmin*) 归一化。追加
    **+r** 选项可获得更加稳健的解。[默认使用最小二乘拟合]。使用 |-V|
    选项可看到模型的文本展示。

可选选项
--------

.. _-C:

**-C**\ *condition_number*
    设置矩阵解允许的最大条件数。本模块会拟合一个阻尼最小二乘模型，

.. _-I:

**-I**\ [*confidence_level*]


.. _-W:

**-W**\ [**+s**]
    使用该选项可用第三列的权重做加权最小二乘拟合，或者在迭代的稳健
    拟合时使用。**+s** 选项则不使用文件中的权重，而是将其视为一倍
    的 sigma，以 1/*sigma*\ ^2 作为权重

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

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

如果拟合模型中包含了多项式模型，x 将被平移，并缩放到 [-1,1]，如果
多项式包含了所有的阶，基函数为 Chebyshev 多项式。Chebyshev 多项式
在求逆时具有数值优势，可以获得更精确的解。n 阶的 Chebyshev 多项式
在 [-1,1] 上具有 n+1 个极值，所有的极值不是 -1 就是 1。


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
:doc:`gmtregress`,
:doc:`grdtrend`,
:doc:`gmtmath`
