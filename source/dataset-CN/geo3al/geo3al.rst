geo3al: 中国大陆及邻区地质图数据
================================

中国大陆及邻区地质图数据 :file:`geo3al.gmt`\ 来自
美国USGS(`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`_)
，其分辨率为1:4,000,000。 原始的 ``.shp`` 数据文件使用的不是WGS84坐标系统，不便于 GMT 使用。
社区提供的数据已由贡献者徐弥坚进行过坐标转换，处理为 GMT 易用的WGS84坐标。数据处理具体步骤如下：

首先 :doc:`/table/ogr2ogr`\ ，将 ``Shapefile`` 转换为GMT可识别的 ``OGR/GMT`` 格式。
原数据的坐标不是我们希望的经纬度坐标，而是大地坐标，
这里需要使用 ``ogr2ogr`` 中的 ``-t_srs`` 参数进行坐标转换::

    ogr2ogr -f GMT geo2al.gmt geo3al.shp -t_srs EPSG:4326
    
在此需要注意的是，除了 ``shp`` 文件以外， ``.dbf`` , ``.prj`` , ``.shx`` 等文件也必须放在同一文件夹下。
格式转换后geo2al.gmt文件的头段为::

    # @D21315149832.578|1546682.830|v|J|J
    # @P
    123.121278084975 53.3084236387908
    123.230414901407 53.3161680969698
    123.288482121838 53.3166334127133
    123.328886980316 53.3062394894715
    ......
    
我们所需要头段的是岩性 ``v`` （火山岩）和年代 ``J`` （侏罗系），这里我们用 ``sed`` 和正则表达式修改文件头段::

    sed 's/#[[:space:]]@D[[:digit:]]*.[[:digit:]]*|[[:digit:]]*.[[:digit:]]*|\(.*\)|\(.*\)|\(.*\)/> -Z\2 |\1|\2/g; /^#/d' geo2al.gmt > geo3al.gmt

文件头段被修改为::

    > -ZJ |v|J
    123.121278084975 53.3084236387908
    123.230414901407 53.3161680969698
    123.288482121838 53.3166334127133
    123.328886980316 53.3062394894715
    ....

这里通过 ``-Z`` 指定年代，配合CPT文件和 ``plot -L`` 可以为闭合图形填充颜色，来达到绘制地质图的目的。
其中CPT文件格式为::

    JK   179/227/238 ; Jurassic-Cretaceous
    J     52/178/201 ; Jurassic

处理好的数据的具体下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

示例代码使用地质年代CPT色标文件修改自 `GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`_ 。
下载地址 :download:`geoage.cpt` 。

.. gmtplot:: plot_geo3al.sh
   :show-code: true
   :width: 75%

数据来源及引用
--------------
- USGS Generalized Geology of the Far East (geo3al). https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al
- 用GMT绘制中国大陆及邻区地质年代图. https://blog.xumijian.me/post/gmt-geo/
- Po-Chin Tseng的博客. https://jimmytseng79.github.io/GMT5_tutorials/geology_map.html
