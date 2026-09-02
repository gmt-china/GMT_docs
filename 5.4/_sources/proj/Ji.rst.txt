-Ji：正弦曲线投影
=================

维基链接：https://en.wikipedia.org/wiki/Sinusoidal_projection

正弦曲线投影是等面积投影，是已知的最古老的投影之一，也被称为等面积Mercator投影。
其中心经线是直线，其余经线是正弦曲线，纬线是等间距的直线。
在所有纬线和中心经线处比例尺是真实的。

该投影的参数为::

    -JI[<lon>/]<width>
    -Ji[<lon>/]<scale>

``<lon>`` 是中心经线，默认值为地图区域的中心。

.. gmtplot::
    :caption: 使用正弦曲线投影绘制世界地图

    gmt pscoast -Rd -JI4.5i -Bxg30 -Byg15 -Dc -A10000 -Ggray -P > GMT_sinusoidal.ps

为了减少形状的畸变，1927年引入了间断正弦曲线投影，即用三个对称的段来覆盖全球。
传统上，间断出现在160ºW、20ºW和60ºE处。为了生成间断地图，必须调用 :doc:`/module/pscoast`
三次以分别绘制每段地图并叠加起来。间断正弦曲线投影一般仅用于显示全球不连续数据分布。

为了生成一个宽度为5.04英寸的间断世界地图，需要设置比例尺为5.04/360 = 0.014，
并将每段图沿水平方向偏移其对应的宽度
(140\ :math:`\cdot`\ 0.014 and 80\ :math:`\cdot`\ 0.014)。

.. gmtplot::
   :caption:  使用间断正弦曲线投影绘制世界地图

   gmt pscoast -R200/340/-90/90 -Ji0.014i -Bxg30 -Byg15 -A10000 -Dc -Gblack -K -P > GMT_sinus_int.ps
   gmt pscoast -R-20/60/-90/90 -Ji0.014i -Bxg30 -Byg15 -Dc -A10000 -Gblack -X1.96i -O -K >> GMT_sinus_int.ps
   gmt pscoast -R60/200/-90/90 -Ji0.014i -Bxg30 -Byg15 -Dc -A10000 -Gblack -X1.12i -O >> GMT_sinus_int.ps
