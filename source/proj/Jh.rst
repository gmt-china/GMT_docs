-Jh：等面积Hammer投影
=====================

维基链接：https://en.wikipedia.org/wiki/Hammer_projection

等面积Hammer投影由德国数学家Ernst von Hammer于1892年提出，也被称为Hammer-Aitoff投影
（Aitoff投影与之看起来相似，但不等面积）。投影后的边界是一个椭圆，赤道和中心经线
是直线，其余纬线和经线都是复杂曲线。

该投影的参数为：

**-JH**\ [*lon*/]\ *width*
或
**-Jh**\ [*lon*/]\ *scale*

- *lon* 是中心经线 [默认位于地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上1厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用Hammer投影绘制全球地图
    :width: 85%

    gmt coast -Rg -JH12c -Bg -Dc -A10000 -Gblack -Scornsilk -png GMT_hammer
