ogr2ogr
-------

`GDAL <https://gdal.org/>`__ 是一个光栅和矢量地理空间数据格式的转换库。
其支持几十种地理矢量数据格式之间互相转换，见\ `矢量格式列表 <https://gdal.org/drivers/vector/index.html>`__\ 。
例如，OGR/GMT（即 GMT）、Shapefile 、KML、MapInfo、Excel 等格式。 

GDAL 提供的 ``ogr2ogr`` 命令可以实现这几十种地理矢量数据格式之间的互相转换。
因而，可以用其将任意地理矢量数据格式转换为 GMT 可识别的 OGR/GMT 格式，以供 GMT 直接使用。
该命令的基本用法是：

::

    ogr2ogr -f GMT 输出数据文件名 输入数据文件名

例如，将 Shapefile 格式的数据文件 :file:`gadm36_USA_0.shp` 转换为 GMT 可识别的 OGR/GMT 格式，
输出文件名为 :file:`gadm36_USA_0.gmt`\ 。

::

    ogr2ogr -f GMT gadm36_USA_0.gmt gadm36_USA_0.shp

该命令还有更多选项可以用于控制数据转换的细节，详情请参考
`ogr2ogr 官方文档 <https://gdal.org/programs/ogr2ogr.html#ogr2ogr>`__\ 。
