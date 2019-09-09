绘制地形起伏
============

绘制地图时另一个常见的需求是绘制全球或者区域的地形起伏作为底图。

GMT中 :doc:`grdimage` 模块可以绘制二维网格，其原理是建立Z值与颜色之间的映射关系，
每个坐标点不同的Z值用不同的颜色表征。
地形起伏，即不同经纬度处的高程或海深数据，也是一种二维数据，因而我们可以使用
**grdimage** 模块绘制地形起伏。

全球地形起伏数据
----------------

要绘制全球或区域地形起伏图，首先需要拥有地形起伏数据，即不同经纬度处的高程或海深数据。
GMT收集整理并提供了一套全球地形起伏数据，供用户直接使用。
这套地形起伏数据分为包含了从60弧分到1弧秒的多种不同精度的全球地形起伏数据，
以满足不同的绘图区域大小的需求。

GMT用户可以通过给定文件名 :file:`@earth_relief_xxx` 的方式来指定要使用某个精度的
地形。\ *xxx* 用于指定数据精度，例如 **15m**\ 、\ **01m**\ 和 \ **15s** 分别表示
数据分辨率为15弧分、1弧分和15弧秒。

文件名前的 **@** 表示该数据是由GMT官方提供并维护的数据，当第一次使用该文件时，
GMT会自动从服务器下载该数据并保存到本地的GMT数据目录中，当以后再使用该文件时，
则直接读取本地文件，而无需重新下载该数据。

关于全球地形起伏数据的详细介绍见 :doc:`/dataset/earth_relief`\ 。

绘制全球地形起伏图
------------------

下面我们将使用 **grdimage** 模块绘制5弧分精度的全球地形起伏数据（\ :file:`@earth_relief_05m`\ ）。
不同的高程用不同的颜色表示，从中我们很容易看出不同地区的地形变化。

.. gmtplot::
    :width: 100%
    :caption: 全球地形起伏图

    gmt begin global_relief png,pdf
    gmt grdimage @earth_relief_05m -JH180/10c
    gmt end

绘图区域地形起伏图
------------------

想要绘制区域地形起伏？只需要在 **grdimage** 模块中使用 **-R** 选项指定
区域经纬度范围即可。这里我们设置了绘图区域为118°E至125°E、20°N至26°N。
由于绘图区域比较小，所以我们选用了更高精度的 30 弧秒的地形起伏数据。

.. gmtplot::
    :width: 80%
    :caption: 台湾区域地形图

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen
    gmt end

加上光照效果
--------------

为了便于体现光照效果带来的变化，我们首先绘制一副台湾地图。

.. gmtplot::
    :width: 80%
    :caption: 台湾

    gmt begin taiwan_relief png,pdf
    gmt grdimage -JM15c -R118/125/21/26.5 -Baf -BWSEN @earth_relief_15s.grd
    gmt end

台湾岛为中国第一大岛。虽然位于东南沿海，纵深浅，中国东部地区最高点却在台湾3952米高的玉山山顶。你能在图中找到钓鱼台列屿吗？

下面我们加上选项-I+d，为图幅加上光照效果，明显增加立体感：

.. gmtplot::
    :width: 80%
    :caption: 带光照效果的台湾

    gmt begin taiwan_relief png,pdf
    gmt grdimage -JM15c -R118/125/21/26.5 -Baf -BWSEN @earth_relief_15s.grd -I+d
    gmt end

制作CPT文件和绘制色标卡
-------------------------

刚才说了，gmt需要把高程数值和颜色对应起来。对应的关系是由CPT格式的色标文件决定的。
刚才我们介绍了，中国东部地区的最高点接近4000米，据此，我们专门制作CPT文件绘制地图。

.. gmtplot::
    :width: 80%
    :caption: 专门制作CPT文件的台湾

    gmt begin earth_relief_4 pdf,png
    gmt basemap -JM15c -R118/125/21/26.5 -Baf -BWSEN
    gmt makecpt -Cglobe -T-10000/10000/200 -Z
    gmt grdimage -C earth_relief_15s.grd -I+d
    gmt colorbar -DjCB+w15c/0.3c+o0/-2.5c+h -C -BWSEN -Bxa2000f200+l"Elevation/m" -G-8000/8000
    gmt end

在有了色标卡之后，我们可以看到台湾岛东部的海沟非常深。
