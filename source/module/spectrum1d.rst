:author: 田冬冬, 周茂
:date: 2024-07-03

.. index:: ! spectrum1d
.. program:: spectrum1d
.. include:: common_SYN_OPTs.rst_

spectrum1d
==========

:官方文档: :doc:`gmt:spectrum1d`
:简介: 计算一个时间序列的自功率谱，或两个时间序列的互功率谱

**spectrum1d** 从标准输入流或数据文件中读取一列或两列数据。这些数据被当作是
采样间隔为 ``<dt>`` 的等间隔的时间序列。**spectrum1d** 采用 Welch [1967]方法，即加窗多段
平均周期图法，计算输出自功率或互功率谱密度。其输出的功率谱的标准差采用
Bendat 和 Piersol [1986] 中的算法。

**spectrum1d** 的输出文件有三列::

    f|w   p   e

其中， f 代表频率，w 代表波长，p 代表计算的功率谱密度，e 代表一倍标准差。

**spectrum1d** 的输出文件的文件名是使用统一的前缀 ``name_stem`` 。如果使用了
:option:`-C` 选项，那么将会有 8 个文件输出，否则只生成一个功率谱文件（ ``.xpower`` ）。
这些文件默认是以 ASCII 码格式，除非用 ``-bo`` 选项指定为二进制格式输出。这 8 个
文件介绍如下：

1. ``name_stem.xpower``: X(t) 的功率谱。单位是 ``X*X*dt`` 。
2. ``name_stem.ypower``: Y(t) 的功率谱。单位是 ``Y*Y*dt`` 。
3. ``name_stem.cpower``: X(t) 和 Y(t) 的互功率谱。单位和 ypower 一样。
4. ``name_stem.npower``: 噪声（即两列数组的差）的功率谱。单位和 ypower 一样。
5. ``name_stem.gain``: 增益谱，或传输函数的模。单位是 ``Y/X``
6. ``name_stem.phase``: 相位谱，或传输函数的相位。单位是弧度。
7. ``name_stem.admit``: 导纳（Admittance）谱，或传输函数的实部。单位是 ``Y/X`` 。
8. ``name_stem.coh``: （平方）相干谱，或者线性相关系数（它是频率的函数）。
   无单位，取值范围为 ``[0,1]`` 。信噪比 ``SNR = coh/(1-coh)`` 。当 coh=0.5 时，SNR=1。

除非使用 ``-T`` 选项，否则以上文件会以单个文件单列的形式输出。

语法
----

