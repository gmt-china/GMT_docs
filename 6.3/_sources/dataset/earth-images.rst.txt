earth_day 和 earth_night: 地球昼夜卫星影像
==========================================

.. gmtplot::
    :show-code: false
    :width: 80%
    :caption: 地球昼夜卫星影像

    gmt begin earth-image
        gmt grdmath -Rd -I20m -r $(gmt solar -C -o0:1 -I+d2008-08-08T01:00) 2 DAYNIGHT = w.grd
        gmt grdmix @earth_day_20m @earth_night_20m -Ww.grd -Gview.tif
        gmt grdimage view.tif
        rm -f w.grd view.tif
    gmt end show


数据简介
--------

GMT 提供了地球的卫星影像数据。该数据来自于美国航空航天局，分为白昼（Blue Marble）
和黑夜（Black Marble）两类。该影像数据也分不同的精度，从30秒到1度不等。

下表列出了GMT提供的昼夜卫星影像的代码、配准方式、分辨率以及文件大小。

===== ========= ======== =========
代码  配准方式  分辨率    大小
===== ========= ======== =========
01d   p         1 度      128 KB
30m   p         30 分     435 KB
20m   p         20 分     918 KB
15m   p         15 分     1.6 MB
10m   p         10 分     3.4 MB
06m   p         6 分      8.8 MB
05m   p         5 分       13 MB
04m   p         4 分       19 MB
03m   p         3 分       33 MB
02m   p         2 分       71 MB
01m   p         1 分      258 MB
30s   p         30 秒     935 MB
===== ========= ======== =========

- 白昼影像数据的名称为 **earth_day**
- 黑夜影像数据的名称为 **earth_night**
- 代码中 **d**、**m**\ 和 **s** 表示度、分和秒
- 配准方式 **p** 分别表示像素配准（目前该数据只提供像素配准的数据）
- 目前高精度影像数据以单个文件形式保存，并没有划分为小区块保存

使用方法
--------

地球昼夜影像数据通过 **@earth_day_**\ *rru* 或者 **@earth_night_**\ *rru* 的形式调用，
其中 *rru* 表示影像文件的分辨率。
如果命令中使用了 **-R** 选项，则只会绘制该区域内的数据。例如：

使用15分的白昼影像数据绘制全球影像图::

    gmt grdimage -JH15c @earth_day_15m -pdf map

使用2分的黑夜影像数据绘制一个区域的影像图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_night_02m -pdf map

技术细节
--------

- 数据会自动下载并保存到 **~/.gmt/server/earth/earth_day** 和 **~/.gmt/server/earth/earth_night** 目录下
- 30秒分辨率的版本是NASA官方提供的版本
- 其它分辨率的版本是经过 GMT 官方笛卡尔高斯滤波降采样得到

数据来源及引用
--------------

#. 白昼影像: [https://visibleearth.nasa.gov/images/57752/blue-marble-land-surface-shallow-water-and-shaded-topography].
#. 黑夜影像: [https://earthobservatory.nasa.gov/features/NightLights/page3.php].
