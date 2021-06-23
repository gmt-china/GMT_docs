geo3al: 中国及邻区地质图数据
============================

geo3al 数据是由 U.S. Geological Survey (USGS) 提供的中国及邻区地质图数据，
是“\ `世界地质地图 <https://certmapper.cr.usgs.gov/data/apps/world-maps/>`__\ ”的一部分，
数据分辨率为 1:5,000,000。

数据文件
--------

GMT 中文社区为 GMT 用户提供了可供 GMT 直接使用的数据文件：

- :file:`geo3al.gmt`\ ：中国及邻区地质图数据

数据中包含了如下非空间元信息：

- ``NAREA``\ ：地层多边形区域的面积
- ``PERIMETER``\ ：地层多边形区域的周长
- ``TYPE``\ ：岩性
- ``GLG``\ ：原始地图上显示地表露头的地质年代
- ``GEN_GLG``\ ：编者从 ``GLG`` 中计算得到的地质年代，在单元年龄跨越一个以上地质年龄的情况下用“代”表示

参考 :file:`geo3al.shp.xml` 以获取元信息的更多细节。

数据的具体下载地址和使用方式请见：\ :doc:`/dataset-CN/index`\ 。

示例图
------

下面的示例图绘制了中国大陆及邻区地质图。地质年代从数据的 ``GEN_GLG`` 属性中提取，
用不同的颜色表示；岩性从数据的 ``TYPE`` 属性中提取，用不同的填充图案表示。

示例代码中使用的地质年代 CPT 色标文件 :download:`geoage.cpt`
修改自 `GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`__\ 。

.. literalinclude:: geo3al.sh

.. image:: https://user-images.githubusercontent.com/3974108/123112829-0c8a0500-d40c-11eb-8991-a9bd34bd8b4a.png
   :width: 80%
   :align: center

数据来源及引用
--------------

- Steinshouer, D.W., Qiang, J., McCabe, P.J., and Ryder, R.T, 1999, Maps showing geology, oil and gas fields, and geologic provinces of the Asia Pacific region: U.S. Geological Survey Open-File Report 97-470-F, 16 p., https://doi.org/10.3133/ofr97470F.

数据转换和处理流程
------------------

*以下内容仅供数据维护者参考，一般用户无需关心。*

1.  从 “\ `World Geologic Maps <https://certmapper.cr.usgs.gov/data/apps/world-maps/>`__\ ”
    下载 “Generalized Geology of the Far East” 对应的 Shapefile 文件

2.  使用 :doc:`ogr2ogr </table/ogr2ogr>` 将 Shapefile 格式转换为 GMT 可识别的 **OGR/GMT** 格式::

        $ ogr2ogr -t_srs EPSG:4326 -f GMT geo3al.gmt geo3al.shp

    注意事项：

    - 原始数据使用的是大地坐标系统，而非 WGS84 坐标系统。因而在使用
      ``ogr2ogr`` 时需要加上 ``-t_srs EPSG:4326`` 参数进行坐标转换
    - 转换时 :file:`.dbf`\ 、\ :file:`.prj`\ 、\ :file:`.shx` 等文件必须和
      :file:`shp` 文件放在同一目录下

数据转换与处理参考了如下博文：

- `Mijian Xu <https://home.xumijian.me/>`__ 的博客：
  `用 GMT 绘制中国大陆及邻区地质年代图 <https://blog.xumijian.me/post/gmt-geo/>`__
- `Po-Chin Tseng <https://github.com/jimmytseng79>`__ 的
  `GMT5 教程：地质图 <https://jimmytseng79.github.io/GMT5_tutorials/geology_map.html>`__

扩展阅读
--------

`World Geologic Maps <https://certmapper.cr.usgs.gov/data/apps/world-maps/>`__ 提供了
全球几乎所有区域的地质图数据。本文只提供了中国及邻区地质图（即 Generalized Geology of the Far East）。
需要绘制其他地区地质图的用户可以参考本文的数据处理方式和绘图脚本。但需要注意：

- 部分原始数据使用的是经纬度坐标，因此格式转换时不需要使用 ``-t_srs EPSG:4326``
- 每个数据提供的属性可能不同。用户应查阅从源文件中解压得到的 ``.xml`` 文件
  以了解数据提供的数学，并相应修改绘图脚本。
