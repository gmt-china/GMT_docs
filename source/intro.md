---
author: Alice Example, Charlie Writer
reviewer: Bob Reviewer, Dana Proof
date: Apr 24, 2025
---

# 简介

## GMT 是什么

GMT，全称 Generic Mapping Tools，中文一般译为“通用制图工具”。

GMT 是地球科学领域使用最广泛的制图软件之一，具有强大的绘图功能和数据处理功能。

绘图方面，GMT 支持绘制多种类型的底图，
包含 30 多种地图投影、笛卡尔坐标轴（线性坐标轴、对数轴、指数轴）、极坐标轴；
支持绘制统计直方图、等值线图、2D 网格图以及 3D 视角图等；
也支持绘制线段、海岸线、国界、多种符号、图例、色标、文字等。

数据处理方面，GMT 具有数据筛选、重采样、时间序列滤波、二维网格滤波、三维网格插值、
多项式拟合、线性回归分析等功能。

## GMT 的历史

- 1988 年，Paul Wessel 和 Walter H.F. Smith 开发了 GMT 的最原始版本 GMT 1.0
- 1991 年 8 月 10 日，GMT2 发布
- 1998 年 11 月 8 日，GMT3 发布
- 2005 年 10 月 1 日，GMT4 发布
- 2013 年 11 月 5 日，GMT5 发布
- 2019 年 11 月 1 日，GMT6 发布（目前最新版本 GMT 6.5.0 发布于 2024 年 01 月 07 日）

想了解更多关于 GMT 的历史故事，可以观看/收听下面的视频/音频：