**gmt spectrum1d** [ *table* ] [ :option:`-S`\ *segment_size* ]
[ :option:`-C`\ [**acgnopxy**] ] [ :option:`-D`\ *dt* ] [ :option:`-L`\ [**h**\|\ **m**] ]
[ :option:`-N`\ [*name_stem*] ] [ :option:`-T` ] [ :option:`-W` ]
[ :option:`-b`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入文件名。它是 ASCII 类型的一列数据或两列数据。如果是一列数据文件，就计算
    自功率谱；如果是两列，就计算互功率谱。若未指定文件名， **spectrum1d** 会从
    标准输入流中读取数据。

.. option:: -S

**-S**\ *segment_size*
    ``segment_size`` 是一个 2 的指数数值，用于控制 Welch 方法中分段平均时的窗口
    长度。它也决定了功率谱密度的最小频率分辨率和最大频率分辨率，即
    ``1.0/(segment_size*dt)`` 和 ``1.0/(2*dt)`` （即 Nyquist 频率）。在功率谱密度
    中的一个标准误差大约为 ``1.0/sqrt(n_data/segment_size)`` ，比如 segment_size=256，
    那么就需要 25600 个数据点去计算一个误差棒的 10%。互功率谱误差棒的计算则需要更多
    数据点，而且是相干性的函数，比较复杂。

可选选项
--------

.. option:: -C

**-C**\ [**acgnopxy**]
    读取输入中的前两列，即 *X*\ (*t*) 和 *Y*\ (*t*) 时间序列。假设 *Y*\ (*t*)
    和 *X*\ (*t*) 分别是一个带有噪声的线性系统的输出和输入。使用最小二乘估计最优
    频率响应函数会将噪声最小化并且相干输出与噪声输出是不相关的。
    本模块默认会输出如下属的全部 8 个文件。使用该选项可以指定输出 8 个文件中的某些文件。
    x=xpower、y=ypower、c=cpower、n=npower、p=phase、a=admit、g=gain、o=coh。

.. option:: -D

**-D**\ *dt*
    设置读入的时间序列的时间采样间隔，默认值是1。

.. option:: -L

**-L**\ [**h**\|\ **m**]
    不去除信号中的线性趋势。默认情况下，在对信号进行变换处理前会先去掉其中的
    线性趋势。 追加 ``m`` 表示去掉数据的均值， ``h`` 表示去掉数据的中值。

.. option:: -N

**-N**\ [*name\_stem*]
    输出文件名的前缀，默认为 ``spectrum`` 。若不使用此选项，则输出的 9 个文件会
    合到一个文件里。

.. option:: -T

**-T**
    不让单个分量的结果输出到标准输出，对 :option:`-C` 设置的输出分量分别输出到单个
    指定文件中

.. option:: -W

**-W**
    输出文件中第一列是波长而不是频率。默认输出时第一列是频率。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-s.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
----

假设 ``data.g`` 是重力数据，单位为 mGal，空间采样间隔为 1.5 km。如下命令会输出
数据的功率谱到文件 :file:`data.xpower`，单位为 mGal^2 km 表示::

    gmt spectrum1d data.g -S256 -D1.5 -Ndata

假设除了有重力数据 ``data.g`` 之外，还有在相同地点测得的地形数据 ``data.t`` ，
单位为 m。计算二者之间的传输函数，即 ``data.t`` 作为输入， 经过传输函数得到了
``data.g`` 为输出::

    paste data.t data.g | gmt spectrum1d -S256 -D1.5 -Ndata -C > results.txt

教程
----

**spectrum1d** 输出的单位为功率谱密度的单位，因此，要以数据的平方的量纲作为单位，
就必须除以采样间隔 `dt`。（如果想对谱做归一化，则可从 Parseval 定理中得到缩放因子，
Parseval 定理为：输入数据的平方和等于 **spectrum1d** 输出的平方和。）

假定存在一个数据， `X(t)` ，计算其离散傅立叶变换（DFT），结果为 `X(f)` ，将其与自身
的复数共轭相乘，即得到周期图 ::

    P_raw(f) = X(f) * X\'(f)


实际中，P_raw 的噪声会非常地大，因此需要平滑或者平均等方法得到一个实用的估计
P_useful(f)。除了 Welch 方法，另外还有多种计算功率谱密度的方法:

    - 计算 x(t) 的自协方差函数，然后平滑，做 taper，然后计算自协方差函数的傅立叶变换。

    - 对 x(t) 的自相关函数进行参数拟合，得到模型后计算该模型的谱

    - "maxumum entropy", "Berg", "Box-Jenkins", "ARMA" 或者 "ARIMA" 等方法

Welch 方法是一种久经考验的方法。在 Welch 方法中，用户需指定一个数据长度 N，这样
对数据进行分段，以长度为 N 的数据段分别计算谱。谱的频率采样为 *k* /(*N* \* *delta_t*)，
其中 *k* 为整数，采样个数为 *N*（由于谱结果是偶函数，因此计算结果存在一半的冗余）。
如果原始数据 x(t) 的长度为 *M*，则 P_useful 的方差会以 *N/M* 的比例减小。因此，
用户可选择远小于 *M* 的 *N* 值以得到较低方差的 P_useful。但这种做法在不同方面
需要互相妥协。

Welch 方法中同时对每段长度为 *N* 的数据的功率谱估计中使用了 Hann 窗，这也会减小
谱估计的方差。这种做法同时会削弱功率谱的旁瓣泄漏并使谱估计更加平滑。但这样会使
每个估计的带宽轻微地增大，因为在 *k* 位置的频率采样会与 *k+1* 位置的估计存在较小
的相关（实际上，对周期图方法的结果做平滑也会导致类似的效果）。

最后，Welch 方法同样使用数据重叠处理。由于 Hann 窗是一种两端尖灭的窗，因此对长度
*N* 的窗来说，窗中间位置的数据对结果贡献最大。因此，在下一段谱估计中，只将
窗口移动 *N/2* 长度，这样可以保证在上一段数据中贡献较小的两端数据在当前段估计中
有较大的贡献。这样会进一步平滑结果并保证每个数据都能对最后的结果有近似相等的贡献。

Welch 方法被广泛使用并研究，它的结果非常可靠且其统计属性也被较好地研究。因此，它
被类似 "Random Data: Analysis and Measurement Procedures" [*Bendat and Piersol*, 1986]
等教科书中推荐使用。

上文中提到的妥协指的是分辨率和方差之间的妥协，这种妥协是广泛存在的，更高的谱分辨率
通常意味着较大的噪声。Welch 方法也是类似的，谱估计较低的噪声水平通常是通过设置
*N* << *M* 实现的，这样只能在谱估计中得到 *N* 个采样，可识别的最长周期为 *N* \* *delta_t*。
因此，噪声水平的降低导致了谱采样个数的减少以及可识别长周期长度的减小。相反地，如果
选择的 *N* 接近于 *M*，则谱估计的统计属性会非常差，但会得到很多采样以及识别出更长
的周期。

其他谱密度的估计方法也能得到较好的结果。之所以选择 Welch 方法，因为它的统计属性、
分辨率、旁瓣泄漏、偏移和方差等属性都比较容易且容易实现。一些其他的方法（例如
Maximum Entropy）则倾向于将这些妥协包装在一个黑匣子中。

相关模块
--------

:doc:`grdfft`

参考文献
----------

Bendat, J. S., and A. G. Piersol, 1986, Random Data, 2nd revised ed., John Wiley & Sons.

Welch, P. D., 1967, The use of Fast Fourier Transform for the estimation
of power spectra: a method based on time averaging over short, modified
periodograms, IEEE Transactions on Audio and Electroacoustics, Vol AU-15, No 2.
