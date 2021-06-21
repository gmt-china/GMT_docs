geo3al: 中国大陆及邻区地质图数据
================================

中国大陆及邻区地质图数据 :file:`geo3al.gmt`\ 来自 USGS
`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`__\ ，
分辨率为 1:5,000,000。

处理好的数据的具体下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

示例代码使用地质年代 CPT 色标文件修改自 `GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`__ 。
下载地址：\ :download:`geoage.cpt` 。

.. gmtplot:: plot_geo3al.sh
   :show-code: true
   :width: 75%

数据转换和处理流程
-----------------

原始的数据文件是 **.shp** 格式，且未使用 WGS84 坐标系统。
为了方便 GMT 用户使用，需要对原始数据做一定的格式转换和处理。

使用 :doc:`ogr2ogr </table/ogr2ogr>` 将 **.shp** 格式转换为 GMT 可识别的 **OGR/GMT** 格式::

    $ ogr2ogr -f GMT geo3al.gmt geo3al.shp -t_srs EPSG:4326
    
注意事项：

- 原数据的坐标系统是大地坐标，不是经纬度坐标，因而需要使用 ``ogr2ogr`` 的 **-t_srs** 参数进行坐标转换
- :file:`.dbf`\ 、\ :file:`.prj`\ 、\ :file:`.shx` 等文件必须和 :file:`shp` 文件放在同一目录下

数据来源及引用
--------------

**原始数据**：

- Steinshouer, D.W., Qiang, J., McCabe, P.J., and Ryder, R.T, 1999, Maps showing geology, oil and gas fields, and geologic provinces of the Asia Pacific region: U.S. Geological Survey Open-File Report 97-470-F, 16 p., https://doi.org/10.3133/ofr97470F.

**数据转换与处理流程**：

- `Mijian Xu <https://home.xumijian.me/>`__ 的博客：
  `用 GMT 绘制中国大陆及邻区地质年代图 <https://blog.xumijian.me/post/gmt-geo/>`__
- `Po-Chin Tseng <https://github.com/jimmytseng79>`__ 的
  `GMT5 教程：地质图 <https://jimmytseng79.github.io/GMT5_tutorials/geology_map.html>`__
