GADM: 全球行政区划数据库
========================

**GADM主页**\ ：https://gadm.org/

GADM，全称Database of Global Administrative Areas，是一个高精度的全球行政区划
数据库。其包含了全球所有国家和地区的国界、省界、市界、区界等多个级别的行政区划边界数据。

.. warning::

    GADM提供的中国国界数据不符合中国的领土主张，省界、市界、区界等数据也不一定
    是最新的版本。在正式刊物中发表使用此类数据的图件时需格外谨慎。

数据下载
--------

GADM提供了两种下载方式：

#. 下载全球所有国家和地区的所有数据 https://gadm.org/download_world.html
#. 按国家下载 https://gadm.org/download_country_v3.html

由于全球数据量巨大，建议根据需要按照国家下载数据。

需要说明的是，GADM 中对country 的定义为
“any entity with `an ISO country code <http://zh.wikipedia.org/wiki/ISO_3166-1>`_\ ”。
因而如果想要下载完整的中国数据，实际上需要下载China、Hong Kong、Macao和Taiwan
四个数据。

由于GADM提供的中国国界数据不符合我国领土主张，本文以美国数据为例介绍数据下载及使用。

数据格式及转换
--------------

对于每个数据，GADM提供了5种不同的格式：

- Geopackage：可以被GDAL/OGR、ArcGIS、QGIS等软件读取
- Shapefile：可直接用于ArcGIS等软件
- KMZ：可直接在Google Earth中打开
- R (sp)：可直接用于R语言绘图
- R (sf)：可直接用于R语言绘图

如果在安装GMT时，GMT已经正确链接了GDAL库，则Shapefile格式的数据可以直接用于绘图。
实际绘图时，可能只想要一小部分数据（比如某个省/州的界线），这种情况下，则需要将
数据转换成纯文本文件，以方便从数据中提取出需要的部分。

GDAL 的 `ogr2ogr <https://www.gdal.org/ogr2ogr.html>`_ 可以实现多种地理数据
格式之间的互相转换。该软件的安装及介绍见
`GDAL/OGR: 地理空间数据格式转换神器 <https://gmt-china.org/blog/gdal-ogr/>`_\ 。

下面的示例使用了 GADM v3.6，在GDAL 2.4.2 和 3.1.2 下测试通过，其它版本的GDAL
也许用法略有不同。

Geopackage转GMT
~~~~~~~~~~~~~~~

以United States数据为例，解压得到文件 :file:`gadm36_USA.gpkg`\ 。使用如下命令查看文件的信息::

    $ ogrinfo gadm36_USA.gpkg
    INFO: Open of `gadm36_USA.gpkg'
          using driver `GPKG' successful.
    1: gadm36_USA_2 (Multi Polygon)
    2: gadm36_USA_1 (Multi Polygon)
    3: gadm36_USA_0 (Multi Polygon)

可以看到Geopackage文件中包含了三个文件，分别是3个不同等级的边界。
使用如下命令（注意其中的一对单引号不可省略）将其转换为GMT可识别的格式::

    ogr2ogr -f OGR_GMT '' gadm36_USA.gpkg gadm36_USA_0
    ogr2ogr -f OGR_GMT '' gadm36_USA.gpkg gadm36_USA_1
    ogr2ogr -f OGR_GMT '' gadm36_USA.gpkg gadm36_USA_2

最终得到以 :file:`.gmt` 结尾的数据3个。

Shapefile转GMT
~~~~~~~~~~~~~~

以 United States 数据为例，将下载的ZIP压缩包解压会得到
:file:`gadm36_USA_[012].shp` 3组Shapefile数据文件。

使用如下命令即可将Shapefile转换为GMT可识别的格式::

    ogr2ogr -f OGR_GMT gadm36_USA_0.gmt gadm36_USA_0.shp
    ogr2ogr -f OGR_GMT gadm36_USA_1.gmt gadm36_USA_1.shp
    ogr2ogr -f OGR_GMT gadm36_USA_2.gmt gadm36_USA_2.shp

最终得到以 :file:`.gmt` 结尾的数据3个。

数据分级
--------

提取得到的数据文件的文件名类似 :file:`gadm36_USA_0.gmt`\ ，其中 **USA** 为国家/地区
代码，\ **0** 表示行政等级。

以美国数据为例，其数据包含了三个等级：

- 0级：即国界
- 1级：即州界
- 2级：即县界

使用示例
--------

美国本土地图
~~~~~~~~~~~~

绘制美国本土地图需要前面提取出的 0 级数据。

.. literalinclude:: gadm_level0.sh

绘图效果如下：

.. figure:: gadm_level0.*
   :align: center
   :width: 80%

美国 1 级行政区划/州界
~~~~~~~~~~~~~~~~~~~~~~

代码与上面的代码几乎一样，此处使用了美国本土的1级数据。

.. literalinclude:: gadm_level1.sh

绘图效果如下：

.. figure:: gadm_level1.*
   :align: center
   :width: 80%

此处绘制了美国本土48个州的州界数据。如果只想要绘制某个州，可以用文本编辑器
打开USA的1级数据文件，在注释行中有清晰地标记出每段数据是哪个州的边界，因而
可以很方便地提取出来。

也可以利用如下命令将某个州界从Shapefile中提取出来::

    ogr2ogr -f OGR_GMT Alabama.gmt gadm36_USA_1.shp -where "NAME_1 = 'ALABAMA'"

美国 2 级行政区划/县界
~~~~~~~~~~~~~~~~~~~~~~

2 级数据中包含了美国所有的县级边界。此处以Alabama州为例，用上述方法在USA的2级数据文件
中提取该州的州界和县界 :file:`Alabama.gmt`\ ，绘图效果如下：

.. literalinclude:: gadm_level2.sh

绘图效果如下：

.. figure:: gadm_level2.*
   :align: center
   :width: 40%

许可协议
--------

GADM的\ `许可协议 <https://gadm.org/license.html>`_ 表明该数据可以免费用于学术
和非商业用途，可以利用该数据绘制学术出版物的地图，但禁止重新分发或商业用途。
