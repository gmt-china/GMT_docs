GADM: 全球行政区划数据库
========================

**GADM主页**\ ：https://gadm.org/

GADM，全称Database of Global Administrative Areas，是一个高精度的全球行政区划
数据库。其包含了全球所有国家和地区的国界、省界、市界、区界等多个级别的行政区划边界数据。

数据下载
--------

GADM提供了两种下载方式：

#. 下载全球所有国家和地区的所有数据 https://gadm.org/download_world.html
#. 按国家下载 https://gadm.org/download_country_v3.html

推荐只下载自己需要的国家的数据。

需要说明的是，GADM 中对country 的定义为
“any entity with `an ISO country code <http://zh.wikipedia.org/wiki/ISO_3166-1>`_\ ”。
因而如果想要下载完整的中国数据，实际上需要下载China、Hong Kong、Macao和Taiwan
四个数据。

数据格式及转换
--------------

对于每个数据，GADM提供了5种不同的格式：

- Geopackage：可以被GDAL/OGR、ArcGIS、QGIS等软件读取
- Shapefile：可直接用于ArcGIS等软件
- KMZ：可直接在Google Earth中打开
- R (sp)：可直接用于R语言绘图
- R (sf)：可直接用于R语言绘图

如果在安装GMT时，GMT已经正确链接了GDAL库，则Shapefile格式的数据可以直接用于绘图。
实际绘图时，可能只想要一小部分数据（比如某个省的省界），这种情况下，则需要将
数据转换成纯文本文件，以方便从数据中提取出需要的部分。

GDAL 的 `ogr2ogr <https://www.gdal.org/ogr2ogr.html>`_ 可以实现多种地理数据
格式之间的互相转换。该软件的安装及介绍见
`GDAL/OGR: 地理空间数据格式转换神器 <https://gmt-china.org/blog/gdal-ogr/>`_\ 。
本文使用的是 GDAL 2.4.0，其他版本的GDAL可能用法略有不同。

Geopackage转GMT
~~~~~~~~~~~~~~~

以China数据为例，解压得到文件 ``gadm36_CHN.gpkg``\ 。使用如下命令查看文件的信息::

    $ ogrinfo gadm36_CHN.gpkg
    INFO: Open of `gadm36_CHN.gpkg'
          using driver `GPKG' successful.
    1: gadm36_CHN_0 (Multi Polygon)
    2: gadm36_CHN_1 (Multi Polygon)
    3: gadm36_CHN_2 (Multi Polygon)
    4: gadm36_CHN_3 (Multi Polygon)

可以看到Geopackage文件中包含了四个文件，使用如下命令（注意其中的一对单引号）
将其转换为GMT可识别的格式::

    ogr2ogr -f OGR_GMT '' gadm36_CHN.gpkg gadm36_CHN_0
    ogr2ogr -f OGR_GMT '' gadm36_CHN.gpkg gadm36_CHN_1
    ogr2ogr -f OGR_GMT '' gadm36_CHN.gpkg gadm36_CHN_2
    ogr2ogr -f OGR_GMT '' gadm36_CHN.gpkg gadm36_CHN_3

同理，对Hong Kong、Macao和Taiwan的数据做同样的处理即可。
最终得到以 ``.gmt`` 结尾的数据12个，其中 CHN 四个、HKG 两个、
MAC 三个、TWN 三个。

Shapefile转GMT
~~~~~~~~~~~~~~

以 China 数据为例，将下载的ZIP压缩包解压会得到一堆文件，其中
``gadm36_CHN_[0123].shp`` 是真正需要的4个Shapefile的数据文件。

使用如下命令即可将Shapefile转换为GMT可识别的格式::

    ogr2ogr -f OGR_GMT gadm36_CHN_0.gmt gadm36_CHN_0.shp
    ogr2ogr -f OGR_GMT gadm36_CHN_1.gmt gadm36_CHN_1.shp
    ogr2ogr -f OGR_GMT gadm36_CHN_2.gmt gadm36_CHN_2.shp
    ogr2ogr -f OGR_GMT gadm36_CHN_3.gmt gadm36_CHN_3.shp

对于 Hong Kong、Macao、Taiwan 的数据做类似操作。
最终得到以 ``.gmt`` 结尾的数据12个，其中 CHN 四个、HKG 两个、
MAC 三个、TWN 三个。

数据分级
--------

提取得到的数据文件的文件名类似 ``gadm36_CHN_0.gmt``\ ，其中 ``CHN`` 为国家/地区
代码，\ ``0`` 表示行政等级。

以中国数据为例，其数据包含了四个等级：

- 0级：即国界
- 1级：即省界
- 2级：即市界
- 3级：即区界

对于Hong Kong而言，则只包含0级和1级边界。

使用示例
--------

中国全图
~~~~~~~~

绘制中国全图需要前面提取出的四个 0 级数据。

.. literalinclude:: gadm_level0.sh

绘图效果如下：

.. figure:: gadm_level0.*
   :align: center
   :width: 80%

1 级行政区划/省界
~~~~~~~~~~~~~~~~~

代码与上面的代码几乎一样，此处使用了中国的一级数据和香港、台湾、澳门的0级数据。

.. literalinclude:: gadm_level1.sh

绘图效果如下：

.. figure:: gadm_level1.*
   :align: center
   :width: 80%

此处绘制了全国所有省的省界数据。如果只想要绘制某个省的省界数据，可以用文本编辑器
打开CHN的一级数据文件，在注释行中有清晰地标记出每段数据是哪个省的边界，因而
可以很方便地提取出来。

2 级行政区划/市界
~~~~~~~~~~~~~~~~~

2 级数据中包含了全国所有的市级边界。此处以安徽省为例，用文本编辑器打开 ``gadm36_CHN_2.gmt``\ ，
从中提取安徽相关的数据保存到文件 ``gadm36_CHN_Anhui_2.gmt`` 中，绘图效果如下：

.. literalinclude:: gadm_level2.sh

绘图效果如下：

.. figure:: gadm_level2.*
   :align: center
   :width: 40%

许可协议
--------

GADM的\ `许可协议 <https://gadm.org/license.html>`_ 表明该数据可以免费用于学术
和非商业用途，可以利用该数据绘制学术出版物的地图，但禁止重新分发或商业用途。

备注
----

GADM提供的中国国界数据不一定符合中国的领土主张，省界、市界、区界等数据也不一定
能够是最新的版本，在正式刊物中发表使用此类数据的图件时需要谨慎。
