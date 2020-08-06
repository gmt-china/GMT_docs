earth_mask : 地表掩码数据
===============================================

.. gmtplot::
    :show-code: false
    :width: 80%
    :caption: 地表掩码数据

    gmt grdimage @earth_mask_20m -png,pdf earth-mask

介绍
----

所谓的地表掩码数据，指明了地表的水陆地理特征。
该网格数据的Z值只有5个值。
这5个值从0到4依次指代海洋（ocean）、陆地（land）、湖泊（lake）、湖中岛（island-in-lake）和岛中湖（pond-in-island-in-lake）。
该影像数据也分不同的精度，从15弧秒到1弧度不等。

下表列出了GMT提供的昼夜卫星影像的名称、分辨率以及文件大小。

====================== ========= ========
数据名称                 分辨率      大小
====================== ========= ========
``earth_mask_01d``     1 弧度      20 KB
``earth_mask_30m``     30 弧分     24 KB
``earth_mask_20m``     20 弧分     30 KB
``earth_mask_15m``     15 弧分     35 KB
``earth_mask_10m``     10 弧分     57 KB
``earth_mask_06m``     6 弧分      106 KB
``earth_mask_05m``     5 弧分      117 KB
``earth_mask_04m``     4 弧分      149 KB
``earth_mask_03m``     3 弧分      209 KB
``earth_mask_02m``     2 弧分      393 KB
``earth_mask_01m``     1 弧分      998 KB
``earth_mask_30s``     30 弧秒     2.6 MB
``earth_mask_15s``     15 弧秒     7.5 MB
====================== ========= ========

使用方法
--------

使用时，通过 **@earth_mask_**\ *res* 的形式调用。
其中 *res* 表示网格文件的分辨率。
如果命令中使用了 **-R** 选项，则只会绘制该区域内的数据。

查看30弧分的地表掩码数据的信息::

    gmt grdinfo @earth_mask_30m

使用15弧分的地表掩码数据绘制全球影像图::

    gmt grdimage -JH15c @earth_mask_15m -pdf map

使用2弧分的地表掩码数据绘制一个区域的影像图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_mask_02m -pdf map

如果用户希望仅仅获得海洋或者水陆的掩码，需要使用 grdmath 模块来调整这个掩码。
下面给出一些例子。利用 grdmath，掩码数据 earth_mask_01m 中大于（GT） 0 的为 1, 其余为 0。这就意味着海洋部分改为0，其余均为1::

    gmt grdmath @earth_mask_01m 0 GT = ocean_land.grd

To make a pixel-registered mask that has NaNs on land and 1 in the oceans, use::

    gmt grdmath @earth_mask_01m 0 LE 0 NAN = land_NaN.grd

Finally, to make a pixel-registered mask that is 1 for lakes and NaN elsewhere, try::

    gmt grdmath @earth_mask_01m 2 EQ 0 NAN = lakes_and_NaN.grd

技术细节
--------

-   数据会自动下载并保存到 **~/.gmt/server/earth/earth_mask** 目录下
