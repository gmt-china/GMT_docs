:orphan:

以地图和卫星图为底图
====================

:示例贡献者: 陈箫翰

----

当绘图区域非常小时，GMT 自带的海岸线数据与地形数据精度较差，不适宜用来绘制底图。对于这种情况，读者可以使用公开的地图或卫星图接口（例如高德地图、谷歌地图等）绘制底图。
GMT 没有下载此类地图的功能。
`google-map-downloader <https://github.com/CovMat/google-map-downloader>`__ 中的
`downloader_gmtchina.py <https://github.com/CovMat/google-map-downloader/blob/master/downloader_gmtchina.py>`__ 脚本支持可以下载高德地图及卫星图以及
谷歌地图及卫星图。详细用法见 google-map-downloader 的官方说明文档。

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
