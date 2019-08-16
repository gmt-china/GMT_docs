earth_relief: 全球地形起伏数据
==============================

地形起伏数据简介
----------------

GMT提供了从1弧秒到60弧分的多种不同精度的全球地形起伏网格数据供用户使用。

+----------------------+---------+--------+------------------------+
| 地形数据名称         | 精度    | 大小   | 说明                   |
+======================+=========+========+========================+
| ``earth_relief_60m`` | 60 弧分 | 112 KB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_30m`` | 30 弧分 | 377 KB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_20m`` | 20 弧分 | 783 KB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_15m`` | 15 弧分 | 1.4 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_10m`` | 10 弧分 | 2.9 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_06m`` |  6 弧分 | 7.5 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_05m`` |  5 弧分 |  11 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_04m`` |  4 弧分 |  16 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_03m`` |  3 弧分 |  28 MB | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_02m`` |  2 弧分 |  58 MB | ETOPO2v2冰层表面       |
+----------------------+---------+--------+------------------------+
| ``earth_relief_01m`` |  1 弧分 | 214 MB | ETOPO1冰层表面         |
+----------------------+---------+--------+------------------------+
| ``earth_relief_30s`` | 30 弧秒 | 778 MB | SRTM30+                |
+----------------------+---------+--------+------------------------+
| ``earth_relief_15s`` | 15 弧秒 | 2.6 GB | SRTM15+                |
+----------------------+---------+--------+------------------------+
| ``earth_relief_03s`` |  3 弧秒 | 6.8 GB | SRTM3S                 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_01s`` |  1 弧秒 |  41 GB | SRTM1S                 |
+----------------------+---------+--------+------------------------+
| ``srtm_relief_03s``  |  3 弧秒 | 6.8 GB | SRTM3S（仅限陆地）     |
+----------------------+---------+--------+------------------------+
| ``srtm_relief_01s``  |  1 弧秒 |  41 GB | SRTM1S（仅限陆地）     |
+----------------------+---------+--------+------------------------+

这些地形起伏数据保存在GMT的服务器上。当用户\ **第一次**\ 使用某个精度的
地形起伏数据时，GMT会自动从服务器上下载该数据文件，
并保存到GMT的缓存文件夹下（由 :ref:`DIR_CACHE <DIR_CACHE>` 控制，默认为 ``~/.gmt/server`` 目录），
然后再读取该文件。以后再使用该数据时，GMT会自动从缓存文件夹下读取该数据文件，
而无需再次从服务器下载。

.. tip::

    由于第一次使用地形数据时，GMT需要从服务器下载数据，通常会需要很长时间。
    建议用户可以在闲置时提前将精度为15弧秒到60弧秒的地形数据下载到自己的计算机上。

    Linux和macOS用户可以执行如下批量下载脚本::

        for res in 60m 30m 20m 15m 10m 06m 05m 04m 03m 02m 01m 30s 15s; do
            gmt which -Gu @earth_relief_${res}
        done

    Windows用户可以打开CMD执行如下批量下载命令::

        for %%i in (60m 30m 20m 15m 10m 06m 05m 04m 03m 02m 01m 30s 15s) do (
            gmt which -Gu @earth_relief_%%i
        )

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
#. 可以通过 ``gmt clear data`` 命令清空整个数据缓存目录

技术细节
--------

-   3弧分及更低分辨率的全球地形数据均是NOAA ETOPO1全球地形起伏网格数据的
    衍生产品。GMT利用球面高斯滤波对其进行重采样以防止混叠现象。
    可以使用 :doc:`/module/grdinfo` 查看生成网格文件所使用的滤波命令。
-   2弧分的数据直接使用了NOAA提供的ETOPO2v2文件（冰层表面版本）。30弧秒和15弧秒的
    数据来自于SRTM30+和SRTM15+。
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

#. ETOPO2v2: https://dx.doi.org/10.7289/V5J1012Q.
#. ETOPO1:
   Amante, C., and B. W. Eakins (2008),
   ETOPO1 1 arc-minute global relief model: Procedures, data sources and analysis,
   National Geophysical Data Center, Boulder, CO.
   `原始数据下载链接 <https://www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/ice_surface/grid_registered/netcdf/ETOPO1_Ice_g_gmt4.grd.gz>`__
#. SRTM30+:
   Becker, J. J., et al. (2009),
   Global Bathymetry and Elevation Data at 30 Arc Seconds Resolution: SRTM30_PLUS,
   Marine Geodesy, 32, 355-371.
   `原始数据下载链接 <ftp://topex.ucsd.edu/pub/srtm30_plus/topo30/topo30.grd>`__
#. SRTM15+:
   Olson, C. L., J. J. Becker, and D. T. Sandwell (2014),
   A new global bathymetry map at 15 arcsecond resolution for resolving seafloor fabric: SRTM15_PLUS,
   in Eos Trans. AGU, edited, pp. Abstract OS34A-03
   `原始数据下载链接 <ftp://topex.ucsd.edu/pub/srtm15_plus/topo15.grd>`__
#. SRTMGL3数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl3_v003
#. SRTMGL1数据: https://lpdaac.usgs.gov/dataset_discovery/measures/measures_products_table/srtmgl1_v003
