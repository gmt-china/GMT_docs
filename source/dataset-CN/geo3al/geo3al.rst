geo3al: 中国大陆及临区地质图数据
================================

中国大陆及临区地质图数据 :file:`geo3al.gmt`\ 来自
美国USGS(`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`_)
，其分辨率为1:4,000,000。 原始的 ``.shp`` 数据文件使用的不是WGS84坐标系统，不便于 GMT 使用。
社区提供的数据已由贡献者徐弥坚进行过坐标转换，处理为 GMT 易用的WGS84坐标。数据处理具体步骤如下：

首先 :doc:`/table/ogr2ogr`\ ，将 ``Shapefile`` 转换为GMT可识别的 ``OGR/GMT`` 格式::

    ogr2ogr -f "GMT" geo3al.gmt geo3al.shp
    
在此需要注意的是，除了 ``shp`` 文件以外， ``.bdf`` , ``.prj`` , ``.shx`` 等文件也必须放在同一文件夹下。
转换成的 ``gmt`` 格式的头段给出了坐标系统等信息::

    # @VGMT1.0 @GPOLYGON
    # @R-4429828.81497/2910361.16929/1521748.41529/6058515.31077              
    # @Jp"+proj=lcc +lat_0=0 +lon_0=120 +lat_1=31 +lat_2=-29 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
    # @Jw"PROJCS[\"WGS_1984_Lambert_Conformal_Conic\",GEOGCS[\"WGS 84\",DATUM[\"WGS_1984\",SPHEROID[\"WGS 84\",6378137,298.257223563,AUTHORITY[\"EPSG\",\"7030\"]],AUTHORITY[\"EPSG\",\"6326\"]],PRIMEM[\"Greenwich\",0],UNIT[\"Degree\",0.0174532925199433]],PROJECTION[\"Lambert_Conformal_Conic_2SP\"],PARAMETER[\"latitude_of_origin\",0],PARAMETER[\"central_meridian\",120],PARAMETER[\"standard_parallel_1\",31],PARAMETER[\"standard_parallel_2\",-29],PARAMETER[\"false_easting\",0],PARAMETER[\"false_northing\",0],UNIT[\"metre\",1,AUTHORITY[\"EPSG\",\"9001\"]],AXIS[\"Easting\",EAST],AXIS[\"Northing\",NORTH]]"
    # @NAREA|PERIMETER|TYPE|GLG|GEN_GLG
    # @Tdouble|double|string|string|string
    # FEATURE_DATA
    >
    # @D31581396321.161|1523494.938||J|J
    # @P
    181032.240279034 6019152.23377152
    183705.216473993 6018783.51860619
    ……
    
第三行显示坐标系统被投影在东经120度，南纬29度到北纬31度之间。数据通过 ``Python`` 的 ``pyproj`` 模块
进行坐标转换，下面仅列出关键部分代码::

    import pyproj
    p = pyproj.Proj(
        "+proj=lcc +lat_1=31 +lat_2=-29 +lat_0=0 +lon_0=120 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs")
    lon, lat = p(float(x), float(y), inverse=True)

处理好的数据的具体下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

示例代码使用地质年代CPT色标文件 (`GTS2012_periods <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/tn/GTS2012_periods.png.index.html>`_):
:download:`GTS2012_periods.cpt` 。
此 CPT 文件所提供的地质年代色标文件最小单位是“纪”，因此在绘制小区域时可能精度较低。
有兴趣的读者可以尝试在最小精度为“世”的色标(`GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`_)中进行修改，
来绘制更精细的图像，但这时图注则需要自行修改。

.. gmtplot:: plot_geo3al.sh
   :show-code: true
   :width: 75%

数据来源及引用
--------------
- USGS Generalized Geology of the Far East (geo3al). https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al
- 用GMT绘制中国大陆及邻区地质年代图. https://blog.xumijian.me/post/gmt-geo/
- Po-Chin Tseng的博客. https://jimmytseng79.github.io/GMT5_tutorials/geology_map.html