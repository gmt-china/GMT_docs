GDAL
====

`GDAL <https://gdal.org/>`__\（**G**\ eospatial **D**\ ata **A**\ bstraction **L**\ ibrary）
是光栅（raster）和矢量（vector）地理空间数据格式的转换库/工具，
支持多种光栅或矢量地理空间数据格式的互相转换和处理。

简介
----

历史上，GDAL 仅用于处理光栅地理空间数据，而 OGR 则仅用于处理矢量地理空间数据。
自 GDAL 2.0 开始，二者集成在一起了，一般统称为 GDAL 或 GDAL/OGR。
因此，GDAL 现在具备了处理光栅和矢量地理空间数据格式的能力。

.. note::

    若无显式说明，本手册提到 GDAL 和 GDAL/OGR 时，表示同一个意思；
    提到 OGR 时，仅表示地理空间矢量数据格式。

GDAL/OGR 有两个核心部分：

- GDAL 部分：支持多种光栅地理空间数据格式的互相转换，
  如常见的 netCDF、GeoTiff、HDF5、XYZ 等，
  详见\ `光栅格式列表 <https://gdal.org/drivers/raster/index.html>`__
- OGR 部分：支持多种矢量数据格式的互相转换，
  如常见的 OGR/GMT（即 GMT）、Shapefile 、KML、MapInfo、Excel 等，
  详见\ `矢量格式列表 <https://gdal.org/drivers/vector/index.html>`__

安装
----

《:doc:`GMT 安装 </install/index>`》中介绍了各种操作系统下安装 GMT 的方法。
GDAL 要么已包含在 GMT 安装包中，要么作为推荐包已被安装。

.. _ogr2ogr:

ogr2ogr
-------

GDAL 提供的 ``ogr2ogr`` 命令可以实现几十种地理矢量数据格式之间的互相转换。
因而，可以用其将任意地理矢量数据格式转换为 GMT 可识别的 OGR/GMT 格式，以供 GMT 直接使用。
该命令的详细用法请参考 `ogr2ogr 官方文档 <https://gdal.org/programs/ogr2ogr.html>`__，
这里仅介绍该命令的基本用法::

    $ ogr2ogr -f GMT 输出数据文件名 输入数据文件名

例如，将 Shapefile 格式的数据文件 :file:`gadm36_USA_0.shp` 转换为 GMT 可识别的 OGR/GMT 格式，
输出文件名为 :file:`gadm36_USA_0.gmt`::

    $ ogr2ogr -f GMT gadm36_USA_0.gmt gadm36_USA_0.shp

.. _gdal_translate:

gdal_translate
--------------

GDAL 提供的 ``gdal_translate`` 命令可以实现多种地理空间光栅数据格式之间的互相转换。
该命令的详细用法请参考 `gdal_translate 官方文档 <https://gdal.org/programs/gdal_translate.html>`__，
这里只介绍该命令的基本用法::

    gdal_translate -of 格式 输入数据文件名 输出数据文件名

例如，将 GeoTiff 格式的数据文件数据 :file:`srtm_56_05.tif` 转换为 GMT 使用的 netCDF 格式::

    gdal_translate -of netCDF srtm_56_05.tif srtm_56_05.nc
