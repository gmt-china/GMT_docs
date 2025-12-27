GMT简介
=======

GMT是什么
---------

GMT，全称Generic Mapping Tools，中文一般译为“通用制图工具”，是地球科学最广泛
使用的制图软件。GMT具有强大的绘图功能和数据处理功能。

绘图方面，GMT支持绘制多种类型的底图，包括30多种地图投影、笛卡尔线性坐标轴、
对数轴、指数轴、极坐标系，支持绘制统计直方图、等值线图、2D网格图以及3D视角图等，
也支持绘制线段、海岸线、国界、多种符号、图例、色标、文字等。

数据处理方面，GMT具有数据筛选、重采样、时间序列滤波、二维网格滤波、多项式拟合、
线性回归分析等功能。

GMT的历史
---------

- 1988年，Paul Wessel和Walter H.F. Smith开发了GMT的最原始版本GMT 1.0；
- 1991年8月10日，GMT 2.0发布；
- 1998年11月8日，GMT 3.x的第一个正式版发布；
- 2005年10月1日，GMT 4.x的第一个正式版发布；GMT4.x系列的最后一个版本是
  GMT 4.5.18，发布于2018年7月1日；
- 2013年11月5日，GMT 5.x的第一个正式版发布；目前最新版本 GMT |GMT5_latest_release|
  发布于 |GMT5_latest_release_date|\ ；

GMT维护者
---------

GMT源码目前主要由 `Paul Wessel <http://www.soest.hawaii.edu/wessel/>`_ 和
`Joaquim Luis <http://w3.ualg.pt/~jluis/>`_ 维护。
其源码公开在 `GitHub <https://github.com/GenericMappingTools/gmt>`_ 上，任何用户
均可贡献自己的代码。

.. figure:: /images/GMT5_Summit_2016.jpg
   :width: 100%
   :align: center

   GMT的5个主要维护者

   从左至右依次为Joaquim Luis、Walter H.F. Smith、Remko Scharroo、Florian Wobbe
   和 Paul Wessel。照片摄于2016年8月15日至19日在加州La Jolla举办的GMT开发者峰会。

GMT的特点
---------

为什么选择GMT作为绘图软件呢？因为GMT有如下特点：

#. 开源免费

   GMT是开源软件，其源码遵循 `LGPL <https://zh.wikipedia.org/zh-cn/GNU宽通用公共许可证>`_
   协议。任何人均可自由复制、分发、修改其源代码，也可用于盈利。修改后的代码
   必须开源但可以使用其他开源协议。

#. 跨平台

   GMT的源码采用了高度可移植的ANSI C语言，其完全兼容于POSIX标准，可以运行在Linux、
   macOS、Windows及其他类Unix系统上。GMT不仅公开了软件源代码，还提供了 Windows
   和 macOS 下的安装包。各大Linux发行版中也提供了预编译的二进制包。

#. 模块化

   GMT遵循Unix的模块化设计思想，将不同的绘图功能和数据处理功能划分到不同的模块中。
   这样的模块化设计有很多优点：

   - 只需要少量的模块
   - 各个模块之间相互独立且代码量少，易于更新和维护
   - 每一步均独立于之前的步骤以及具体的数据类型，因而可以用于不同的应用中
   - 可以在脚本中调用一系列程序，或通过管道连接起来，进而绘制复杂图件

#. 支持多种格式的高精度矢量图和位图

   GMT支持多种高精度的矢量图片格式和位图图片格式。
   矢量图片格式，如PDF、PS、EPS和SVG，具有任意放大缩小而不失真的特性，可直接投稿到学术期刊；
   位图图片格式，如BMP、JPG、PNG、PPM和TIFF格式，可用于日常的文档及演示。

其他制图软件
------------

除了GMT之外，还有很多其他的软件也可以实现各种制图功能。以下仅列出一些地学
常用的制图软件。其中 ``√`` 和 ``X`` 用于表示是否支持某一功能。

.. table:: 地球科学常用绘图软件
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

.. _GMT: http://gmt.soest.hawaii.edu
.. _Matplotlib: https://matplotlib.org/
.. _Origin: https://www.originlab.com/
.. _ggplot2: https://ggplot2.tidyverse.org/
.. _gnuplot: http://www.gnuplot.info/

.. [1] GMT对三维图的支持很有限。
.. [2] 需要额外安装 `Cartopy <https://scitools.org.uk/cartopy/>`_ 或 `Basemap <http://matplotlib.org/basemap/>`_
.. [3] 需要额外安装 `M_Map <https://www.eoas.ubc.ca/~rich/map.html>`_
.. [4] 需要额外安装 `ggmap <https://github.com/dkahle/ggmap>`_
