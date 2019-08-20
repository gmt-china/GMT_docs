画布
====

要画一张图，首先需要准备一个画布。GMT默认的画布是一个PDF文件。

图片格式
--------

GMT支持多种矢量图片格式和位图图片格式。

矢量图片格式包括PDF（推荐使用）、PS 和 EPS 格式；位图图片格式包括PNG（推荐）、
JPG（推荐）、BMP、PPM和TIFF格式。

在开始GMT绘图时，即可指定要生成的图片格式。例如，下面的示例指明同时生成PDF和PNG
格式的图片::

    gmt begin figname pdf,png
    gmt ...
    gmt end

.. tip::

    如无特殊需求，不建议使用PS图片格式。PS图片格式具有如下缺点（在后面会提到）：

    #. 不支持透明色
    #. 默认画布大小为A4，而其它格式默认画布大小均为10米x10米
    #. PS阅读器只有一两款，不如PDF或其它图片格式选择性多

画布颜色
--------

默认的画布颜色为白色，可以通过设置 :ref:`PS_PAGE_COLOR <PS_PAGE_COLOR>` 来修改画布颜色::

    gmt begin map pdf,png
    gmt set PS_PAGE_COLOR lightred
    gmt ...
    gmt end

画布大小
--------

GMT中默认画布宽10米高10米，在生成图片文件时会自动将未使用的白色区域裁减掉，
因而用户无需担心。

唯一的例外是PS图片格式，若选择PS作为图片格式，则默认画布大小为 A4 纸大小。
当用户需要更大的画布时，需要修改参数 :ref:`PS_MEDIA <PS_MEDIA>` 来修改画布尺寸::

    gmt begin map ps
    gmt set PS_MEDIA A1
    gmt ...
    gmt end

