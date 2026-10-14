Shapefile格式
-------------

`Shapefile <https://en.wikipedia.org/wiki/Shapefile>`_ 格式是由 ESRI 开发的一种
空间数据开放格式，其可以描述点、线与多边形等。

需要注意的是，一个 Shapefile 文件通常至少包含三个文件，分别是 .shp、.shx 和 .dbf
文件，此外还可能包含其它可选的文件。

GMT 可以直接读取 Shapefile 文件格式（严格说，是先利用 :ref:`ogr2ogr <ogr2ogr>`
命令将 Shapefile 文件转换为 GMT 可识别的 OGR/GMT 格式再读入）。
默认情况下，只读入地理坐标数据。若想要读入其它非空间字段，则需要使用 :doc:`/option/a`。
