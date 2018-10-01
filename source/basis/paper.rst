画布
====

要画一张图，首先需要准备一个画布。GMT的画布就是PDF、PNG等图片文件。

图片格式
--------

GMT可以生成矢量图片格式也可以生成位图图片格式。

矢量图片格式包括：
`PDF <https://zh.wikipedia.org/wiki/PDF>`_\ 、\
`PS <https://zh.wikipedia.org/wiki/PostScript>`_\ 、\
`EPS <https://zh.wikipedia.org/wiki/EPS>`_\ 、\
`SVG <https://zh.wikipedia.org/wiki/SVG>`_\ 。

位图图片格式包括：
`PNG <https://zh.wikipedia.org/wiki/PNG>`_\ 、\
`JPEG <https://zh.wikipedia.org/zh/JPEG>`_\ 、\
`BMP <https://en.wikipedia.org/wiki/BMP_file_format>`_\ 、\
`PPM <https://zh.wikipedia.org/wiki/PBM格式>`_\ 、\
`TIF <https://zh.wikipedia.org/wiki/TIFF>`_\ 。

.. note::
    
    在无特殊需求的情况下，推荐优先使用PDF、JPEG和PNG图片文件格式。

画布尺寸
--------

GMT默认的画布是尽可能大的，用户可以不用管画布的尺寸任意绘图。
GMT在最终生成图片时会自动将画布中多余的白边裁剪掉。

一个例外是PS图片文件格式。若想要输出PS图片文件，则GMT默认的画布尺寸为A4，
即 ``210mmx297mm``\ 。若实际的绘图区域大于该尺寸，则在最终成图中会出现图片被截断/
显示不完整的情况。此时可以通过修改 GMT 参数 :ref:`PS_MEDIA <PS_MEDIA>` 来控制画布的
尺寸。GMT提供了几十种预定义的画布尺寸，还支持自定义尺寸，
详情见 :ref:`PS_MEDIA <PS_MEDIA>` 的说明。

画布颜色
--------

默认的画布颜色为白色，可以通过设置 :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>` 来修改画布颜色。

底图原点
--------

准备好画布之后，可不能随便找一个点就开始画了，还需要定义底图的原点。
GMT默认的底图原点位于画布左下角，向右为X轴增大方向，向上为Y轴增大方向。
