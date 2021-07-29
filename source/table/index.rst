表数据
======

表数据（table data）用于表征点、线以及多边形等，也称列数据或多列数据。
GMT 支持多种格式的表数据：

.. toctree::
   :maxdepth: 1

   ascii
   binary
   netcdf
   shapefile
   ogrgmt

ASCII 表格式最常用，因为其较直观，且可直接编辑。
二进制表和 netCDF 表相对不直观，但文件大小更小。

.. note::

   GDAL 提供的 :ref:`ogr2ogr <ogr2ogr>` 命令可以将其它格式的表数据转换为
   GMT 可识别的 OGR/GMT 格式。
