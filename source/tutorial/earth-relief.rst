绘制地形起伏
============

GMT中使用 :doc:`gridimage` 模块绘制地形。

earth_relief 全球地形起伏数据
--------------------------------
该数据并非 GMT 官方采集，而是 GMT 官方收集，以方便用户使用。
该数据有不同精度和覆盖范围的版本。
地形数据中记录了每点的高程坐标。gmt 绘制地形图的原理就是把高程坐标的数值和颜色对应起来。

绘制全球地形
-------------

.. gmtplot::
    :width: 100%
    :caption: 全球地形

    gmt begin global_relief png,pdf
    gmt grdimage -JH10c @earth_relief_15m
    gmt end

上图中，使用gridimage模块绘制地形数据。使用的数据是@earth_relief_15m。
数据名称中的@表示是GMT官方提供的数据，如果你之前从来没有用过，gmt会下载，今后再使用就不再下载了。
15m表示精度为15弧分。

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

    gmt makecpt -Cglobe -T-10000/10000/200 -Z > colorTopo.cpt
    gmt begin earth_relief_4 pdf,png
    gmt basemap -JM15c -R118/125/21/26.5 -Baf -BWSEN
    gmt grdimage -CcolorTopo.cpt earth_relief_15s.grd -I+d
    gmt colorbar -DjCB+w15c/0.3c+o0/-2.5c+h -CcolorTopo.cpt -BWSEN -Bxa2000f200+l"Elevation/m" -G-8000/8000
    gmt end
    rm colorTopo.cpt

在有了色标卡之后，我们可以看到台湾岛东部的海沟非常深。