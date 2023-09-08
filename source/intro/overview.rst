简介
====

GMT 是什么
----------

GMT，全称 Generic Mapping Tools，中文一般译为“通用制图工具”。
GMT 是地球科学使用最广泛的制图软件之一，具有强大的绘图功能和数据处理功能。

绘图方面，GMT 支持绘制多种类型的底图，
包含 30 多种地图投影、笛卡尔坐标轴（线性坐标轴、对数轴、指数轴）、极坐标轴；
支持绘制统计直方图、等值线图、2D 网格图以及 3D 视角图等；
也支持绘制线段、海岸线、国界、多种符号、图例、色标、文字等。

数据处理方面，GMT 具有数据筛选、重采样、时间序列滤波、二维网格滤波、三维网格插值、
多项式拟合、线性回归分析等功能。

GMT 的历史
----------

- 1988 年，Paul Wessel 和 Walter H.F. Smith 开发了 GMT 的最原始版本 GMT 1.0
- 1991 年 8 月 10 日，GMT2 发布
- 1998 年 11 月 8 日，GMT3 发布
- 2005 年 10 月 1 日，GMT4 发布（GMT4 系列的最后一个版本 GMT 4.5.18 发布于 2018 年 7 月 1 日）
- 2013 年 11 月 5 日，GMT5 发布（GMT5 系列的最后一个版本 GMT 5.4.5 发布于 2019 年 1 月 4 日）
- 2019 年 11 月 1 日，GMT6 发布（目前最新版本 GMT 6.4.0 发布于 2022 年 06 月 18 日）

想了解更多关于 GMT 的历史故事，可以观看/收听下面的视频/音频：

- Don't Panic Geocast 对 Paul Wessel 和 Leonardo Uieda 的采访：https://www.dontpanicgeocast.com/166
- Don't Panic Geocast 对 Walter Smith 的采访：https://www.dontpanicgeocast.com/195
- Paul Wessel 在 GMT 20 周年的演讲：https://av.tib.eu/media/19869 或 https://youtu.be/2D_UlEZpxbU

GMT 开发者
----------

GMT 的核心开发者有 8 位：\
`Paul Wessel <http://www.soest.hawaii.edu/wessel/>`__、\
`Walter H. F. Smith <https://www.star.nesdis.noaa.gov/star/Smith_WHF.php>`__、\
`Remko Scharroo <https://www.researchgate.net/profile/Remko_Scharroo>`__、\
`Joaquim F. Luis <http://joa-quim.pt/>`__、\
`Leonardo Uieda <https://www.leouieda.com>`__、\
Florian Wobbe、\
`Dongdong Tian <https://me.seisman.info>`__ 和
`Max Jones <https://github.com/maxrjones>`__。

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT6_Summit_2019.jpg
   :alt: 2019 年 GMT 开发者峰会
   :align: center
   :width: 80%

   GMT 部分核心开发者及指导委员会部分成员

   从左至右依次为 Dongdong Tian、David Sandwell（指导委员会主席）、Walter H.F. Smith、
   Paul Wessel、Joaquim Luis、Leonardo Uieda 和 Dave Caress（指导委员会成员）。
   照片拍摄于 2019 年 7 月 29 日至 8 月 2 日在加州 La Jolla 举办的 GMT 开发者峰会。

GMT 的特点
----------

为什么选择 GMT 软件来绘图呢？因为 GMT 有如下特点：

#. 专注于地学制图

   GMT 是一个专业的地学制图软件。在绘制地图方面，GMT 不仅可以更高效地绘制地图，
   而且可以更简单地实现地学制图过程所需的数据处理等操作。

#. 开源免费

   GMT 是免费的开源软件，其源码遵循
   `GNU LGPL <https://zh.wikipedia.org/zh-cn/GNU宽通用公共许可证>`__ 协议。
   任何人均可免费获得软件的源码，并可以自由复制、分发以及修改。

#. 跨平台

   GMT 源码由高度可移植的 C 语言写成，其完全兼容于 POSIX 标准，可以运行在 Linux、
   macOS 等类 UNIX 系统及 Windows 上。GMT 不仅公开了软件源代码，还提供了 Windows
   和 macOS 下的二进制安装包，各大 Linux 发行版中也提供了预编译的二进制包。

#. 模块化

   GMT 遵循 UNIX 的模块化设计思想，将不同的绘图功能和数据处理功能划分到不同的模块中。
   这样的模块化设计有很多优点：

   - 只需要少量的模块
   - 各个模块之间相互独立且代码量少，易于更新和维护
   - 可以在脚本中调用一系列模块以绘制复杂图件

#. 支持多种格式的高精度矢量图和位图

   GMT 支持多种高精度的矢量图片格式（如 PDF、PS 和 EPS）和
   位图图片格式（如 BMP、JPG、PNG、PPM 和 TIFF ）。
   矢量图片格式具有任意放大缩小而不失真的特性，可直接投稿到学术期刊；
   位图图片格式可用于日常的文档及演示。

#. 软件开发过程透明且活跃

   GMT 的开发（修改、讨论与决议）都在 `GitHub <https://github.com/GenericMappingTools/gmt>`__
   上公开进行。所有用户均可向 GMT 提交 bug 报告、申请增加新功能、参与讨论等，
   并可以通过多种不同方式（改进文档、修改源码等）向 GMT 做贡献。

GMT 版本号
----------

GMT 版本号遵循“`语义化版本号规范 <https://semver.org/lang/zh-CN>`__”，其版本号格式为:

    *major.minor.patch*

其中，*major* 为主版本号，*minor* 为次版本号，*patch* 为补丁版本号，如 6.2.0。

根据“语义化版本号规范”的要求：

- 有大更新时（如重写底层代码），会增加主版本号 *major*。
  *major* 不同的两个版本的语法、功能以及 API 接口可能有差异
- 有较大更新时（如新增模块或者新增功能），会增加次版本号 *minor*
- 若只是修复代码 BUG 或改进文档，则增加补丁版本号 *patch*

因而，GMT 6.x.x 与 5.x.x 在底层存在很大差异，两个版本的语法不一定完全兼容；
GMT 6.2.x 相对于 6.1.x 增加了更多的功能；
GMT 6.1.1 相对于 6.1.0 则主要是修复了一些 BUG。

.. note::

    GMT 开发版的版本号略有不同，其格式为：

        *major.minor.patch*\_\ *hash*\_\ *yyyy.mm.dd*

    其中，*hash* 和 *yyyy.mm.dd* 是开发版中最新提交的 hash 值和日期。
    例如，6.1.0_267ce55_2020.01.21 表示更新于 2020 年 1 月 21 日、
    hash 值为 267ce55 的 6.1.0 开发版。
