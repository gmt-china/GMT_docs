earth_relief: 全球地形起伏数据
==============================

.. gmtplot::
   :show-code: false
   :width: 75%

   gmt grdimage @earth_relief_20m -png,pdf earth_relief

数据简介
--------

GMT对公开的全球地形起伏数据进行预处理，并提供了从1弧秒到1弧度的
多种不同分辨率的全球地形起伏网格数据供GMT用户使用。
下表列出了GMT提供的地形数据的名称、分辨率以及文件大小。

====================== ========= ========
地形数据名称           分辨率    大小
====================== ========= ========
``earth_relief_01d``   1 弧度    112 KB
``earth_relief_30m``   30 弧分   377 KB
``earth_relief_20m``   20 弧分   783 KB
``earth_relief_15m``   15 弧分   1.4 MB
``earth_relief_10m``   10 弧分   2.9 MB
``earth_relief_06m``   6 弧分    7.5 MB
``earth_relief_05m``   5 弧分     11 MB
``earth_relief_04m``   4 弧分     16 MB
``earth_relief_03m``   3 弧分     28 MB
``earth_relief_02m``   2 弧分     58 MB
``earth_relief_01m``   1 弧分    214 MB
``earth_relief_30s``   30 弧秒   778 MB
``earth_relief_15s``   15 弧秒   2.6 GB
``earth_relief_03s``   3 弧秒    6.8 GB
``earth_relief_01s``   1 弧秒     41 GB
``srtm_relief_03s``    3 弧秒    6.8 GB
``srtm_relief_01s``    1 弧秒     41 GB
====================== ========= ========

使用方法
--------

当需要使用地形数据时，可以直接通过 **@earth_relief_**\ *res* 的形式调用这些
地形起伏数据，其中 *res* 表示网格文件的分辨率。如果命令中使用了 **-R** 选项，
则只会读取该区域内的地形起伏数据。例如：

查看60弧分的地形数据的信息::

    gmt grdinfo @earth_relief_60m

使用15弧分地形起伏数据绘制全球地形图::

    gmt grdimage -JH15c @earth_relief_15m -pdf map

使用2弧分地形起伏数据绘制一个区域的地形图::

    gmt grdimage -JH15c -R90/120/20/60 @earth_relief_02m -pdf map

技术细节
--------

-   15弧秒的数据来源于 SRTM15+ [http://dx.doi.org/10.1029/2019EA000658]
-   30弧秒及更低分辨率的全球地形数据均是SRTM15+ 的衍生产品。
    GMT利用笛卡尔高斯滤波对其进行重采样以防止混叠现象，并保留了原始15弧秒数据的
    纬度依赖的分辨率信息。
    可以使用 :doc:`/module/grdinfo` 查看生成网格文件所使用的滤波命令。
-   3弧秒和1弧秒的数据来自于NASA提供的SRTM数据。数据被划为为1度x1度的区块。
    在使用时，GMT会根据 **-R** 选项指定的区域范围只下载区域内的地形数据。
-   原始的SRTM3和SRTM1数据只在北纬60度到南纬60度的陆地上有数据。
    当使用 **@earth_relief_01s** 或 **@earth_relief_03s** 时，GMT会自动对
    **@earth_relief_15s** 数据对增采样以填充缺失的海洋部分。
-   如果想使用最原始的只包含陆地的SRTM地形数据，则可以使用 **@srtm_relief_03s**
    或 **srtm_relief_01s**\ 。
-   所有的网格文件都是网格线配准的。网格文件采用了更高效的文件格式，使得其文件大小
    远小于原始文件的大小，且完全保持数据分辨率。对于3弧秒和1弧秒的数据，是以JPEG2000
    图片格式保存在GMT服务器上的，一旦数据下载到本地目录中，则会被转换为压缩的netCDF4
    格式，这一步通过GDAL来实现，且要求GDAL支持openjpeg。

数据来源及引用
--------------

#. SRTM15 [http://dx.doi.org/10.1029/2019EA000658]
#. SRTMGL3数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl3_v003
#. SRTMGL1数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl1_v003
