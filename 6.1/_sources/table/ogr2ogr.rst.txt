用ogr2ogr实现数据转换
---------------------

`GDAL <https://gdal.org/>`_ 是一个光栅和矢量地理空间数据格式的转换库。其
支持在几十种不同格式的地理矢量数据格式之间互相转换。GDAL支持的所有地理空间
矢量数据格式见: https://gdal.org/drivers/vector/index.html\ ，其中就包括
GMT能够识别的OGR/GMT格式。GDAL提供的 **ogr2ogr** 命令可以实现这几十种格式之间的
互相转换，因而可以将任意数据格式转换为GMT可识别的OGR/GMT格式，以供GMT直接使用。

**ogr2ogr** 的基本用法是::

    ogr2ogr -f GMT 输出数据文件名 输入数据文件名

例如::

    ogr2ogr -f GMT gadm36_USA_0.gmt gadm36_USA_0.shp

就是将输入数据 gadm36_USA_0.shp 转换为GMT可识别的 OGR/GMT 格式，输出保存到
文件 gadm36_USA_0.gmt 中。

**ogr2ogr** 还有更多选项以控制数据转换中的细节，详情见 **ogr2ogr** 官方文档。
