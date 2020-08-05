earth_day 和 earth_night : 地球昼夜卫星影像
===============================================

.. gmtplot::
    :show-code: false
    :width: 80%
    :caption: 地球昼夜卫星影像

    gmt begin earth-image png,pdf
          gmt grdmath -Rd -I20m -r $(gmt solar -C -o0:1 -I+d2008-08-08T01:00) 2 DAYNIGHT = w.grd
          gmt grdmix @earth_day_20m @earth_night_20m -Ww.grd -Gview.tif
          gmt grdimage view.tif
          rm -f w.grd intens.grd view.tif
    gmt end show


介绍
----

GMT 提供了地球的卫星影像数据。该数据来自于美国航空航天局，分为白昼 (Blue Marble) 和黑夜（Black Marble）两类。
该影像数据也分不同的精度，从30弧秒到1弧度不等。

下表列出了GMT提供的昼夜卫星影像的名称、分辨率以及文件大小。

====================== ========= ========
影像数据名称           分辨率    大小
====================== ========= ========
``earth_day_01d``      1 弧度    128 KB
``earth_day_30m``      30 弧分   435 KB
``earth_day_20m``      20 弧分   918 KB
``earth_day_15m``      15 弧分   1.6 MB
``earth_day_10m``      10 弧分   3.4 MB
``earth_day_06m``      6 弧分    8.8 MB
``earth_day_05m``      5 弧分     13 MB
``earth_day_04m``      4 弧分     19 MB
``earth_day_03m``      3 弧分     33 MB
``earth_day_02m``      2 弧分     71 MB
``earth_day_01m``      1 弧分    258 MB
``earth_day_30s``      30 弧秒   935 MB
====================== ========= ========

使用方法
--------

影像数据名称中， day 指白昼，night指黑夜，可以通过 **@earth_day_**\ *res* 或者 **@earth_night_**\ *res* 的形式调用，
其中 *res* 表示网格文件的分辨率。
如果命令中使用了 **-R** 选项，则只会绘制该区域内的数据。例如：

查看30弧分的白昼影像数据的信息::

    gmt grdinfo @earth_day_30m

使用15弧分的白昼影像数据绘制全球影像图::

    gmt grdimage -JH15c @earth_day_15m -pdf map

使用2弧分的黑夜影像数据绘制一个区域的影像图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_night_02m -pdf map

技术细节
--------

-   数据会自动下载并保存到 **~/.gmt/server/earth/earth_day** 和 **~/.gmt/server/earth/earth_night** 目录下
-   除 30s 以外的分辨率的版本是经过 GMT 官方笛卡尔高斯滤波降采样。

数据来源及引用
--------------

#. 白昼影像: [https://visibleearth.nasa.gov/images/57752/blue-marble-land-surface-shallow-water-and-shaded-topography].
#. 黑夜影像: [https://earthobservatory.nasa.gov/features/NightLights/page3.php].
