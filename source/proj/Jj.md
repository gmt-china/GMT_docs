# -JJ: Miller cylindrical

维基链接：<https://en.wikipedia.org/wiki/Miller_cylindrical_projection>

Miller cylindrical（Miller 圆柱投影）由 Osborn Maitland Miller 于 1942 年提出，
该投影既不是保角也不是等面积。所有的经线和纬线都是直线。
该投影是 Mercator 与其他圆柱投影之间的折衷。
在此投影中，纬线之间的间距使用了 Mercator 公式并乘以 0.8 倍的真实纬度，
因而避免了极点的奇点，然后再将结果除以 0.8。

该投影的参数为：

**-JJ***lon*/*width*
或
**-Jj***lon*/*scale*

- *lon* 为中心经度 \[默认为地图区域的中心\]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

```{eval-rst}
.. gmtplot::
    :caption: 使用 Miller 圆柱投影绘制世界地图
    :width: 85%

    gmt coast -R-90/270/-80/90 -Jj1:400000000 -Bx45g45 -By30g30 -Dc -A10000 -Gkhaki -Wthinnest -Sazure -png GMT_miller
```
