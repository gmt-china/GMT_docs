earth_relief: 全球地形起伏数据
==============================

地形起伏数据简介
----------------

GMT提供了从1弧秒到60弧分的多种不同精度的全球地形起伏网格数据供用户使用。

====================== ========= ========
地形数据名称           精度      大小
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

这些地形起伏数据保存在GMT的服务器上。当用户\ **第一次**\ 使用某个精度的
地形起伏数据时，GMT会自动从服务器上下载该数据文件，
并保存到GMT的缓存文件夹下（由 :ref:`DIR_CACHE <DIR_CACHE>` 控制，默认为 ``~/.gmt/server`` 目录），
然后再读取该文件。以后再使用该数据时，GMT会自动从缓存文件夹下读取该数据文件，
而无需再次从服务器下载。

.. tip::

    由于第一次使用地形数据时，GMT需要从服务器下载数据，通常会需要很长时间。
    建议用户可以在闲置时提前将精度为15弧秒到1户分的地形数据下载到自己的计算机上。

    可以复制并执行如下命令以下载不同精度的地形数据::

        gmt which -Gu @earth_relief_01d
        gmt which -Gu @earth_relief_30m
        gmt which -Gu @earth_relief_20m
        gmt which -Gu @earth_relief_15m
        gmt which -Gu @earth_relief_10m
        gmt which -Gu @earth_relief_06m
        gmt which -Gu @earth_relief_05m
        gmt which -Gu @earth_relief_04m
        gmt which -Gu @earth_relief_03m
        gmt which -Gu @earth_relief_02m
        gmt which -Gu @earth_relief_01m
        gmt which -Gu @earth_relief_30s
        gmt which -Gu @earth_relief_15s

    不建议提前下载1弧秒和3弧秒的地形数据，主要原因在于，这两套数据占据硬盘空间太大。
    基于同样的理由，GMT服务器上这两套数据不是以单个文件的形式存放，而是被分成了多个小块，
    当用户需要绘制某个区域的高精度地形时，GMT会自动下载该区域的所有区块的地形数据，
    然后合并成单个网格数据供用户使用。

使用方法
--------

当需要使用地形数据时，可以直接通过 **@earth_relief_**\ *res* 的形式调用这些
地形起伏数据，其中 *res* 表示网格文件的精度。如果命令中使用了 **-R** 选项，
则只会读取该区域内的地形起伏数据。

使用示例::

    gmt grdinfo @earth_relief_60m

    gmt grdimage -JH15c @earth_relief_15m -pdf map

缓存空间问题
------------

你可以使用多种方式来控制你的缓存目录所占用的空间大小：

#. 通过参数 :ref:`GMT_DATA_SERVER_LIMIT <GMT_DATA_SERVER_LIMIT>` 设置缓存目录空间大小的上限，默认无限制；
#. 可以通过 **gmt clear data** 命令清空整个数据缓存目录

技术细节
--------

-   15弧秒的数据来源于 SRTM15+V2 [http://dx.doi.org/10.1029/2019EA000658]
-   30弧秒及更低分辨率的全球地形数据均是SRTM15+V2 的衍生产品。
    GMT利用笛卡尔高斯滤波对其进行重采样以防止混叠现象。
    可以使用 :doc:`/module/grdinfo` 查看生成网格文件所使用的滤波命令。
-   3弧秒和1弧秒的数据来自于NASA提供的SRTM数据。数据被划为为1度x1度的区块。
    在使用时，GMT会根据 **-R** 选项指定的区域范围只下载区域内的地形数据。
-   原始的SRTM3和SRTM1数据只在北纬60度到南纬60度的陆地上有数据。
    当使用 **@earth_relief_01s** 或 **@earth_relief_03s** 时，GMT会自动对
    **@earth_relief_15s** 数据对增采样以填充缺失的海洋部分。
-   如果想使用最原始的只包含陆地的SRTM地形数据，则可以使用 **@srtm_relief_03s**
    或 **srtm_relief_01s**\ 。
-   所有的网格文件都是网格线配准的。网格文件采用了更高效的文件格式，使得其文件大小
    远小于原始文件的大小，且完全保持数据精度。对于3弧秒和1弧秒的数据，是以JPEG2000
    图片格式保存在GMT服务器上的，一旦数据下载到本地目录中，则会被转换为压缩的netCDF4
    格式，这一步通过GDAL来实现，且要求GDAL支持openjpeg。

数据来源及引用
--------------

#. SRTM15+V2 [http://dx.doi.org/10.1029/2019EA000658]
#. SRTMGL3数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl3_v003
#. SRTMGL1数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl1_v003
