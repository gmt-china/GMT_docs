简介
====

GMT 是什么
----------

GMT，全称 Generic Mapping Tools，中文一般译为“通用制图工具”，是地球科学最广泛
使用的制图软件之一。

GMT 具有强大的绘图功能和数据处理功能。

绘图方面，GMT 支持绘制多种类型的底图：除 30 多种地图投影外，还有笛卡尔线性坐标轴、
对数轴、指数轴、极坐标系；支持绘制统计直方图、等值线图、2D 网格图以及 3D 视角图等；
也支持绘制线段、海岸线、国界、多种符号、图例、色标、文字等。

数据处理方面，GMT 具有数据筛选、重采样、时间序列滤波、二维网格滤波、三维网格插值、
多项式拟合、线性回归分析等功能。

GMT 的历史
----------

- 1988 年，Paul Wessel 和 Walter H.F. Smith 开发了 GMT 的最原始版本 GMT 1.0
- 1991 年 8 月 10 日，GMT 2.0 发布
- 1998 年 11 月 8 日，GMT 3.x 的第一个正式版发布
- 2005 年 10 月 1 日，GMT 4.x 的第一个正式版发布；
  GMT 4.x 系列的最后一个版本是 GMT 4.5.18，发布于 2018 年 7 月 1 日
- 2013 年 11 月 5 日，GMT 5.x 的第一个正式版发布；
  GMT 5.x 系列的最后一个版本是 GMT 5.4.5，发布于 2019 年 1 月 4 日
- 2019 年 11 月 1 日，GMT 6.x 的第一个正式版发布；
  目前最新版本 GMT 6.2.0 发布于 2021 年 6 月 5 日。

想了解更多关于 GMT 的历史故事，可以观看/收听下面的视频/音频：

- Don't Panic Geocast 对 Paul Wessel 和 Leonardo Uieda 的采访：http://www.dontpanicgeocast.com/?p=638
- Don't Panic Geocast 对 Walter Smith 的采访：https://www.dontpanicgeocast.com/?p=742
- Paul Wessel 在 GMT 20 周年的演讲：https://av.tib.eu/media/19869 或 https://youtu.be/2D_UlEZpxbU

GMT 开发者
----------

GMT 的核心开发者有 7 位，分别是
`Paul Wessel <http://www.soest.hawaii.edu/wessel/>`_\ 、
`Walter H. F. Smith <https://www.star.nesdis.noaa.gov/star/Smith_WHF.php>`_\ 、
`Remko Scharroo <https://www.researchgate.net/profile/Remko_Scharroo>`_\ 、
`Joaquim F. Luis <http://joa-quim.pt/>`_\ 、
`Leonardo Uieda <https://www.leouieda.com>`_\ 、
Florian Wobbe 和
`Dongdong Tian <https://msu.edu/~tiandong/>`_\ 。
GMT 的开发在 `GitHub <https://github.com/GenericMappingTools/gmt>`_ 上进行，
任何用户均可通过多种方式向 GMT 做贡献。

.. figure:: GMT6_Summit_2019.jpg
   :width: 80%
   :align: center

   GMT 核心开发者及指导委员会部分成员

   从左至右依次为 Dongdong Tian、David Sandwell（指导委员会主席）、Walter H.F. Smith、
   Paul Wessel、Joaquim Luis、Leonardo Uieda 和 Dave Caress（指导委员会成员）。
   照片拍摄于 2019 年 7 月 29 日至 8 月 2 日在加州 La Jolla 举办的 GMT 开发者峰会。

GMT 的特点
----------

为什么选择 GMT 作为绘图软件呢？因为 GMT 有如下特点：

#. 开源免费

   GMT 是免费的开源软件，其源码遵循 `GNU LGPL <https://zh.wikipedia.org/zh-cn/GNU宽通用公共许可证>`_
   协议。任何人均可自由复制、分发、修改其源代码，也可用于盈利。修改后的代码
   必须开源但可以使用其它开源协议。

#. 跨平台

   GMT 源码由高度可移植的 C 语言写成，其完全兼容于 POSIX 标准，可以运行在 Linux、
   macOS 等类 UNIX 系统及 Windows 上。GMT 不仅公开了软件源代码，还提供了 Windows
   和 macOS 下的二进制安装包，各大 Linux 发行版中也提供了预编译的二进制包。

#. 模块化

   GMT 遵循 UNIX 的模块化设计思想，将不同的绘图功能和数据处理功能划分到不同的模块中。
   这样的模块化设计有很多优点：

   - 只需要少量的模块
   - 各个模块之间相互独立且代码量少，易于更新和维护
   - 每一步均独立于之前的步骤以及具体的数据类型，因而可以用于不同的应用中
   - 可以在脚本中调用一系列程序，或通过管道连接起来，进而绘制复杂图件

#. 支持多种格式的高精度矢量图和位图

   GMT 支持多种高精度的矢量图片格式和位图图片格式。
   矢量图片格式，如 PDF、PS 和 EPS，具有任意放大缩小而不失真的特性，可直接投稿到学术期刊；
   位图图片格式，如 BMP、JPG、PNG、PPM 和 TIFF 格式，可用于日常的文档及演示。

其它制图软件
------------

除了 GMT 之外，还有很多其它软件也可以用于制图。以下仅列出一些地学
常用的制图软件。其中 **√** 和 **X** 用于表示是否支持某一功能。

.. table:: 地球科学常用绘图软件比较
    :align: center

    ===============  ======  ======== ==============
    软件名称         二维图  三维图   地图
    ===============  ======  ======== ==============
    `GMT`_           √       √ [1]_   √
    `Matplotlib`_    √       √        √ [2]_
    Microsoft Excel  √       √        √
    `Origin`_        √       √        X
    Matlab           √       √        √ [3]_
    `ggplot2`_       √       X        √ [4]_
    `gnuplot`_       √       √        X
    ===============  ======  ======== ==============

.. _GMT: https://www.generic-mapping-tools.org/
.. _Matplotlib: https://matplotlib.org/
.. _Origin: https://www.originlab.com/
.. _ggplot2: https://ggplot2.tidyverse.org/
.. _gnuplot: http://www.gnuplot.info/

.. [1] GMT 对三维图的支持很有限
.. [2] 需要额外安装 `Cartopy <https://scitools.org.uk/cartopy/>`_
.. [3] 需要额外安装 `M_Map <https://www.eoas.ubc.ca/~rich/map.html>`_
.. [4] 需要额外安装 `ggmap <https://github.com/dkahle/ggmap>`_
