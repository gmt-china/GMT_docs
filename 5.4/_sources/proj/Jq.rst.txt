-Jq：圆柱等距投影
=================

维基链接：https://en.wikipedia.org/wiki/Equirectangular_projection

这个简单的圆柱投影是一个经度和纬度的线性缩放。最常用的形式是Plate Carrée投影，
其中对经线和纬线的缩放比例是相同的。所有的经纬线都是直线。

该投影的参数为::

    -JQ[<lon>/[<lat>]/]<width>
    -Jq[<lon>/[<lat>]/]<scale>

- ``<lon>`` 是中心经线，默认为地图区域的中心
- ``<lat>`` 是标准纬线，默认为赤道，若指定了标准纬线，则必须指定中心经线

.. gmtplot::
    :caption: 使用Plate Carrée投影绘制全球地图

    gmt pscoast -Rg -JQ4.5i -B60f30g30 -Dc -A5000 -Gtan4 -Slightcyan -P > GMT_equi_cyl.ps

选择不同的标准纬线，则可以获取经度和纬度的不同缩放比例。流行的几个标准纬线如下：

.. table::
   :align: center

   +-----------------------------------------------------+--------+
   +=====================================================+========+
   | Grafarend and Niermann, minimum linear distortion   | 61.7º  |
   +-----------------------------------------------------+--------+
   | Ronald Miller Equirectangular                       | 50.5º  |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum continental distortion       | 43.5º  |
   +-----------------------------------------------------+--------+
   | Grafarend and Niermann                              | 42º    |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum overall distortion           | 37.5º  |
   +-----------------------------------------------------+--------+
   | Plate Carrée, Simple Cylindrical, Plain/Plane       | 0º     |
   +-----------------------------------------------------+--------+
