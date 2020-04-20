绘制直方图
==========

:doc:`/module/histogram` 模块用于统计并绘制直方图。

直方图可以展现样本的分布情况。
一个直方的宽度表示它的数据范围，长度表示位于该范围内的样本的数量或者比例。
在这一节，我们借用地震的震源深度来介绍直方图的绘制。

直方图根据直方的方向可以分为垂直直方图和水平直方图，也可以根据直方的长度的意义不同分为计数直方图和百分比直方图。

垂直直方图
----------

我们首先来绘制垂直直方图：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 垂直直方图

   gmt histogram eq.dat -JX8c -Bxaf+l'Depth/km' -Byaf+l'Counts' -BWSen -T0/35/5 -W1p -i2 -png hist1

此示例中：

- ``-JX8c`` 指定了整张图为线性投影，图的宽度（X轴长度）和图的高度（Y轴长度）均为8厘米
- ``-Bxaf+l'Depth/km' -Byaf+l'Counts'`` 分别设置了X、Y轴标注、刻度间隔和标签
- ``-T0/35/5`` 设置了统计的范围是0到35，每一个直方的跨度是5
- ``-W1p`` 设置直方的边框宽度为1p
- ``-i2`` 使用输入文件的第三列（第一列为0）

增加修饰
----------

为了让图形更加的美观，我们可以添加一些选项：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX8c -R0/35/0/550 -Bxaf+l'Depth/km' -Byaf+l'Counts' -BWSen -D -Gred -T0/35/5 -W1p -i2 -png hist2

添加的选项：
   - ``-D`` 为每一个直方标注数量
   - ``-Gred`` 为每一个直方增加红色的填充色
   - ``-R0/35/0/550`` histogram模块并不要求必须使用 ``-R`` 选项。这里如果不用上，直方的标注会超出底图。

百分比直方图
-------------------

如果想绘制百分比直方图，只需要增加 ``-Z1`` 选项即可：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX8c -Bxaf+l'Depth/km' -Byaf+l'Counts'+u' %' -BWSen -D -Gred -T0/35/5 -W1p -Z1 -i2 -png hist3

水平直方图
--------------------

如果想要绘制水平的直方图，只需要增加 ``-A`` 选项：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 水平直方图

   gmt histogram eq.dat -JX8c -R0/35/0/600 -Bxaf+l'Depth/km' -Byaf+l'Counts' -BWSen -A -D -Gred -T0/35/5 -W1p -i2 -png hist4