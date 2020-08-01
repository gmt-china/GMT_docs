earth_images: 地球卫星影像数据
==============================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_day_01d -png,pdf earth_day

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_night_01d -png,pdf earth_night


介绍
----------------

GMT 提供了地球的卫星影像数据。该数据来自于美国航空航天局，分为白昼 (Blue Marble) 和黑夜（Black Marble）两类。
和地形起伏数据一样，该影像数据也分不同的精度，从30弧秒到1弧度。
使用时，GMT会自动下载，不需要用户自己下载或者安装。

下表列出了GMT提供的白昼影像数据的名称、分辨率以及文件大小。黑夜影像数据把名称中的day换为night即可。

====================== ========= ========
地形数据名称           分辨率    大小
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

当需要使用影像数据时，可以直接通过 **@earth_day_**\ *res* 或者 **@earth_night_**\ *res* 的形式调用，
其中 *res* 表示网格文件的分辨率。
如果命令中使用了 **-R** 选项，则只会读取该区域内的影像数据。例如：

查看60弧分的影像数据的信息::

    gmt grdinfo @earth_day_60m

使用15弧分影像数据绘制全球影像图::

    gmt grdimage -JH15c @earth_day_15m -pdf map

使用2弧分影像数据绘制一个区域的影像图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_day_02m -pdf map


数据来源及引用
--------------

#. 白昼数据: [https://visibleearth.nasa.gov/images/57752/blue-marble-land-surface-shallow-water-and-shaded-topography].
#. 黑夜数据: [https://earthobservatory.nasa.gov/features/NightLights/page3.php].
