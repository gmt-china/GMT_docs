Shapefile格式
-------------

`Shapefile <https://en.wikipedia.org/wiki/Shapefile>`_ 格式是由 ESRI 开发的一种
空间数据开放格式，其可以描述点、线与多边形等。

需要注意的是，一个shapefile文件通常至少包含三个文件，分别是 .shp、.shx 和 .dbf
文件，此外还可能包含其它可选的文件。

GMT可以直接读取shapefile文件格式（严格说，是先利用 **ogr2ogr** 命令将shapefile
文件转换为GMT可识别的GMT/OGR格式再读入）。默认情况下，只读入地理坐标数据。
若想要读入其它非空间字段，则需要使用 :doc:`/option/a`\ 。
