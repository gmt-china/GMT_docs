-JH: Hammer equal area
======================

维基链接：https://en.wikipedia.org/wiki/Hammer_projection

Hammer equal area（等面积 Hammer 投影）由德国数学家 Ernst von Hammer 于 1892 年提出，
也被称为 Hammer-Aitoff 投影（Aitoff 投影与之看起来相似，但不等面积）。
投影后的边界是一个椭圆，赤道和中心经线是直线，其余纬线和经线都是复杂曲线。

该投影的参数为：

**-JH**\ [*lon*/]\ *width*
或
**-Jh**\ [*lon*/]\ *scale*

- *lon* 是中心经线 [默认位于地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用 Hammer 投影绘制全球地图
    :width: 85%

    gmt coast -Rg -JH12c -Bg -Dc -A10000 -Gblack -Scornsilk -png GMT_hammer
