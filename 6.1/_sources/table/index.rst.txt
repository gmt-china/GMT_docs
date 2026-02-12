表数据
======

表数据，也称为列数据或多列数据，英文为table data，可用于表征点、线和多边形等。

GMT支持多种不同格式的表数据：

- ASCII表
- 二进制表
- netCDF表
- shapefile 格式
- GMT/OGR 格式

其它格式的文件，也可以利用GDAL提供的 ``ogr2ogr`` 命令转换为GMT可识别的
GMT/OGR格式。

最常用的表数据格式是ASCII表，其具有直观、可直接编辑的特点；
二进制表和netCDF表相对不直观，但通常文件大小更小。

.. toctree::
   :maxdepth: 2

   ascii
   binary
   netcdf
   shapefile
   ogrgmt
   ogr2ogr
