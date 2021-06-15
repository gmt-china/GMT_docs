geo3al: 中国大陆及临区地质图数据
================================

中国大陆及临区地质图数据 :file:`geo3al.gmt`\ 来自
美国USGS(`Generalized Geology of the Far East (geo3al) <https://catalog.data.gov/dataset/generalized-geology-of-the-far-east-geo3al>`_)
，其分辨率为1:4,000,000。 GMT 无法使用原始数据文件，已由贡献者徐弥坚处理为 GMT 可用的格式。

具体的下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

示例代码使用地质年代CPT色标文件 (`GTS2012_periods <http://soliton.vm.bytemark.co.uk/pub/cpt-city/heine/tn/GTS2012_periods.png.index.html>`_):
 :download:`geoage.cpt` 。
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