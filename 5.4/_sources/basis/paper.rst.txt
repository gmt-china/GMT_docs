画布
====

要画一张图，首先需要准备一个画布。GMT 默认的画布是 A4 大小的横置的白色PS文件。

.. note::

   本节介绍的内容，涉及到后面的一些知识。因而这里只是做简单介绍，具体的操作看不懂也没关系。

图片格式
--------

GMT支持多种矢量图片格式和位图图片格式。

矢量图片格式包括PDF（推荐使用）、PS、EPS和SVG格式；
位图图片格式包括PNG（推荐）、JPG（推荐）、BMP、PPM和TIFF格式。

GMT默认生成的都是PS格式的图片，要想生成其他格式的图片，则可以调用
:doc:`/module/psconvert` 模块将PS图片转换为PDF或JPG等格式的图片。
具体命令为::

    # 生成PDF格式的图片
    gmt psconvert -A -P -Tf xxx.ps

    # 生成JPG格式的图片
    gmt psconvert -A -P -Tj xxx.ps

画布尺寸
--------

GMT默认的画布尺寸为A4，即 ``210mmx297mm``\ 。

通过修改 GMT 参数 :ref:`PS_MEDIA <PS_MEDIA>` 可以控制画布的默认尺寸。GMT提供了
几十种预定义的画布尺寸，还支持自定义尺寸，详情见 :ref:`PS_MEDIA <PS_MEDIA>` 的说明。

画布颜色
--------

默认的画布颜色为白色，可以通过设置 :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>` 来修改画布颜色。

.. warning::

   若设置画布颜色为其他颜色，则使用 ``psconvert`` 将 PS 文件转化为其他图片格式时
   无法使用 ``-A`` 选项进行裁边。

画布方向
--------

取一张 A4 纸放在桌面上，有两种放置的方式：竖着放和横着放。如图所示：

.. gmtplot:: /scripts/GMT_-P.sh
    :show-code: false
    :caption: 画布方向

图中左边把纸张竖着放的称为Portrait（肖像）模式，右边把纸张横着放的方式称为
Landscape（风景）模式。记起来也很简单，人是瘦长的，所以人的肖像照需要竖着拍，
风景是矮胖的，就需要横着拍。

由于历史原因，GMT中画布的默认放置方式是Landscape模式。有两种方式可以修改画布方向：

#. 在第一个\ **绘图**\ 命令中使用 :doc:`/option/P`
#. 设置GMT参数 :ref:`PS_PAGE_ORIENTATION <PS_PAGE_ORIENTATION>` 为 ``portrait``

.. tip::

    Linux下默认的PS阅读器evince可以自动识别两种模式，Landscape模式的PS文件横着放，
    Portrait模式的文件竖着放，所以看上去总是对的。而 ``gs`` 无法自动识别两种模式，
    总是将文件竖着放，因而用gs看Landscape模式的PS文件时就会很别扭。

底图原点
--------

准备好画布之后，可不能随便找一个点就开始画了，还需要定义底图的原点。GMT默认的
底图原点距左下角 ``(1i,1i)``\ ，即坐标原点离纸张左下角的距离是水平方向偏移1英寸，
垂直方向偏移1英寸。

.. gmtplot:: /scripts/GMT_basemap_origin.sh
    :show-code: false
    :caption: 底图原点

图中所示是一个完整的A4画布。其中灰色实线的间距是 1 cm，灰色虚线（右键查看大图）的
间距是 0.5 cm。图中的底图用如下命令得到::

    gmt psbasemap -R0/10/0/10 -JX10c/10c -B1 -B+glightblue > map.ps

该命令中，\ ``-JX10c/10c`` 规定了底图的宽和高都是 10 cm，可以看到，底图的左边界位于
``1i``\ ，右边界位于 ``1i+10c`` 处，下边界位于 ``1i``\ ，上边界位于 ``1i+10c`` 处。

.. important::

   此处提到的底图原点是指矩形底图的坐标轴的左下角相对于画布左下角的位置，
   而不包括坐标轴的标注或标签部分。

可以在命令中使用 :doc:`/option/XY` 来修改底图的原点位置。
