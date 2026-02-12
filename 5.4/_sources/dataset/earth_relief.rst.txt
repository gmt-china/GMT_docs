earth_relief: 全球地形起伏数据
==============================

地形起伏数据简介
----------------

GMT提供了从15弧秒到60弧分的多种不同精度的全球地形起伏网格数据供用户使用。

+----------------------+---------+--------+------------------------+
| 地形数据名称         | 精度    | 大小   | 说明                   |
+======================+=========+========+========================+
| ``earth_relief_60m`` | 60 弧分 | 112 Kb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_30m`` | 30 弧分 | 377 Kb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_20m`` | 20 弧分 | 783 Kb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_15m`` | 20 弧分 | 1.4 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_10m`` | 10 弧分 | 2.9 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_06m`` |  6 弧分 | 7.5 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_05m`` |  5 弧分 |  11 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_04m`` |  4 弧分 |  16 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_03m`` |  3 弧分 |  28 Mb | ETOPO1高斯球面滤波得到 |
+----------------------+---------+--------+------------------------+
| ``earth_relief_02m`` |  2 弧分 |  58 Mb | ETOPO2v2冰层表面       |
+----------------------+---------+--------+------------------------+
| ``earth_relief_01m`` |  1 弧分 | 214 Mb | ETOPO1冰层表面         |
+----------------------+---------+--------+------------------------+
| ``earth_relief_30s`` | 30 弧秒 | 778 Mb | SRTM30+                |
+----------------------+---------+--------+------------------------+
| ``earth_relief_15s`` | 15 弧秒 | 2.6 Gb | SRTM15+                |
+----------------------+---------+--------+------------------------+

这些数据保存在GMT的 `FTP服务器 <ftp://ftp.soest.hawaii.edu/gmt/data/>`_ 上
（\ `国内镜像 <http://mirrors.ustc.edu.cn/gmt/data/>`_\ ）。
当用户第一次使用某个精度的地形起伏数据时，GMT会自动从服务器上下载该数据文件，
并保存到GMT的缓存文件夹下（由 :ref:`DIR_CACHE <DIR_CACHE>` 控制，默认为 ``~/.gmt/server`` 目录），
然后再读取该文件。以后再使用该数据时，GMT会自动从缓存文件夹下读取该数据文件，
而无需再次从服务器下载。

建议用户自行手动下载所有的地形起伏数据并将数据放在 ``~/.gmt/server`` 下，以免
绘图时第一次使用地形数据下载耗时太久，耽误绘图。

使用方法
--------

当需要使用地形数据时，可以直接通过 ``@earth_relief_<res>`` 的形式调用这些
地形起伏数据，其中 ``<res>`` 表示网格文件的精度。如果命令中使用了 ``-R`` 选项，
则只会读取该区域内的地学起伏数据。

使用示例::

    gmt grdinfo @earth_relief_60m

    gmt grdimage -Rg -JH15c @earth_relief_05m -Cglobe > map.ps

缓存空间问题
------------

可以通过 ``gmt clear cache`` 命令清理整个缓存目录以控制你的缓存目录所占用的空间大小。

技术细节
--------

如上表所示，3弧分及更低分辨率的全球地形数据均是NOAA ETOPO1全球地形起伏网格数据的
衍生产品。GMT利用球面高斯滤波对其进行重采样以防止混叠现象。使用::

    gmt grdinfo @earth_relief_60m

可以在输出中看到生成这些网格文件所使用的滤波命令。

2弧分的数据直接使用了NOAA提供的ETOPO2v2文件（冰层表面版本）。30弧秒和15弧秒的
数据来自于SRTM30+和SRTM15+。

所有的网格文件都是网格线配准的。网格文件采用了更高效的文件格式，使得其文件大小
远小于原始文件的大小，且完全保持数据精度。

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
