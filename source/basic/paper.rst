画布
====

要画一张图，首先需要准备一个画布。GMT 的画布就是 PS 文件。GMT 默认的画布是 A4 大小的横置的白色PS文件。

.. note::

   本节介绍的内容，涉及到后面的一些知识。因而这里只是做简单介绍，具体的操作看不懂也没关系。

画布尺寸
--------

GMT默认的画布尺寸为A4，即 ``210mmx297mm`` 。

通过修改 GMT 参数 :ref:`PS_MEDIA <PS_MEDIA>` 可以控制画布的默认尺寸。GMT提供了几十种预定义的画布尺寸，还支持自定义尺寸，详情见 :ref:`PS_MEDIA <PS_MEDIA>` 的说明。

一般不建议随便修改纸张尺寸，一方面期刊对于图件的尺寸可能有要求，另一方面非 A4 尺寸的图直接打印的效果可能很差。

画布颜色
--------

默认的画布颜色为白色，可以通过设置 :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>` 来修改画布颜色。

.. warning::

   若设置画布颜色为其他颜色，则使用 ``psconvert`` 将 PS 文件转化为其他图片格式时无法使用 ``-A`` 选项进行裁边。

画布方向
--------

取一张 A4 纸放在桌面上，有两种放置的方式：竖着放和横着放。如图所示：

.. figure:: /images/GMT_-P.*
   :width: 500px
   :align: center

   画布方向

图中左边把纸张竖着放的称为Portrait（肖像）模式，右边把纸张横着放的方式称为Landscape（风景）模式。记起来也很简单，人是瘦长的，所以人的肖像照需要竖着拍，风景是矮胖的，就需要横着拍。

.. note::

   对于Portrait模式和Landscape模式，还有另外一种理解方式，即认为画布总是竖着放的。

   - Portrait模式：此模式下坐标原点位于纸张左下角，X轴从左到右递增，与画布的短边平行，Y轴从下往上递增，与画布的长边平行
   - Landscape模式：此模式下坐标原点位于纸张右下角，X轴从下往上递增，与画布的长边平行，Y轴从右往左递增，与画布的短边平行

   这种理解方式下，Landscape模式可以认为是在Portrait模式的基础上先将坐标原点沿X轴移动到右下角，在将坐标系旋转90度得到。

由于历史原因，GMT中画布的默认放置方式是Landscape模式。有两种方式可以修改画布方向：

#. 在第一个\ **绘图**\ 命令中使用 :doc:`/option/P`
#. 修改GMT参数中的 :ref:`PS_PAGE_ORIENTATION <PS_PAGE_ORIENTATION>`

.. tip::

    Linux下默认的PS阅读器evince可以自动识别两种模式，Landscape模式的PS文件横着放，Portrait模式的文件竖着放，所以看上去总是对的。而 ``gs`` 无法自动识别两种模式，总是将文件竖着放，因而用gs看Landscape模式的PS文件时就会很别扭。

.. note::

   从底层来看，Landscape模式和Portait模式的PS文件之间的差异在于，Landspace 模式下的PS代码为::

    V 595 0 T 90 R 0.06 0.06 scale

   而 Portrait 模式下的 PS 代码为::

    V 0.06 0.06 scale

   ``595 0 T 90 R`` 的含义应该是将坐标系移动（ **T**\ ransition）到 ``(595,0)`` 再旋转（ **R**\ otate）90度，即由Portrait模式变成Landscape模式。

底图原点
--------

准备好画布之后，可不能随便找一个点就开始画了，还需要定义底图的原点。GMT默认的底图原点距左下角 ``(1i,1i)`` ，即坐标原点离纸张左下角的距离是水平方向偏移1英寸，垂直方向偏移1英寸。

.. figure:: /images/GMT_basemap_origin.*
   :width: 600px
   :align: center

   底图原点

图中所示是一个完整的A4画布。其中灰色实线的间距是 1 cm，灰色虚线（右键查看大图）的间距是 0.5 cm。图中的底图用如下命令得到::

    gmt psbasemap -R0/10/0/10 -JX10c/10c -B1 -B+glightblue > map.ps

该命令中， ``-JX10c/10c`` 规定了底图的宽和高都是 10 cm，可以看到，底图的左边界位于 ``1i`` ，右边界位于 ``1i+10c`` 处，下边界位于 ``1i`` ，上边界位于 ``1i+10c`` 处。

.. important::

   此处提到的底图原点是指矩形底图的坐标轴的左下角相对于画图左下角的位置，而不包括坐标轴的标注或标签部分。

有两种方式可以修改底图的原点位置：

#. 修改GMT参数 :ref:`MAP_ORIGIN_X <MAP_ORIGIN_X>` 和 :ref:`MAP_ORIGIN_Y <MAP_ORIGIN_Y>`
#. 命令中使用 :doc:`/option/XY`

.. source: http://gmt.soest.hawaii.edu/doc/latest/GMT_Docs.html#portrait-plot-orientation-the-p-option
