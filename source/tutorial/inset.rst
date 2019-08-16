GMT图中图模式
=============

在绘制研究区域的地图时，有时研究区域的范围比较小。在这种情况下，为了更好地显示
研究区域的具体地理位置，通常会绘制一个更大区域的地图，并在大区域地图中框出研究
区域的位置，这种图件称之为 inset map，中文没有统一的翻译，通常称之为图中图或者
小图。图中图模式可以通过模块 :doc:`/module/inset` 实现。

``gmt inset begin`` 用于进入图中图模式，其作用是在图纸上标记出一个矩形区域，并将绘图
原点移动到该矩形区域的左下角，接下来的所有绘图命令均只在该图中图区域内操作，
而 ``gmt inset end`` 则用于退出图中图模式，并将坐标原点移动回原大图中。

下面仅展示一个简单的示例：

.. gmtplot::

    gmt begin inset-map png
        gmt basemap -R0/40/40/60 -JM6.5i -Bafg -B+glightgreen

        # 图中图模式
        gmt inset begin -DjTR+w2.5i+o0.2i -F+gpink+p0.5p -M0.1i
            gmt basemap -Rg -JA20/20/2.3i -Bafg
            echo INSET | gmt text -F+f12p+cTR
        gmt inset end

        echo MAP | gmt text -F+f18p+cBL -Dj0.2i
    gmt end
