.. index:: !psconvert

psconvert
=========

:官方文档: :doc:`gmt:psconvert`
:简介: 将 GMT 生成的 PS/EPS 文件转换为其他图片格式

.. note::

   本模块原名为 ``ps2raster`` ，v5.2.1 版本起更名为 ``psconvert``

该模块通过调用 GhostScript 将 PS/EPS 文件转换为其他图片格式，包括BMP、EPS、JPEG、
PDF、PNG、PPM、SVG、TIFF 格式。

必选选项
--------
``psfiles``
    要转换格式的 PS 文件名

    默认情况下，转换后的文件与转换前的文件有相同的文件名，文件后缀由文件格式决定。

    如下命令会将PS文件转换成JPG格式::

        gmt psconvert test.ps
        gmt psconvert test1.ps test2.ps map*.ps

可选选项
--------

``-A[u][<margins>][-][+p<paint>][+p[<pen>]][+r][+s[m]|S<width>[<u>]/<height>[<u>]]``
    对输出的图片做裁边

    默认情况下，转换得到的图片的大小由PS文件的纸张尺寸决定。通常画图的时候是
    不会把一张A4纸画满的，所以在图片周围就会出现多余的白色部分。

    ``-A`` 选项会对PS文件进行裁剪，仅保留其中有绘图的部分::

        gmt psconvert -A test.ps

    ``-Au`` 会先将GMT的时间戳去掉再裁剪。

    默认的裁剪方式会将图片裁剪到尽可能小。如果想要图片周围有额外的白色区域，可以
    加上额外的边距 ``<margins>`` 。其中 ``<margins>`` 可以取：

    #. 一个数，四条边的额外边距相同，如 ``-A0.5c``
    #. 两个数字，分别指定X和Y方向的额外边距，如 ``-A0.5c/1c``
    #. 四个数字，分别指定左右下上四条边的边距，如 ``-A0.5c/0.5c/0.5c/0.5c``

    ``-A+s`` 可以指定最终图片的尺寸：

    - ``-A+s<width>`` 指定最终生成的图片的宽度，高度自动决定。程序会对图片做
      插值以保证 ``-E`` 的值
    - ``-A+S<scale>`` 指定图片的缩放比例
    - ``-A+sm<width>/<height>`` 设置图片所允许的最大尺寸。若原始图片的宽度
      不大于 ``<width>`` 则使用图片的原始尺寸， ``<height>`` 同理。

    如下命令会生成一个宽为5厘米的图片::

        gmt psconvert -A+s5c test.ps

    - ``-A+r`` 使得在计算边界时使用round函数而不是ceil函数，这会对裁剪造成极其
      微小的区别，仅当要处理非常小的图片时才需要使用。
    - ``-A+g<paint>`` 为BoundingBox指定填充色
    - ``-A+p<pen>`` 为BoundingBox指定边框颜色，默认颜色为 ``0.25p,black``
    - ``-A-`` 覆盖 ``-W`` 选项中自动设置的 ``-A`` 值

``-C<gs_options>``
    传递给 GhostScript 的选项

    该选项用于在调用 GhostScript 时传给 GhostScript 额外的选项，若要额外给
    GhostScript增加多个选项，可重复使用 ``-C`` 命令。

    在Windows下，若PS文件中含中文，则可能需要使用 ``-C`` 选项告诉ghostscript字体路径::

        gmt psconvert -C-sFONTPATH=C:\Windows\Fonts chinese.ps

``-D<outdir>``
    设置输出目录

    默认情况下，会在PS文件同一目录中生成其他图片文件，使用 ``-D<outdir>`` 选项
    可以指定输出目录， ``-D.`` 表示在当前目录输出。需注意，输出目录必须已存在，
    否则会报错。

``-E<dpi>``
    设置图片精度

    值越大，图片越清晰，文件也越大。PDF格式默认值为720，其他格式默认值为300，单位为dpi。

    ::

        gmt psconvert -Tj -E600 test.ps

    说明：

    #. EPS是矢量图片格式，-E选项对其无效
    #. PDF是矢量图片格式，-E选项对其中的pattern和字体有效

``-F<out_name>``
    指定输出的文件名

    默认情况下，该命令会直接使用输入的PS文件名，并修改其后缀作为输出文件的文件名。
    比如 ``test.ps`` 转换出的图片则为 ``test.jpg`` 、 ``test.png`` 之类的。

    ``-F`` 选项可强制指定输出文件名，文件后缀由输出的文件格式自动决定::

        gmt psconvert -Tf -Fout test.ps

