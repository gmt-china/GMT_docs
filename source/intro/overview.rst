GMT简介
=======

GMT是什么
---------

GMT，全称Generic Mapping Tools，中文一般译为“通用制图工具”。

GMT可以绘制多种类型的底图，包括不同类型的地图投影、常见的2D笛卡尔坐标轴（线性轴、对数轴和指数轴）
以及3D图；还可以在底图上绘制线段、多种符号、等值线、图例、直方图和文字等。
除此之外，GMT还具有数据转换、处理和分析的功能，比如多项式拟合、数据滤波、线性回归
分析等。

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

GMT源码目前主要由 Paul Wessel、Joaquim Luis、Remko Scharroo和Leonardo Uieda维护。
其源码公开在 `GitHub <https://github.com/GenericMappingTools/gmt>`_ 上，任何用户
均可贡献自己的代码。

.. figure:: /static_images/GMT5_Summit_2016.jpg
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
   macOS、Windows及其他类Unix系统上。GMT官方网站不仅提供了软件源码，还提供了 Windows
   和 macOS 下的安装包。各大Linux发行版中也提供了预编译的二进制版本。

#. 模块化

   GMT遵循UNIX的模块化设计思想，将不同的绘图功能和数据处理功能划分到不同的模块中。
   这样的模块化设计有很多优点：

   - 只需要少量的模块
   - 各个模块之间相互独立且代码量少，易于更新和维护
   - 每一步均独立于独立于之前的步骤以及具体的数据类型，因而可以用于不同的应用中
   - 可以在shell脚本中调用一系列程序，或通过管道连接起来，进而绘制复杂图件

#. 支持多种格式的高精度矢量图和位图

   GMT支持多种高精度的矢量图片格式和位图图片格式。EPS、PDF和SVG格式，
   矢量图片格式，如PDF、PS、EPS和SVG，具有任意放大缩小而不失真的特性，可直接投稿到学术期刊；
   位图图片格式，如BMP、JPG、PNG、PPM和TIFF格式，可用于日常的文档及演示。

GMT替代品
---------

在绘制地图方面，还有一些软件也可以实现类似的功能，可以作为GMT的替代品。

#. Python: `Cartopy <https://scitools.org.uk/cartopy/>`_ | `Basemap <http://matplotlib.org/basemap/>`_
#. Matlab: `M_Map <https://www.eoas.ubc.ca/~rich/map.html>`_
#. R: `ggmap <https://github.com/dkahle/ggmap>`_

.. TODO::

    介绍更多GMT替代品
