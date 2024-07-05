.. index:: ! spectrum1d

spectrum1d
==========

:贡献者: |田冬冬|，|周茂|
:最近更新日期: 2024-07-03

----

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
|-C| 选项，那么将会有 8 个文件输出，否则只生成一个功率谱文件（ ``.xpower`` ）。
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

**gmt spectrum1d** [ *table* ] [ |-S|\ *segment_size* ]
[ |-C|\ [**acgnopxy**] ] [ |-D|\ *dt* ] [ |-L|\ [**h**\|\ **m**] ]
[ |-N|\ [*name_stem*] ] [ |-T| ] [ |-W| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入文件名。它是 ASCII 类型的一列数据或两列数据。如果是一列数据文件，就计算
    自功率谱；如果是两列，就计算互功率谱。若未指定文件名， **spectrum1d** 会从
    标准输入流中读取数据。

.. _-S:

**-S**\ *segment_size*
    ``segment_size`` 是一个 2 的指数数值，用于控制 Welch 方法中分段平均时的窗口
    长度。它也决定了功率谱密度的最小频率分辨率和最大频率分辨率，即
    ``1.0/(segment_size*dt)`` 和 ``1.0/(2*dt)`` （即 Nyquist 频率）。在功率谱密度
    中的一个标准误差大约为 ``1.0/sqrt(n_data/segment_size)`` ，比如 segment_size=256，
    那么就需要 25600 个数据点去计算一个误差棒的 10%。互功率谱误差棒的计算则需要更多
    数据点，而且是相干性的函数，比较复杂。

可选选项
--------

.. _-C:

**-C**\ [**acgnopxy**]
    读取输入中的前两列，即 *X*\ (*t*) 和 *Y*\ (*t*) 时间序列。假设 *Y*\ (*t*)
    和 *X*\ (*t*) 分别是一个带有噪声的线性系统的输出和输入。使用最小二乘估计最优
    频率响应函数会将噪声最小化并且相干输出与噪声输出是不相关的。
    本模块默认会输出如下属的全部 8 个文件。使用该选项可以指定输出 8 个文件中的某些文件。
    x=xpower、y=ypower、c=cpower、n=npower、p=phase、a=admit、g=gain、o=coh。

.. _-D:

**-D**\ *dt*
    设置读入的时间序列的时间采样间隔，默认值是1。

.. _-L:

**-L**\ [**h**\|\ **m**]
    不去除信号中的线性趋势。默认情况下，在对信号进行变换处理前会先去掉其中的
    线性趋势。 追加 ``m`` 表示去掉数据的均值， ``h`` 表示去掉数据的中值。

.. _-N:

**-N**\ [*name\_stem*]
    输出文件名的前缀，默认为 ``spectrum`` 。若不使用此选项，则输出的 9 个文件会
    合到一个文件里。

.. _-T:

**-T**
    不让单个分量的结果输出到标准输出，对 |-C| 设置的输出分量分别输出到单个
    指定文件中

.. _-W:

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
就必须除以采样间隔 `dt`。（如果想对谱坐归一化，则可从 Parseval 定理中得到缩放因子，
Parseval 定理为：输入数据的平方和等于 **spectrum1d** 输出的平方和。）

假定存在一个数据，`X(t)`，计算其离散傅立叶变换（DFT），结果为 `X(f)`，将其与自身
的复数共轭相乘，即得到周期图 ::

    P_raw(f) = X(f) * X'(f)


实际中，P_raw 的噪声会非常地大，因此需要平滑或者平均等方法得到一个实用的估计
P_useful(f)。除了 Welch 方法，另外还有多种计算功率谱密度的方法:

    - 计算 x(t) 的自协方差函数，然后平滑，做 taper，然后计算自协方差函数的傅立叶变换。

    - 对 x(t) 的自相关函数进行参数拟合，得到模型后计算该模型的谱

    - "maxumum entropy", "Berg", "Box-Jenkins", "ARMA" 或者 "ARIMA" 等方法

Welch 方法是一种久经考验的方法。在 Welch 方法中，用户需指定一个数据长度 N，这样
对数据进行分段，对

*Welch*\ 's method is a tried-and-true method. In his method, you choose a segment length,
**-S**\ *N*, so that estimates will be made from segments of length *N*. The frequency samples
(in cycles per delta_t unit) of your P_useful will then be at *k* /(*N* \* *delta_t*),
where *k* is an integer, and you will get *N* samples (since the spectrum is an even
function of *f*, only *N*/2 of them are really useful). If the length of your entire
data set, x(t), is *M* samples long, then the variance in your P_useful will decrease
in proportion to *N/M*. Thus you need to choose *N* << *M* to get very low noise and
high confidence in P_useful. There is a trade-off here; see below.

There is an additional reduction in variance in that Welch's method uses a Von Hann
spectral window on each sample of length *N*. This reduces side lobe leakage and has
the effect of smoothing the (*N* segment) periodogram as if the X(f) had been
convolved with [1/4, 1/2, 1/4] prior to forming P_useful. But this slightly widens
the spectral bandwidth of each estimate, because the estimate at frequency sample *k*
is now a little correlated with the estimate at frequency sample k+1. (Of course this
would also happen if you simply formed P_raw and then smoothed it.)

Finally, *Welch*\ 's method also uses overlapped processing. Since the Von Hann window is
large in the middle and tapers to near zero at the ends, only the middle of the segment
of length *N* contributes much to its estimate. Therefore in taking the next segment
of data, we move ahead in the x(t) sequence only *N*/2 points. In this way, the next
segment gets large weight where the segments on either side of it will get little weight,
and vice versa. This doubles the smoothing effect and ensures that (if *N* << *M*)
nearly every point in x(t) contributes with nearly equal weight in the final answer.

*Welch*\ 's method of spectral estimation has been widely used and widely studied. It is very
reliable and its statistical properties are well understood. It is highly recommended in
such textbooks as "Random Data: Analysis and Measurement Procedures" [*Bendat and Piersol*, 1986].

In all problems of estimating parameters from data, there is a classic trade-off between
resolution and variance. If you want to try to squeeze more resolution out of your data
set, then you have to be willing to accept more noise in the estimates. The same trade-off
is evident here in Welch's method. If you want to have very low noise in the spectral
estimates, then you have to choose *N* << *M*, and this means that you get only *N*
samples of the spectrum, and the longest period that you can resolve is only *N* \* *delta_t*.
So you see that reducing the noise lowers the number of spectral samples and lowers the
longest period. Conversely, if you choose *N* approaching *M*, then you approach the
periodogram with its very bad statistical properties, but you get lots of samples and
a large fundamental period.

The other spectral estimation methods also can do a good job. Welch's method was selected
because the way it works, how one can code it, and its effects on statistical distributions,
resolution, side-lobe leakage, bias, variance, etc. are all easily understood. Some of the
other methods (e.g. Maximum Entropy) tend to hide where some of these trade-offs are
happening inside a "black box".




相关模块
--------

:doc:`grdfft`

参考文献
-------

Bendat, J. S., and A. G. Piersol, 1986, Random Data, 2nd revised ed., John Wiley & Sons.

Welch, P. D., 1967, The use of Fast Fourier Transform for the estimation
of power spectra: a method based on time averaging over short, modified
periodograms, IEEE Transactions on Audio and Electroacoustics, Vol AU-15, No 2.
