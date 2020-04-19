绘制直方图
==========

:doc:`/module/histogram` 模块用于统计并绘制直方图。

直方图可以展现样本的分布情况。
一个直方的宽度表示它的数据范围，长度表示位于该范围内的样本的数量或者比例。
在这一节，我们借用深部强震（深度不小于500公里，震级不小于7级）发生的月份来介绍直方图的绘制。
为了突出重点，这里提供的数据文件已经经过充分处理，是从地震目录中提取的月份。

直方图根据直方的方向可以分为垂直直方图和水平直方图，也可以根据直方的长度的意义不同分为计数直方图和百分比直方图。

垂直直方图
----------

我们首先来绘制垂直直方图：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 垂直直方图

   gmt histogram eq.dat -JX8c -Bxa1+l'Month' -Byaf+l'Counts' -BWSen -T1/12/1 -W1p -png hist1

此示例中：

- ``-JX8c`` 指定了整张图为线性投影，图的宽度（X轴长度）和图的高度（Y轴长度）均为8厘米
- ``-Bxa1+l'Month' -Byaf+l'Counts'`` 分别设置了X、Y轴标注、刻度间隔和标签
- ``-T1/12/1`` 设置了统计的范围是1到12，每一个直方的跨度是1
- ``-W1p`` 设置直方的边框宽度为1p

从这张图可以看到，年中的地震明显更多。

增加修饰
----------

为了让图形更加的美观，我们可以添加一些选项：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX8c -Bxa1+l'Month' -Byaf+l'Counts' -BWSen -D -Gred -T1/12/1 -W1p -png hist2

添加的选项：
   - ``-D`` 为每一个直方标注数量
   - ``-Gred`` 为每一个直方增加红色的填充色

百分比直方图
-------------------

如果想绘制百分比直方图，只需要增加 ``-Z1`` 选项即可：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX8c -Bxa1+l'Month' -Byaf+l'Counts'+u' %' -BWSen -D -Gred -T1/12/1 -W1p -Z1 -png hist3

水平直方图
--------------------

如果想要绘制水平的直方图，只需要增加 ``-A`` 选项：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 水平直方图

   gmt histogram eq.dat -JX8c -Bxa1+l'Month' -Byaf+l'Counts' -BWSen -A -D -Gred -T1/12/1 -W1p -png hist4