``-G<ghost_path>``
    指定GhostScript可执行文件的路径

    ``psconvert`` 底层调用了 GhostScript 来实现PS到其他格式的转换，因而成功转换的
    前提是必须能够找到 GhostScript 的可执行文件。 ``-G`` 选项即用于显式指定
    ghostscript可执行文件的路径。

    说明：

    #. Linux下一般不需要设置ghostscript的路径，除非你自己重新编译了gs并安装到了非标准路径下
    #. Windows下，一般也不需要使用该选项，程序会自动从注册表里获取路径信息
    #. 如果从注册表中获取路径失败，则必须指定 ``-G`` 选项，例如 ``-Gc:\programs\gs\gs9.02\bin\gswin64c``

``-I``
    Enforce gray-shades by using ICC profiles.  GhostScript versions
    >= 9.00 change gray-shades by using ICC profiles.  GhostScript 9.05
    and above provide the '-dUseFastColor=true' option to prevent that
    and that is what **psconvert** does by default, unless option **-I** is
    set.  Note that for GhostScript >= 9.00 and < 9.05 the gray-shade
    shifting is applied to all but PDF format.  We have no solution to
    offer other than upgrade GhostScript.

``-L<listfile>``
    ``<listfile>`` 中包含要转换的所有PS文件名

``-P``
    强制转换后的图片为Portrait模式。

    若PS文件在绘图时使用了 ``-P`` 选项，则psconvert的 ``-P`` 选项无效；
    若PS文件在绘图时未使用 ``-P`` 选项，则psconvert的 ``-P`` 选项会将图片旋转90度。

``-Q[g|t][1|2|4]``
    Set the anti-aliasing options for **g**\ raphics or **t**\ ext.
    Append the size of the subsample box (1, 2, or 4) [4]. Default is no
    anti-aliasing (same as *bits* = 1).

``-S``
    在执行ghostscript命令后，将具体的命令打印到标准错误流中，且保留转换过程中的
    所有临时文件。该选项主要用于调试。


``-Tb|e|E|f|F|j|g|G|m|s|t``
    指定要转换的图片格式。可以接如下值：

    - ``b`` ：BMP；
    - ``e`` ：EPS；
    - ``E`` ：带有PageSize命令的EPS；
    - ``f`` ：PDF；
    - ``F`` ：多页PDF；
    - ``j`` ：JPEG（默认值）；
    - ``g`` ：PNG；
    - ``G`` ：透明PNG；
    - ``m`` ：PPM；
    - ``s`` ：SVG；
    - ``t`` ：TIFF；

    说明：

    #. ``g`` 和 ``G`` 的区别在于前者背景色为白色，后者背景色为透明；
    #. 对于 ``bjgt` 格式可以在其后加 ``-`` 将PS文件转换为灰度图；
    #. EPS格式可以与其他格式合在一起使用。比如 ``-Tef`` 会同时生成EPS和PDF文件。
       除此之外，该命令一次只能转换一种格式，比如 ``-Tbf`` 则只会生成PDF格式
       （即以 ``-T`` 选项中的最后一个格式为准）
    #. ``-TF`` 会将多个PS/PDF文件转换并合并成一个多页的PDF文件，需要使用
       ``-F`` 选项指定输出的文件名

    转换为PDF格式::

        gmt psconvert -Tf test.ps

    转换为JPG格式的灰度图::

        gmt psconvert -Tj test.ps

    利用一堆PS文件生成一个多页PDF::

        gmt psconvert -TF -Fout.pdf *.ps

``-W``
    见官方文档

``-Z``
    转换完成后删除输入的PS文件。若转换失败，输入的PS文件不会被删除。

其他
----

#. 转换为PDF、PNG时使用DEFALTE压缩；转换为TIFF时使用LZW压缩；
#. 对于小dpi的图件而言，可以使用 ``-Qt4 -Qg4`` 使得文字和线条看上去更加尖锐；
#. psconvert还可以用于其他命令生成的PS文件；

FAQ
---

#. 错误信息::

       GMT PS format detected but file is not finalized. Maybe a -K in excess? No output created.

   出现这种错误的最常见原因是最后一个绘图命令里多了一个 ``-K`` ，即本该只使用
   ``-O`` 选项关闭PS文件的，但却使用了 ``-K -O`` 选项。

BUGS
----

#. Windows下会自动为文件名加双引号，导致无法找到要转换的PS文件（v5.1.1）
#. 使用 ``-A`` 选项时， ``-C`` 选项无效，导致无法在Windows转换含中文的PS文件（v5.1.1）
#. 不能使用 ``-F`` 选项，即不能生成多页PDF（v5.1.2）
#. ``-Z`` 选项无效（v5.2.1）
