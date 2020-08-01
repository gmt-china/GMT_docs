earth_images: 地球影像数据
==============================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_night_20m -png,pdf earth_night

介绍
----------------

GMT 提供了地球的影像数据。该数据来自于美国航空航天局，分为白昼和黑夜两类。和影像起伏数据一样，也分不同的精度，从30弧秒到1弧度。

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

这些数据保存在GMT的服务器上。当用户\ **第一次**\ 使用某个分辨率的
影像起伏数据时，GMT会自动从服务器上下载该数据文件，
并保存到GMT的缓存文件夹下（由 :term:`DIR_CACHE` 控制，默认为 **~/.gmt/server** 目录），
然后再读取该文件。以后再使用该数据时，GMT会自动从缓存文件夹下读取该数据文件，
而无需再次从服务器下载。

数据下载
--------

当用户第一次使用影像数据时，GMT会根据需要从服务器下载数据。
这些影像数据在GMT服务器上不是以单个文件的形式存放，而是被分成了多个小块，
当用户需要绘制某个区域的高分辨率影像时，GMT会自动下载该区域的所有区块的影像数据，
然后合并成单个网格数据供用户使用。这样可以极大减小数据下载量。

使用方法
--------

当需要使用影像数据时，可以直接通过 **@earth_day_**\ *res* 或者 **@earth_day_**\ *res* 的形式调用这些
影像起伏数据，其中 *res* 表示网格文件的分辨率。如果命令中使用了 **-R** 选项，
则只会读取该区域内的影像起伏数据。例如：

查看60弧分的影像数据的信息::

    gmt grdinfo @earth_day_60m

使用15弧分影像起伏数据绘制全球影像图::

    gmt grdimage -JH15c @earth_day_15m -pdf map

使用2弧分影像起伏数据绘制一个区域的影像图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_day_02m -pdf map

缓存空间问题
------------

你可以使用多种方式来控制你的缓存目录所占用的空间大小：

#. 通过参数 :term:`GMT_DATA_SERVER_LIMIT` 设置允许下载的单个文件的大小上限，默认无限制；
#. 可以通过 **gmt clear data** 命令清空整个数据缓存目录

技术细节
--------


数据来源及引用
--------------

#. Blue Marble [https://visibleearth.nasa.gov/images/57752/blue-marble-land-surface-shallow-water-and-shaded-topography].
#. Black Marble: [https://earthobservatory.nasa.gov/features/NightLights/page3.php].
