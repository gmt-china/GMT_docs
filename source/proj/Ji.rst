-JI: Sinusoidal equal area
==========================

维基链接：https://en.wikipedia.org/wiki/Sinusoidal_projection

Sinusoidal equal area（正弦曲线投影）是等面积投影，是已知的最古老的投影之一，也被称为等面积 Mercator 投影。
其中心经线是直线，其余经线是正弦曲线，纬线是等间距的直线。
在所有纬线和中心经线处比例尺是真实的。

该投影的参数为：

**-JI**\ [*lon*/]\ *width*
或
**-Ji**\ [*lon*/]\ *scale*

- *lon* 是中心经线 [默认值为地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用正弦曲线投影绘制世界地图
    :width: 85%

    gmt coast -Rd -JI12c -Bg -Dc -A10000 -Gcoral4 -Sazure3 -png GMT_sinusoidal

为了减少形状的畸变，1927 年引入了间断正弦曲线投影，即用三个对称的段来覆盖全球。
传统上，间断出现在 160°W、20°W 和 60°E 处。为了生成间断地图，必须调用 :doc:`/module/coast`
三次以分别绘制每段地图并叠加起来。间断正弦曲线投影一般仅用于显示全球不连续数据分布。

为了生成一个宽度为 14.4 cm 英寸的间断世界地图，需要设置比例尺为 14.4/360 = 0.04，
并将每段图沿水平方向偏移其对应的宽度（140 x 0.04 和 80 x 0.04）。

.. gmtplot::
   :caption:  使用间断正弦曲线投影绘制世界地图
   :width: 85%

   gmt begin GMT_sinus_int
   gmt coast -R200/340/-90/90 -Ji0.04c -Bg -A10000 -Dc -Gdarkred -Sazure
   gmt coast -R-20/60/-90/90 -Bg -Dc -A10000 -Gdarkgreen -Sazure -X5.6c
   gmt coast -R60/200/-90/90 -Bg -Dc -A10000 -Gdarkblue -X3.2c
   gmt end show
