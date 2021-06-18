geo3al: 中国大陆及邻区地质图数据
================================

中国大陆及邻区地质图数据 :file:`geo3al.gmt`\ 来自 USGS
`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`__\ ，
分辨率为 1:4,000,000。原始的 **.shp** 格式的数据文件未使用 WGS84 坐标系统，
为了方便 GMT 用户使用，需要对原始数据做一定的转换和处理。

数据转换和处理流程
-----------------

首先使用 :doc:`ogr2ogr </table/ogr2ogr>` 将 **.shp** 格式转换为 GMT 可识别的 **OGR/GMT** 格式。
原数据的坐标系统并不是经纬度坐标，而是大地坐标。因此，需要使用 ``ogr2ogr`` 的 **-t_srs** 参数进行坐标转换::

    $ ogr2ogr -f GMT geo3al.gmt geo3al.shp -t_srs EPSG:4326
    
需要注意的是，:file:`.dbf`\ 、\ :file:`.prj`\ 、\ :file:`.shx` 等文件必须和 :file:`shp` 文件放在同一目录下。

处理好的数据的具体下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

示例代码使用地质年代 CPT 色标文件修改自 `GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`__ 。
下载地址：\ :download:`geoage.cpt` 。

.. gmtplot:: plot_geo3al.sh
   :show-code: true
   :width: 75%

数据来源及引用
--------------
- USGS Generalized Geology of the Far East (geo3al). https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al
- 用 GMT 绘制中国大陆及邻区地质年代图：https://blog.xumijian.me/post/gmt-geo/
- Po-Chin Tseng的博客. https://jimmytseng79.github.io/GMT5_tutorials/geology_map.html
