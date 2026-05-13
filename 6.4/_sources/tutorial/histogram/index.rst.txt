绘制直方图
==========

GMT 中 :doc:`/module/histogram` 模块用于统计并绘制直方图。
直方图可以直观地展现样本的分布情况。
一个直方的宽度表示它的数据范围，长度表示位于该范围内的样本的数量或者比例。

这一节中，我们通过绘制地震震源深度直方图来介绍直方图的绘制。
以下示例使用的数据为  :download:`eq.dat </tutorial/histogram/eq.dat>`，
数据包含了三列，分别是地震的经度、纬度和深度。

直方图根据直方的方向可以分为垂直直方图和水平直方图，也可以根据直方的长度的意义不同
分为计数直方图和百分比直方图。

垂直直方图
----------

GMT 中默认绘制垂直直方图。绘制直方图只需要一列数据，而上面的示例数据有三列。
我们需要使用 **-i2** 选项将输入数据的第三列（GMT 中列号从 0 开始）传递给 **histogram**。

直接使用下面的命令::

    gmt histogram eq.dat -i2 -png map

会得到如下报错信息::

    histogram [ERROR]: Required argument for bin width not set
    histogram [ERROR]: Option -T: Must specify bin width
    histogram [ERROR]: Must specify either fill (-G) or lookup colors (-C), outline pen attributes (-W), or both.

报错信息告诉我们，**histogram** 需要使用 **-T** 选项指定直方的宽度。同时还需要
使用 **-G** 指定直方的填充色，或使用 **-W** 指定直方边框的画笔属性。
根据错误信息，我们向上面的命令增加了几个额外的选项：

- **-T5** 设置了统计时每一个直方的宽度是 5。该选项还可以更灵活地设置直方的最大最小值等属性，
  详见 :doc:`/module/histogram` 模块文档
- **-W1p** 设置直方的边框宽度为 1p
- **-Baf** 则为整张图加了一个自动的边框

.. gmtplot::
   :language: bash
   :width: 50%
   :caption: 垂直直方图

   gmt histogram eq.dat -Baf -T5 -W1p -i2 -png hist1

由此，我们得到了一张非常简单的直方图。从直方图中我们对数据也有了基本的认识。
直方图中横轴表示数据中地震深度范围集中在 0-40 千米。

增加修饰
--------

为了让图形更加的美观，我们可以添加一些选项：

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX15c/9c -R0/40/0/600 -Bxaf+l"Depth" -Byaf+l"Counts" -BWSen -D -W1p -Gred -T5 -i2 -png hist2

- **-JX15c/9c** 指定了整张直方图的宽度和高度。若不指定，GMT 会自动指定一个合适的值
- **-R0/40/0/600** 设置了直方图的数据范围。若不指定，**histogram** 会自动确定最适合的数据范围。
  这里我们根据前图的统计结果指定了新的 **-R** 范围
- **-B** 选项用于指定底图边框和坐标轴属性
- **-Gred** 表示为直方填充红色
- **-D** 会在每个直方的上方标注该直方中的数量。该选项还可以接更多的子选项以控制标注的
  位置、字体和角度等

水平直方图
----------

如果想要绘制水平直方图，只需要增加 **-A** 选项。
需要注意的是，尽管水平直方图中横轴是地震数量，纵轴是地震深度，**-R** 选项中依然是
深度在前、统计值在后，即与垂直直方图时保持一致。

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 水平直方图

   gmt histogram eq.dat -JX15c/9c -R0/40/0/600 -Bxaf+l"Depth" -Byaf+l"Counts" -BWSen -A -D -W1p -Gred -T5 -i2 -png hist3

百分比直方图
------------

**histogram** 的 **-Z** 选项可以进一步控制统计图的类型。默认纵轴为统计数目。
**-Z1** 表示绘制百分比直方图。

.. gmtplot::
   :language: bash
   :width: 75%
   :caption: 添加选项的垂直直方图

   gmt histogram eq.dat -JX15c/9c -Bxaf+l"Depth" -Byaf+l"Counts"+u"%" -BWSen -Z1 -W1p -Gred -T5 -i2 -png hist4

这个命令中，由于纵轴的含义变了，之前的 **-R** 选项就不再合适了，因而我们去除了
**-R** 选项让 GMT 自动确定最佳数据范围。
