画布
====

要画一张图，首先需要准备一个画布。GMT 默认的画布是一个 PDF 文件。

图片格式
--------

GMT 支持多种矢量图片格式和位图图片格式。

矢量图片格式包括 PDF（推荐使用）、PS 和 EPS 格式；位图图片格式包括 PNG（推荐）、
JPG（推荐）、BMP、PPM 和 TIFF 格式。

在开始 GMT 绘图时，即可指定要生成的图片格式。例如，下面的示例指明同时生成 PDF 和 PNG 格式的图片::

    gmt begin figname pdf,png
        gmt ...
    gmt end show

.. tip::

    如无特殊需求，不建议使用 PS 图片格式。PS 图片格式具有如下缺点（在后面会提到）：

    #. 不支持透明色
    #. 默认画布大小为 A4，而其它格式默认画布大小均为 11.55 米x11.55 米（允许的最大尺寸）
    #. PS 图片格式不支持裁剪，而其它图片格式均支持自动裁剪
    #. PS 阅读器只有一两款，不如 PDF 或其它图片格式选择性多

画布白边
--------

::

    gmt begin map pdf A+m1c/1c/0.5c/0.5c
        gmt basemap -R0/10/0/10 -JX10c -Baf
    gmt end show

画布大小
--------

GMT 中默认使用宽 11.55 米、高 11.55 米的画布，绘图原点位于画布左下角。
在最终生成图片文件时会自动将未使用的白色区域裁减掉，因而用户无需关心画布大小。

若需要生成特定尺寸的图片，而不裁剪周边的白色区域，可以修改 GMT 参数
:term:`PS_MEDIA` 来指定纸张尺寸::

    gmt begin map
        gmt set PS_MEDIA A4
        gmt ...
    gmt end show

PS 图片格式是一个例外。若选择 PS 作为图片格式，则默认画布大小为 A4 纸大小。
当用户需要更大的画布时，则必须修改 GMT 参数 :term:`PS_MEDIA` 来修改画布尺寸::

    gmt begin map ps
        gmt set PS_MEDIA A1
        gmt ...
    gmt end

画布颜色
--------

默认的画布颜色为白色，可以通过修改 GMT 参数 :term:`PS_PAGE_COLOR` 来修改画布颜色::

    gmt begin map pdf,png
        gmt set PS_PAGE_COLOR lightred
        gmt ...
    gmt end show

