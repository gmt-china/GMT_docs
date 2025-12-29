:author: 田冬冬, 周茂, 朱邓达
:date: 2025-10-31
.. index:: ! kml2gmt
.. program:: kml2gmt
.. include:: common_SYN_OPTs.rst_

kml2gmt
=======

:官方文档: :doc:`gmt:kml2gmt`
:简介: 将Google Earth的KML文件转换为GMT表数据

**kml2gmt** 模块读取 Google Earth KML 文件，并输出GMT可识别的表数据。
仅支持包含点、线或多边形的KML文件。

.. note::

   KMZ 文件本质上是一个 ZIP 压缩包，其中包含了一个 KML 文件以及若干个辅助文件。
   可以将 KMZ 文件解压得到 KML 文件，再使用该模块进行转换。

语法
----

**gmt kml2gmt** [ *kmlfiles* ]
[ :option:`-E` ]
[ :option:`-F`\ **s**\|\ **l**\|\ **p** ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z` ]
[ :option:`-bo`\ *binary* ]
[ :option:`-do`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

必选选项
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

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

从 KML 文件中提取所有经纬度信息::

    gmt kml2gmt google.kml -V > google.txt

从一个KML文件中分别提取点和多边形到不同的文件::

    gmt kml2gmt google.kml -Fp -V > polygons.txt
    gmt kml2gmt google.kml -Fs -V > points.txt

也可直接用GDAL提供的命令 **ogr2ogr** 实现转换::

    ogr2ogr -f "GMT" somefile.gmt somefile.kml

相关模块
--------

:doc:`img2google`,
:doc:`psconvert`,
:doc:`gmt2kml`,
:doc:`spatial`
