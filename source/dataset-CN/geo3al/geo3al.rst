geo3al: 中国大陆及临区地质图数据
================================

:贡献者: 徐弥坚
:原文链接: https://blog.xumijian.me/post/gmt-geo/

----

中国大陆及临区地质图数据 ``geo3al`` 来自
美国USGS(`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`_)
，其分辨率为1:4,000,000。 GMT 无法使用原始数据文件，已由贡献者处理为 GMT 可用的格式。

- 数据下载地址: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/geo3al.xy2
- 地质年代CPT色标文件 (GTS2012_periods): :download:`geoage.cpt` 

所提供的地质年代色标文件最小单位是“纪”，因此在绘制小区域时可能精度较低。
有兴趣的读者可以尝试在最小精度为“世”的色标(`GTS2012_epochs <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/GTS2012_epochs.cpt>`_)中进行修改，
来绘制更精细的图像，但这时图注则需要自行修改。

.. literalinclude:: plot_geo3al.sh

.. image:: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/figures/geo3al.png
    :width: 80%
    :align: center
