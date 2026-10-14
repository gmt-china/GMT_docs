:author: 田冬冬, 周茂, 朱邓达, 陈箫翰
:date: 2026-01-04

.. index:: ! kml2gmt
.. program:: kml2gmt

kml2gmt
=======

:官方文档: :doc:`gmt:kml2gmt`
:简介: 将Google Earth的KML文件转换为GMT表数据

**kml2gmt** 模块读取 Google Earth KML 文件，并输出GMT可识别的表数据。
仅支持包含点、线或多边形的KML文件。

.. note::

   KMZ 文件本质上是一个 ZIP 压缩包，其中包含了一个 KML 文件以及若干个辅助文件。
   可以将 KMZ 文件解压得到 KML 文件，再使用该模块进行转换。

本模块只进行基础操作，提取坐标以及每个特征可能存在的名称和描述标签。
其主要用途是捕获在 Google Earth 中修改过的坐标，然后将修改后的数据重新插入到原始 GMT 数据文件中。
若要进行更完整的格式转换，请考虑使用 GDAL 提供的命令 **ogr2ogr** ::

    ogr2ogr -f "GMT" somefile.gmt somefile.kml

语法
----

**gmt kml2gmt**
[ *kmlfiles* ]
[ :option:`-E` ]
[ :option:`-F`\ **s**\|\ **l**\|\ **p** ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z` ]
[ :option:`-bo`\ *binary* ]
[ :option:`-do`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-h`\ *headers* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*kmlfiles*
    要转换的KML文件

可选选项
--------

.. option:: -E

**-E**
    从 *ExtendData* 属性中获取高程信息，且忽略 *z* 坐标。

    KML提供了多种机制来通过 *ExtendData* 储存信息，但GMT只实现了
    *<SimpleData name="string">* 一种。该选项会自动启动 :option:`-Z` 选项。

.. option:: -F

**-F**\ **s**\|\ **l**\|\ **p**
    指定要输出的特征类型。默认会输出KML中包含的所有点、线或多边形

    - **-Fs** 只输出点
    - **-Fl** 只输出线
    - **-Fp** 只输出多边形

.. option:: -Z

**-Z**
    默认只输出经纬度信息，若使用该选项，则输出坐标的高程信息作为GMT的Z值

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-h.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

备注
--------

如果多边形同时拥有外围轮廓（perimeters）和内孔（holes），建议将输出通过 :doc:`spatial` **-Sh** 处理。
该命令将确定哪些多边形是外围轮廓，哪些是内孔，并对它们进行组织，使任何内孔都紧随其外围轮廓之后，且其段头将包含 **-Ph** 标志并具有相反的手性。
此输出可由 :doc:`plot` 绘制，内孔将得到正确识别。

示例
----

从 KML 文件中提取所有经纬度信息::

    gmt kml2gmt google.kml -V > google.txt

从一个 KML 文件中分别提取点和多边形到不同的文件::

    gmt kml2gmt google.kml -Fp -V > polygons.txt
    gmt kml2gmt google.kml -Fs -V > points.txt

相关模块
--------

:doc:`img2google`,
:doc:`psconvert`,
:doc:`gmt2kml`,
:doc:`spatial`
