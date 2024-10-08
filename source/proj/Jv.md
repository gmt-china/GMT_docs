# -JV: Van der Grinten

维基链接：<https://en.wikipedia.org/wiki/Van_der_Grinten_projection>

Van der Grinten 投影由 Alphons J. van der Grinten 于 1904 年提出，其既不等面积也不保角。
中心经线和赤道都是直线，其余经线则是圆弧，仅在赤道处比例尺是真实的，
主要用于在一个圆内展示整个世界地图。

该投影的参数为：

**-JV***lon*/*width*
或
**-Jv***lon*/*scale*

- *lon* 是投影中心经线 \[默认为地图区域的中心\]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

```{eval-rst}
.. gmtplot::
    :caption: 使用 Van der Grinten 投影绘制全球图
    :width: 60%

    gmt coast -Rg -JV10c -Bg -Dc -Glightgray -Scornsilk -A10000 -Wthinnest -png GMT_grinten
```
