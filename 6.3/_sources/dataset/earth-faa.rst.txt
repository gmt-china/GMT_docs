earth_faa: IGPP 全球自由空气异常数据
=======================================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_faa_20m -png,pdf earth_faa

数据简介
--------

**earth_faa** 是 GMT 提供的全球自由空气异常数据。其中海洋区域的数据来自于
`David Sandwell 等 <https://topex.ucsd.edu/marine_grav/mar_grav.html>`_
，陆地区域的数据来自于 EGM2008 模型 [Pavlis et al., 2012]。
±80˚ 以外的极地区域没有数据覆盖，以 NaN 填充。数据单位为 mGal。

下表列出了 **earth_faa** 数据的代码、配准方式、分辨率以及文件大小。

======= ========= ==================== =======
代码    配准方式  分辨率               大小
======= ========= ==================== =======
01d     g,p       1 度                 106 KB
30m     g,p       30 分                368 KB
20m     g,p       20 分                785 KB
15m     g,p       15 分                1.3 MB
10m     g,p       10 分                2.9 MB
06m     g,p       6 分                 7.5 MB
05m     g,p       5 分                 11 MB
04m     g,p       4 分                 16 MB
03m     g,p       3 分                 28 MB
02m     g,p       2 分                 60 MB
01m     p         1 分                 220 MB
======= ========= ==================== =======

- 代码中 **d** 和 **m** 分别表示度、分
- 配准方式中 **g** 和 **p** 分别表示网格线配准和像素配准

使用方法
--------

当需要使用全球自由空气异常数据时，可以直接通过 **@earth_faa_**\ *rru*\[_\ *reg*] 的形式调用这些
全球自由空气异常数据，其中 *rru* 是网格文件的分辨率代码（上表第一列），*reg* 是要使用的
配准方式代码（上表第二列）。配准方式代码是可选的，若不指定，则默认返回像素配准的
网格数据（若不存在，则返回网格线配准的数据）。如果不指定 CPT，则会默认调用 *@earth_faa.cpt* 进行绘图。

数据来源及引用
--------------

#. Sandwell, D.T., Harper, H., Tozer, B. and Smith, W.H., 2019: [https://doi.org/10.1016/j.asr.2019.09.011].
#. Pavlis, N.K., Holmes, S.A., Kenyon, S.C. and Factor, J.K., 2012: [https://doi.org/10.1029/2011JB008916].
