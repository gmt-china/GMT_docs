-JQ: Equidistant cylindrical
============================

维基链接：https://en.wikipedia.org/wiki/Equirectangular_projection

Equidistant cylindrical（圆柱等距投影）是一个经度和纬度的线性缩放。
最常用的形式是 Plate Carrée 投影，其中对经线和纬线的缩放比例是相同的。
所有的经纬线都是直线。

该投影的参数为：

**-JQ**\ [*lon*/[*lat*]/]\ *width*
或
**-Jq**\ [*lon*/[*lat*]/]\ *scale*

- *lon* 是中心经线，默认为地图区域的中心
- *lat* 是标准纬线，默认为赤道，若指定了标准纬线，则必须指定中心经线
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用 Plate Carrée 投影绘制全球地图
    :width: 85%

    gmt coast -Rg -JQ12c -B60f30g30 -Dc -A5000 -Gtan4 -Slightcyan -png GMT_equi_cyl

选择不同的标准纬线，则可以获取经度和纬度的不同缩放比例。流行的几个标准纬线如下：

.. table::
   :align: center

   +-----------------------------------------------------+--------+
   +=====================================================+========+
   | Grafarend and Niermann, minimum linear distortion   | 61.7°  |
   +-----------------------------------------------------+--------+
   | Ronald Miller Equirectangular                       | 50.5°  |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum continental distortion       | 43.5°  |
   +-----------------------------------------------------+--------+
   | Grafarend and Niermann                              | 42°    |
   +-----------------------------------------------------+--------+
   | Ronald Miller, minimum overall distortion           | 37.5°  |
   +-----------------------------------------------------+--------+
   | Plate Carrée, Simple Cylindrical, Plain/Plane       | 0°     |
   +-----------------------------------------------------+--------+