- Don't Panic Geocast 对 Paul Wessel 和 Leonardo Uieda 的采访：<https://www.dontpanicgeocast.com/166>
- Don't Panic Geocast 对 Walter Smith 的采访：<https://www.dontpanicgeocast.com/195>
- Paul Wessel 在 GMT 20 周年的演讲：<https://av.tib.eu/media/19869> 或 <https://youtu.be/2D_UlEZpxbU>
- Paul Wessel 关于 GMT 发展史的文章: [The origins of the generic mapping tools: From table tennis to geoscience](https://doi.org/10.1029/2023CN000231)

## GMT 开发者

GMT 的核心开发者有 8 位：[Paul Wessel](http://www.soest.hawaii.edu/wessel/)、[Walter H. F. Smith](https://www.star.nesdis.noaa.gov/star/Smith_WHF.php)、[Remko Scharroo](https://www.researchgate.net/profile/Remko_Scharroo)、[Joaquim F. Luis](http://joa-quim.pt/)、[Leonardo Uieda](https://www.leouieda.com)、Florian Wobbe、[Dongdong Tian](https://me.seisman.info) 和
[Max Jones](https://github.com/maxrjones)。

:::{figure} https://docs.generic-mapping-tools.org/latest/_images/GMT6_Summit_2019.jpg
:align: center
:alt: "2019 年 GMT 开发者峰会"
:width: 80%

GMT 部分核心开发者及指导委员会部分成员

从左至右依次为 Dongdong Tian、David Sandwell（指导委员会主席）、Walter H.F. Smith、
Paul Wessel、Joaquim Luis、Leonardo Uieda 和 Dave Caress（指导委员会成员）。
照片拍摄于 2019 年 7 月 29 日至 8 月 2 日在加州 La Jolla 举办的 GMT 开发者峰会。
:::

## GMT 的特点

为什么选择 GMT 软件来绘图呢？因为 GMT 有如下特点：

1. 专注于地学制图

   GMT 是一个专业的地学制图软件。在绘制地图方面，GMT 不仅可以更高效地绘制地图，
   而且可以更简单地实现制图过程所需的数据处理等操作。

2. 开源免费

   GMT 是免费的开源软件，源码遵循
   [GNU LGPL](https://zh.wikipedia.org/zh-cn/GNU宽通用公共许可证) 协议。
   任何人均可免费获得软件源码并自由复制、分发及修改。

3. 跨平台

   GMT 源码由高度可移植的 C 语言写成，其完全兼容于 POSIX 标准，可以运行在 Linux、
   macOS 等类 UNIX 系统及 Windows 上。GMT 不仅公开了软件源代码，还提供了 Windows
   和 macOS 下的二进制安装包，各大 Linux 发行版中也提供了预编译的二进制包。

4. 模块化

   GMT 遵循 UNIX 的模块化设计思想，将不同的绘图功能和数据处理功能划分到不同的模块中。
   这样的模块化设计有很多优点：

   - 只需要少量的模块
   - 各个模块之间相互独立且代码量少，易于更新和维护
   - 可以在脚本中调用一系列模块以绘制复杂图件

5. 支持多种格式的高精度矢量图和位图

   GMT 支持多种高精度的矢量图片格式（如 PDF、PS 和 EPS）和
   位图图片格式（如 BMP、JPG、PNG、PPM 和 TIFF ）。
   矢量图片格式具有任意放大缩小而不失真的特性，可直接投稿到学术期刊；
   位图图片格式可用于日常的文档及演示。

6. 软件开发过程透明且活跃

   GMT 的开发（修改、讨论与决议）都在 [GitHub](https://github.com/GenericMappingTools/gmt)
   上公开进行。所有用户均可向 GMT 提交 bug 报告、申请增加新功能、参与讨论等，
   并可以通过多种不同方式（改进文档、修改源码等）向 GMT 做贡献。

## GMT 版本号

GMT 版本号遵循“[语义化版本号规范](https://semver.org/lang/zh-CN)”，其版本号格式为 *major.minor.patch*。
其中，*major* 为主版本号，*minor* 为次版本号，*patch* 为补丁版本号，如 6.2.0。

根据“语义化版本号规范”的要求：

- 有大更新时（如重写底层代码），会增加主版本号 *major*。
  *major* 不同的两个版本的语法、功能以及 API 接口可能有差异
- 有较大更新时（如新增模块或者新增功能），会增加次版本号 *minor*
- 若只是修复代码 BUG 或改进文档，则增加补丁版本号 *patch*

因而，GMT 6.x.x 与 5.x.x 在底层存在很大差异，两个版本的语法不一定完全兼容；
GMT 6.2.x 相对于 6.1.x 增加了更多的功能；
GMT 6.1.1 相对于 6.1.0 则主要是修复了一些 BUG。

:::{note}
GMT 开发版的版本号略有不同，其格式为：

> *major.minor.patch*\_*hash*\_*yyyy.mm.dd*

其中，*hash* 和 *yyyy.mm.dd* 是开发版中最新提交的 hash 值和日期。
例如，6.1.0_267ce55_2020.01.21 表示更新于 2020 年 1 月 21 日、
hash 值为 267ce55 的 6.1.0 开发版。
:::

(citations)=

## 引用

若你发表的文章中包含了利用 GMT 制作的图件或利用 GMT 数据处理功能得到的结果，
可以考虑在文中引用 GMT 的如下文章来回报 GMT 开发者。

**GMT6 用户**:

: Wessel, P., Luis, J. F., Uieda, L., Scharroo, R., Wobbe, F., Smith, W. H. F., & Tian, D. (2019).
  The Generic Mapping Tools version 6.
  *Geochemistry, Geophysics, Geosystems*, 20, 5556–5564.
  <https://doi.org/10.1029/2019GC008515>

**GMT 发展史**:

: Wessel, P. (2024).
  The origins of the generic mapping tools: From table tennis to geoscience.
  *Perspectives of Earth and Space Scientists*, 5, e2023CN000231.
  <https://doi.org/10.1029/2023CN000231>

**GMT5 用户**:

: Wessel, P., Smith, W. H. F., Scharroo, R., Luis, J., & Wobbe, F. (2013).
  Generic Mapping Tools: Improved version released.
  *Eos, Transactions American Geophysical Union*, 94(45), 409–410.
  <https://doi.org/10.1002/2013EO450001>

**GMT4/GMT3 用户**:

: Wessel, P., & Smith, W. H. F. (1998).
  New, improved version of Generic Mapping Tools released.
  *Eos, Transactions American Geophysical Union*, 79(47), 579.
  <https://doi.org/10.1029/98EO00426>

**GMT/MATLAB 工具箱用户**:

: Wessel, P., & Luis J. (2017).
  The GMT/MATLAB Toolbox.
  *Geochemistry, Geophysics, Geosystems*, 18, 811–823.
  <https://doi.org/10.1002/2016GC006723>

GMT 的某些模块基于 GMT 团队单独发展并发表的算法。算法相关文章包括：

**movie** 模块

: Wessel, P., Esteban, F., & Delaviel-Anger, G. (2024).
  The Generic Mapping Tools and Animations for the Masses.
  *Geochemistry, Geophysics, Geosystems*, 25(6).
  <https://doi.org/10.1029/2024GC011545>

{doc}`/module/dimfilter` **模块**

: Kim, S.-S., & Wessel, P. (2008).
  Directional median filtering for regional-residual separation of bathymetry.
  *Geochemistry, Geophysics, Geosystems*, 9, Q03005.
  <https://doi.org/10.1029/2007GC001850>

{doc}`/module/grdredpol` **模块**

: Luis, J. F. & Miranda, J. M. (2008).
  Reevaluation of magnetic chrons in the North Atlantic between 35°N and 47°N:
  Implications for the formation of the  Azores Triple Junction and associated plateau.
  *Journal of Geophysical Research*, 113, B10105.
  <https://doi.org/10.1029/2007JB005573>

{doc}`/module/surface` **模块**

: Smith, W. H. F., & Wessel, P. (1990).
  Gridding with continuous curvature splines in tension.
  *Geophysics*, 55(3), 293–305.
  <https://doi.org/10.1190/1.1442837>

**x2sys 相关模块**

: Wessel, P. (2010).
  Tools for analyzing intersecting tracks: The x2sys package.
  *Computers & Geosciences*, 36, 348–354.
  <https://doi.org/10.1016/j.cageo.2009.05.009>

{doc}`gmt:greenspline` **模块**

: Wessel, P. (2009).
  A general-purpose Green's function-based interpolator.
  *Computers & Geosciences*, 35, 1247–1254.
  <https://doi.org/10.1016/j.cageo.2008.08.012>

  Wessel, P. & Becker, J. M. (2008).
  Interpolation using a generalized Green's function for a spherical surface spline in tension.
  *Geophysical Journal International*, 174, 21–28.
  <https://doi.org/10.1111/j.1365-246X.2008.03829.x>

(resources)=

## 学习资源

本节列出网络上可免费获取的 GMT 学习资源。各个学习资源的质量以及维护程度不同，
**建议用户以英文官方文档以及本中文手册为主，其余学习资源仅供参考**。

**入门教程**

1. [GMT6 初学者视频教程](https://www.bilibili.com/video/BV1C64y1m7qP)（{{ 刘珠妹 }}、{{ 陈箫翰 }}）
2. GMT 中文手册：{doc}`入门教程 </tutorial/started>`、{doc}`进阶教程 </tutorial/advanced>`
3. {gmt-docs}`GMT 官方入门教程 <tutorial.html>`
4. [GMT 教學手冊](http://gmt-tutorials.org/)（[鄭懷傑](https://github.com/whyjz)）

**参考手册**

1. [GMT 中文手册](https://docs.gmt-china.org/)
2. {gmt-docs}`GMT 官方参考手册 <reference.html>`
3. {gmt-docs}`GMT 官方模块手册 <modules.html>`

**论坛/讨论组**

1. 地学 GMT 中文社区 QQ 群 [**请勿重复加群！** 入群前请先阅读“[入群须知](https://gmt-china.org/blog/community-guide/)”]：

   - QQ 1 群：218905582
   - QQ 2 群：791856541

2. [GMT 官方论坛](https://forum.generic-mapping-tools.org/)
