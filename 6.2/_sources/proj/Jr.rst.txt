-JR: Winkel Tripel
==================

维基链接：https://en.wikipedia.org/wiki/Winkel_tripel_projection

1921 年 Oswald Winkel 设计了 Winkel Tripel 投影，以在三个元素（面积、角度、距离）之间折衷，
在绘制全球地图时，这三个元素的畸变最小。此投影不是保角也不是等面积投影。
中心经线和赤道是直线，其他经线和纬线是曲线。该投影取等距圆柱投影和 Aitoff
投影的坐标的平均值。极点处投影为 0.4 倍赤道长度的直线。

该投影的参数为：

**-JR**\ [*lon*/]\ *width*
或
**-Jr**\ [*lon*/]\ *scale*

- *lon* 是中心经线 [默认值为地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用 Winkel Tripel 投影绘制全球地图
    :width: 75%

    gmt coast -Rd -JR12c -Bg -Dc -A10000 -Gburlywood4 -Swheat1 -png GMT_winkel
