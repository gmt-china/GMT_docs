绘制直方图
==========

:doc:`/module/histogram` 模块用于统计并绘制直方图。

直方图展现数据的分布情况，每一个直方的长度表示了对应范围数据的多少或者比例。
在这一节，我们借用深部强震数量随季节变化的规律作为例子来介绍直方图的绘制。

垂直直方图
----------

所谓垂直直方图，就是直方是垂直的，是最常见的形式。

.. gmtplot::
   :language: bash
   :caption: 垂直直方图

   gmt histogram eq.dat -R0/35/0/600 -JX8c -Bxa5+l"Depth/km" -Bya100+l"Counts" -BWSne -D+f10p,4+o8p -W5+b -L1p -i2 -png histVert

此示例中：

- ``-R0/35/0/600`` 设置了X轴范围是0到35，Y轴范围为0到600
- ``-JX8c`` 指定了整张图为线性投影，图的宽度（X轴长度）和图的高度（Y轴长度）均为8厘米
- ``-Bxa5+l"Depth/km" -Bya100+l"Counts"`` 分别设置了X、Y轴标注、刻度的间隔、标签
- ``-D+f10p,Times-Roman+o8p`` 为每个bar设置标注，标注字号为10p、字体为4号Times-Roman，标注与bar之间距离为8p
- ``-W5+b`` 设置直方图bin宽度为5，\ ``+b`` 表示将落在范围外的数据包含在第一个或最后一个bin中
- ``-L1p`` 设置bar边框为1p
- ``-i2`` 从输入文件eq.dat中读取第3列，\ ``-i0`` 表示输入文件第1列

除了统计个数，还可以统计百分比，绘制百分比直方图

``-Z1`` 设置纵轴为百分比，\ ``-N`` 绘制等效的正态分布曲线。

.. gmtplot::
   :language: bash
   :caption: 百分比直方图

   gmt histogram eq.dat -R0/35/0/100 -JX8c/8c -Bxa5+l"Depth/km" -Bya20+l"Frequency" -BWSne -W5+b -L1p -i2 -N -Z1 -png histFreq

上面的例子中，直方没有颜色，下面的例子中我们添加上颜色。

水平直方图
----------

除了垂直直方图，还可以绘制水平直方图。

``-A`` 用于控制绘制水平直方图，上一个例子中默认绘制垂直直方图。

.. gmtplot::
   :language: bash
   :caption: 水平直方图

   gmt histogram eq.dat -R0/35/0/600 -JX8c -Bxa5+l"Depth/km" -Bya100+l"Counts" -BWSne -D+f10p,4+o8p -A -W5+b -L1p -i2 -png histHori