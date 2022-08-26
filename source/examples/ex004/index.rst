:orphan:

以地图和卫星图为底图
====================

当绘图区域非常小时，GMT 自带的海岸线数据与地形数据精度较差，不适宜用来绘制底图。对于这种情况，读者可以使用公开的地图或卫星图接口（例如高德地图、谷歌地图等）绘制底图。
GMT 没有下载此类地图的功能。
征得原作者同意，本社区修改了开源地图下载工具 `Google-Map-Downloader <https://github.com/zhengjie9510/google-map-downloader>`__ ，
添加了适合境内用户的高德地图下载源。
修改后的地图下载工具可 `点击此处下载 <https://github.com/CovMat/google-map-downloader/blob/master/downloader_gmtchina.py>`__ 。

国内的地图服务均进行过GCJ02坐标系加密，因此这个工具对高德地图、高德卫星图与谷歌地图进行了GCJ02到WGS84坐标系的变换。谷歌卫星图则不需要进行变换。
此外，境内用户需确保能够正常使用谷歌地图网页版才能使用本工具下载谷歌地图。

提供如下参数运行脚本，即可下载 tif 格式地图::

    $ python downloader_gmtchina.py 起始经度 结束经度 起始纬度 结束纬度 地图层级 输出图片文件名 地图来源
    
地图层级取 0 - 22 之间的整数，值越高分辨率越大。地图来源目前可以选择以下四个:

=========== =========
代码         地图来源
=========== =========
amap        高德地图
amap_sat    高德卫星图
google      谷歌地图
google_sat  谷歌卫星图
=========== =========

以厦门市为例，使用如下参数下载四种地图::

    $ python downloader_gmtchina.py 118.055917 118.244753 24.399450 24.559724 12 google.tif google
    $ python downloader_gmtchina.py 118.055917 118.244753 24.399450 24.559724 16 google_sat.tif google_sat
    $ python downloader_gmtchina.py 118.055917 118.244753 24.399450 24.559724 12 amap.tif amap
    $ python downloader_gmtchina.py 118.055917 118.244753 24.399450 24.559724 16 amap_sat.tif amap_sat

当绘图区域非常小时，在 GMT 中可以使用“度:分:秒”的格式表示地理坐标，避免计算小数。
例如 ``121:52:38.3`` 表示东经 121 度 52 分 38.3 秒。
下面的例子展示了绘制厦门市四种地图的示例。通过对比可见 GMT 自带的海岸线数据在绘图区域较小时准确性较差。

.. literalinclude:: ex004.sh

.. image:: https://user-images.githubusercontent.com/26203721/186561576-cf6b7b29-7f29-4157-851a-23ec6ad51353.jpg
   :width: 95%
   :align: center
