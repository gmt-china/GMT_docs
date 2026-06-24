.. index:: ! kml2gmt

kml2gmt
=======

:官方文档: :doc:`gmt:kml2gmt`
:简介: 将Google Earth的KML文件转换为GMT表数据

该模块可以将 KML 文件中包含的点、线或多边形导出为 GMT 可用的格式。

.. note::

   KMZ 文件本质上是一个 ZIP 压缩包，其中包含了一个 KML 文件以及若干个辅助文件。
   可以将 KMZ 文件解压得到 KML 文件，再使用该模块进行转换。

必选选项
--------

``<kmlfiles>``
    要转换的KML文件

可选选项
--------

``-F[s|l|p]``
    指定要输出的数据类型。默认会输出KML中包含的所有点、线或多边形

    #. ``-Fs`` 只输出点
    #. ``-Fl`` 只输出线
    #. ``-Fp`` 只输出多边形

``-Z``
    默认只输出经纬度信息，若使用 ``-Z`` 选项，则输出坐标的高程信息作为GMT的Z值

示例
----

从 KML 文件中提取所有经纬度信息::

    gmt kml2gmt google.kml -V > google.txt

从一个KML文件中分别提取点和多边形到不同的文件::

    gmt kml2gmt google.kml -Fp -V > polygons.txt
    gmt kml2gmt google.kml -Fs -V > points.txt

也可以直接用外部命令 ``ogr2ogr`` 实现转换::

    ogr2ogr -f "GMT" somefile.gmt somefile.kml
