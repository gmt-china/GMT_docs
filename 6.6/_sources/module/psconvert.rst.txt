:author: 田冬冬, 邓山泉, 陈箫翰
:date: 2026-01-10

.. index:: ! psconvert
.. program:: psconvert

psconvert
=========

:官方文档: :doc:`gmt:psconvert`
:简介: 将 GMT 生成的 PS/EPS 文件转换为其它图片格式

**psconvert** 模块通过调用 Ghostscript 将 PS/EPS 文件转换为其它图片格式，包括BMP、EPS、JPEG、PDF、PNG、PPM、TIFF 格式。
输入文件名从命令行或包含文件名列表的文件中读取。生成图像的大小由 BoundingBox（或 HiResBoundingBox）决定。可以选择先计算一个紧凑的 (HiRes)BoundingBox。
另外也可以计算 ESRI 类型的世界文件 (world files)，用于为 TIFF 文件提供地理参照，并使其被识别为 GeoTIFF。

**注意**：如果 PostScript 文件调用了任何 Adobe PDF 透明度扩展，且 PDF 不是选定的输出格式，
则该文件将首先被转换为临时 PDF 文件（以使透明度生效），然后再将 PDF 转换为所需的输出格式。

语法
----

**gmt psconvert**
*psfile(s)*
[ :option:`-A`\ [**+r**][**+u**] ]
[ :option:`-C`\ *gs_option* ]
[ :option:`-D`\ *outdir* ]
[ :option:`-E`\ *resolution* ]
[ :option:`-F`\ *out_name* ]
[ :option:`-G`\ *ghost_path* ]
[ :option:`-H`\ *scale* ]
[ :option:`-I`\ [**+m**\ *margins*][**+s**\ [**m**]\ *width*\ [/\ *height*]][**+S**\ *scale*] ]
[ :option:`-L`\ *list* ]
[ :option:`-M`\ **b**\|\ **f**\ *pslayer* ]
[ :option:`-N`\ [**+f**\ *fade*][**+g**\ *background*][**+k**\ *fadecolor*][**+p**\ [*pen*]] ]
[ :option:`-Q`\ [**g**\|\ **p**\|\ **t**][1\|2\|4] ]
[ :option:`-S` ]
[ :option:`-T`\ **b**\|\ **e**\|\ **E**\|\ **f**\|\ **F**\|\ **j**\|\ **g**\|\ **G**\|\ **m**\|\ **t**\ [**+m**][**+q**\ *quality*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [**+a**\ *altmode*\ [*alt*]][**+c**][**+f**\ *minfade/maxfade*][**+g**][**+k**][**+l**\ *minLOD/maxLOD*][**+n**\ *layername*][**+o**\ *foldername*][**+t**\ *docname*][**+u**\ *URL*] ]
[ :option:`-Z` ]
[ :doc:`--PAR=value </conf/overview>` ]

必须选项
--------

*psfiles*
    要转换格式的 PS 文件名

    默认会在当前目录下生成与与原始 PS 文件相同文件名的新格式文件，文件后缀由文件格式决定。
    可以使用 :option:`-F` 设置文件名，使用 :option:`-D` 设置文件输出目录。

可选选项
--------

.. option:: -A

**-A**\ [**+r**][**+u**]
    根据图片内容的大小对画布做裁剪，将 BoundingBox 和 HiResBoundingBox 调整为图像内容所需的最小值。可以使用以下两个附加选项：

    * **+r** ：在计算图片大小时，对 HighResBoundingBox 进行“四舍五入” ( *round* 函数) 而非使用 *ceil* 函数。
      这个操作虽然违反了 Adobe 的规范，但在创建一像素之差都很重要的极小图像时非常有用。如果使用了 :option:`-V`，还会报告图片的最终尺寸。
    * **+u** ：首先移除任何由 GMT 生成的时间戳（即由 **-U** 设置的时间戳）。

.. option:: -C

**-C**\ *gs_option*
    额外传递给 Ghostscript 的选项

    该选项用于在调用 Ghostscript 时传给 Ghostscript 额外的选项，若要额外给
    Ghostscript 增加多个选项，可重复使用 :option:`-C` 命令。

.. option:: -D

**-D**\ *outdir*
    设置输出目录

    默认情况下，会在PS文件同一目录中生成其他图片文件，使用 :option:`-D` 选项
    可以指定输出目录。**-D.** 表示在当前目录输出。

.. option:: -E

**-E**\ *resolution*
    设置图片精度

    值越大，图片越清晰，文件也越大。PDF格式默认值为720，其他格式默认值为300，单位为dpi。
    **注意** ：Ghostscript 限制光栅图像的最终宽度和高度像素尺寸必须小于或等于 65536。

.. option:: -F

**-F**\ *out_name*
    指定输出的文件名

    默认使用使用输入的PS文件名，并修改其后缀作为输出文件的文件名。
    比如 *test.ps* 转换出的JPG格式的图片则为 *test.jpg*。

    :option:`-F` 选项可强制指定输出文件名，文件后缀由输出的文件格式自动决定。

.. option:: -G

**-G**\ *ghost_path*
    指定 Ghostscript 可执行文件的路径

    **psconvert** 底层调用了 Ghostscript 来实现 PS 到其他格式的转换，因而成功转换的
    前提是必须能够找到 Ghostscript 的可执行文件。:option:`-G` 选项即用于显式指定
    Ghostscript 可执行文件的路径。

    说明：

    - Linux 下一般不需要设置 Ghostscript 的路径，除非你自己重新编译并安装到了非标准路径下
    - Windows 下，一般也不需要使用该选项，程序会自动从注册表里获取路径信息
    - 如果从注册表中获取路径失败，则必须使用 :option:`-G` 选项指定路径，如 ``-GC:\Program Files\gs\gs10.06.0\bin\gswin64c``

.. option:: -H

**-H**\ *scale*
    由于将 PostScript 帧光栅化为光栅图时使用的单位点数（dots-per-unit）有限，将要素量化为离散像素会导致舍入误差。
    抗锯齿设置 :option:`-Q` 可以缓解部分影响，但该设置仅对线条和文本有效。
    使用本选项通过指定 *scale*，可以临时将有效单位点数增加 *scale* 倍进行光栅化，最后再在结尾按相同比例对图像进行降采样。
    *scale* 越大，生成的光栅图越平滑。由于处理时间随 *scale* 增加而增加，建议尝试使用 2-5 范围内的值。
    请注意，当原始数据的分辨率远高于光栅像素尺寸时，光栅图像也会受到量化误差的影响。此时可使用本选项平滑结果以避免锯齿 [默认不进行降采样]。

.. option:: -I

**-I**\ [**+m**\ *margins*][**+s**\ [**m**]\ *width*\ [/\ *height*]][**+S**\ *scale*]
    默认情况下，转换得到的图片的大小由 PS 文件的纸张尺寸决定。通常画图的时候是
    不会把一张A4纸画满的，所以在图片周围就会出现多余的白色部分。

    :option:`-A` 选项会对 PS 文件进行裁剪，仅保留其中有绘图的部分，即裁去白边::

        gmt psconvert -A test.ps

    默认的裁剪方式会将图片裁剪到尽可能小。如果想要图片周围有额外的白色区域，
    可以使用 **+m**\ *margins* 指定额外的空白量。其中 *margins* 可以取：

    - 一个数，表示四条边的额外边距相同，如 ``-I+m0.5c``
    - 两个数字，表示分别指定X和Y方向的额外边距，如 ``-I+m0.5c/1c``
    - 四个数字，表示分别指定左右下上四条边的边距，如 ``-I+m0.5c/0.5c/0.5c/0.5c``

    **-I+s** 可以直接指定最终图片的尺寸：

    - **-I+s**\ *width* 指定最终生成的图片的宽度，高度自动决定。程序会对图片做
      插值以保证 :option:`-E` 设置的DPI值
    - **-I+S**\ *scale* 指定图片的缩放比例
    - **-I+sm**\ *width*/*height* 设置图片所允许的最大尺寸。若原始图片的宽度
      不大于 *width* 则使用图片的原始尺寸，*height* 同理。

.. option:: -L

**-L**\ *listfile*
    *listfile* 是 ASCII 文件，内容是要转换的所有 PS 文件的文件名列表

.. option:: -M

**-Mb**\|\ **f**\ *pslayer*
    将当前的 *psfile* 夹在背景图 **-Mb**\ *pslayer_1* 和前景图 **-Mf**\ *pslayer_2* 这两个 PostScript 绘图之间。
    也可以只有前景或背景其中之一。这些文件应为独立的绘图，并且在堆叠时能够相互对齐。

.. option:: -N

**-N**\ [**+f**\ *fade*][**+g**\ *background*][**+k**\ *fadecolor*][**+p**\ [*pen*]]
    为裁剪后的图片增加填充色、淡化以及绘制边框

    - **+f**\ *fade* ：附加 *fade* 将整个图片向 *fadecolor* [默认为black] 进行淡化。 *fade* 取值为0到100，默认不淡化，即取值为 0。
    - **+g**\ *background* ：为图片增加背景填充色 *background* 。
    - **+k**\ *fadecolor* ：如果设置了 **+f**，则附加 *fadecolor* 以设置淡化颜色 [black]。
    - **+p**\ [*pen*] ：附加 *pen* 指定画笔属性绘制图片边框（不指定则使用默认画笔 0.25p,black）。

.. option:: -Q

**-Q**\ [**g**\|\ **p**\|\ **t**][1\|2\|4]
    设置图片(**g**) 或文字(**t**) 的抗锯齿选项。附加子采样框的大小（1、2 或 4）[默认为 4]。
    对于矢量格式，默认不进行抗锯齿（相当于 *bits* = 1）。对于光栅格式，默认设置为 **-Qt4** 。对于透明PNG格式而言，默认参数是 **-Qt4 -Qg2**。
    这些默认值可以手动更改。可以使用 **-Qp** 开启 GeoPDF 的生成（还需同时使用 :option:`-T`\ **f** ）。

.. option:: -S

**-S**
    在执行Ghostscript命令后，将具体的命令打印到标准错误流中，且保留转换过程中的所有临时文件。该选项主要用于调试。

.. option:: -T

**-Tb**\|\ **e**\|\ **E**\|\ **f**\|\ **F**\|\ **j**\|\ **g**\|\ **G**\|\ **m**\|\ **t**\ [**+m**][**+q**\ *quality*]
    指定要转换的图片格式。

    可以取值：

    - **b** ：BMP
    - **e** ：EPS
    - **E** ：带有 PageSize 命令的EPS
    - **f** ：PDF
    - **F** ：多页PDF
    - **j** ：JPEG（默认值）
    - **g** ：PNG（不透明背景）
    - **G** ：PNG（透明背景）
    - **m** ：PPM
    - **t** ：TIFF

    说明：

    - 对于 **bjgt**，可以附加 **+m** 以获取单色（灰度）图像。
    - 对于 **j**，可以附加 **+q**\ *quality* ，在 0-100 范围内更改 JPEG 质量 *quality* [默认 90]。
    - **g** 和 **G** 的区别在于前者背景色为白色，后者背景色为透明。
    - EPS 格式可以与其他格式合在一起使用。比如 **-Tef** 会同时生成 EPS 和 PDF 文件。除此之外，该模块一次只能转换一种格式，比如 **-Tbf** 则只会生成 PDF 格式。
    - **-TF** 会将多个 PS/PDF 文件转换并合并成一个多页的 PDF 文件，需要使用 :option:`-F` 选项指定输出的文件名。

    转换为PDF格式::

        gmt psconvert -Tf test.ps

    利用多个PS文件生成一个多页PDF::

        gmt psconvert -TF -Fout *.ps

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [**+a**\ *altmode*\ [*alt*]][**+c**][**+f**\ *minfade/maxfade*][**+g**][**+k**][**+l**\ *minLOD/maxLOD*][**+n**\ *layername*][**+o**\ *foldername*][**+t**\ *docname*][**+u**\ *URL*]
    编写一个 ESRI 类型的世界文件 (world file)，使能够识别该文件的软件将 .tif 文件视为 GeoTIFF。
    然而请注意，结果会根据图像内容以及是否使用了 **-B** 选项而有所不同。
    **-B** 选项的问题在于它会创建边框，且极有可能包含标注。
    这会在地图数据范围之外引入像素，从而导致地图范围的估算出现偏差。
    为了避免这个问题，请使用 **--MAP_FRAME_TYPE**\ =inside 选项，
    该选项会将所有标注和刻度绘制在图像内部，因此不会影响坐标计算。
    此外，还要注意绘图任一边缘为纯白色的情况，因为 Ghostscript 会“吞掉”这些白色像素，
    导致算法彻底失败。在这种情况下，必须使用 **-B** 选项或使用稍微偏离白色的颜色。

    结合 :option:`-V` 选项时，会在屏幕上打印 *gdal_translate* 命令
    （*gdal_translate* 是 `GDAL 软件包 <https://gdal.org/>`_ 中的一个命令行工具），
    该命令读取光栅图 + 世界文件并创建一个真正的 GeoTIFF 文件。
    附加 **+g** 以对 *gdal_translate* 进行系统调用并立即创建 GeoTIFF 图像。
    输出文件将具有 .tiff 扩展名。

    世界文件的命名遵循在文件扩展名中插入 'w' 的惯例。
    因此，如果输出是 tif (**-Tt**)，则世界文件为 .tfw；对于 jpeg，得到 .jgw，依此类推。
    **注意**：此选项会自动设置 **-A** 和 **-P**。附加 **+c** 以 *不* 裁剪图像。

    附加 **+k** 以创建一个极简的 KML 文件，以便在 Google Earth 中加载图像。
    注意，要使此选项生效，PostScript 图像必须是使用地理坐标的 **-JX** 或 **-Jx** 笛卡尔投影创建的。
    如果不是，则会发出警告，但仍会创建 KML 文件。
    提供了若干以 **+**\ *opt* 字符串形式出现的修改器选项，用于自定义 KML 文件：

    - **+t**\ *title* ：设置文档标题 [默认为 GMT KML Document]
    - **+n**\ *layername* ：设置图层名称
    - **+a**\ */altmode*\ [*altitude*] ：选择 Google Earth 识别的 5 种高度模式之一，用于确定图像的高度（单位为米）：
        - **G** ：贴地 (clamped to the ground)
        - **g** ：附加相对于地面的高度
        - **a** ：附加绝对高度
        - **s** ：附加相对于海床的高度，
        - **S** ：贴紧海床
    - **+l**\ *minLOD/maxLOD* 和 **+f**\ *minfade/maxfade* ：控制图层的可见性

    如果打算将图像本身保留在服务器上而仅分发 KML，请使用 **+u**\ *URL* 在图像引用前附加 URL。
    如果正在构建一个多组件 KML 文件，则可以使用 **+o**\ *foldername* 修改器发布一个不带 KML 头尾的 KML 片段。
    它会将图像及相关的 KML 代码封装在指定名称的 KML 文件夹中。
    有关进一步解释，请参阅 `KML 文档 <https://code.google.com/apis/kml/documentation/>`_。

    **注意**：如果任何标题或名称在字母旁边包含加号，可能会被误认为选项修改器。
    请在加号前放置反斜杠来进行转义。或者，将字符串括在双引号中，然后将整个 **-W** 参数括在单引号中（反之亦然）。

    关于创建地理参照光栅的进一步说明：
    **psconvert** 可以通过世界文件创建地理参照光栅图像，
    或者使用 GDAL 将 GMT PostScript 文件转换为 GeoTIFF。
    GDAL 使用 `PROJ <https://proj.org/>`_ 作为其投影库。
    为了提供进行地理参照所需的信息，GMT 在 PostScript 文件开头附近嵌入了一条使用 **PROJ** 语法定义投影的注释。
    使用 GMT v4.5 之前版本的 PostScript 文件甚至是非 GMT 生成的 ps 文件的用户，
    可以通过手动在 PostScript 文件中编辑一行以 %%PROJ 为前缀的内容，来提供 **psconvert** 所需的信息。

    例如，命令::

        gmt coast -JM0/12c -R-10/-4/37/43 -W1 -Di -Bg30m --MAP_FRAME_TYPE=inside -ps cara

    会添加如下注释行::

        %%PROJ: merc -10.0 -4.0 37.0 43.0 -1113194.908 -445277.963 4413389.889 5282821.824 +proj=merc +lon_0=0 +k=-1 +x_0=0 +y_0=0 +a=6378137.0 +b=6356752.314245 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

    其中 'merc' 是坐标转换的关键；第 2 到第 5 个元素包含地图范围，
    第 6 到第 9 个元素是投影坐标下的地图范围，该行的其余部分则是此投影的标准 **PROJ** 字符串。

.. option:: -Z

**-Z**
    转换完成后删除输入的 PS 文件。若转换失败，输入的 PS 文件不会被删除。

.. include:: explain_help.rst_

注意事项
--------

转换为光栅图像（BMP、JPEG、PNG、PPM 或 TIFF）不可避免地会导致原始 PostScript 文件中可用细节的丢失。
请根据图像的应用场景选择足够大的分辨率。对于网页，较小的 dpi 值即可满足要求；
对于 Word 文档和 PowerPoint 演示文稿，建议使用更高的 dpi 值。
**psconvert** 在创建 PDF 和 PNG 文件时使用无损 DEFLATE 压缩技术，而在创建 TIFF 图像时使用 LZW 压缩。
对于较小 dpi 的图像（例如构建动画所需的图像），使用 **-Qt**\ 4 和 **-Qg**\ 4 可能有助于使文本和线条更加清晰，
使用 :option:`-H` 选项也有类似效果。

EPS 是一种矢量格式（而非光栅格式）。因此， :option:`-E` 选项对 EPS 文件的创建没有影响。
使用 **-Te** 选项将从 PostScript 文件中移除 setpagedevice 命令，并在使用 :option:`-A` 选项时调整 BoundingBox。
请注意，原始及所需的 BoundingBox 仅限于整数点，因此 Adobe 增加了可选的 HiResBoundingBox 以提高尺寸精度。
:option:`-A` 选项会同时计算这两者并将其写入 EPS 文件，随后根据要求用于任何光栅化过程。
当使用 **-TE** 选项时，会添加一个新的 setpagedevice 命令，该命令将指示绘图的实际页面大小，类似于 BoundingBox。
请注意，如果包含在其他文档中的 PostScript 文件存在 setpagedevice 命令，
可能会对整个文档的打印或查看造成严重干扰。因此， **-TE** 应仅用于“独立”的 PostScript 文件。

尽管 PDF 也是矢量格式，但 :option:`-E` 选项对文档中以位图形式存储的填充图案和字体的分辨率有影响。
因此， **psconvert** 在创建 PDF 文件时会使用较大的默认分辨率。
:option:`-E` 还决定了用于指示输出 PDF 尺寸的 BoundingBox 值的分辨率。
为了获得高质量的 PDF 文件，*/prepress* 选项会生效，
该选项仅允许对嵌入在 PostScript 文件中的光栅图像进行无损 DEFLATE 压缩。

虽然 **psconvert** 是作为 GMT 的一部分开发的，但它可以用于转换几乎任何图形程序创建的 PostScript 文件。
然而， **-A+u** 是 GMT 特有的功能。

转换为 GeoPDF 已被证明是不稳定的，可能会创建无法打开的 PDF 文件。
因此，我们将此设置为一个可选设置，现在需要使用 **-Qp** 选项来激活，
因为大多数用户其实并不了解 GeoPDF。

示例
--------

使用紧凑的 BoundingBox 将文件 psfile.ps 转换为 PNG::

    gmt psconvert psfile.ps -A -Tg

将文件 map.ps 转换为 PDF，进行裁剪，然后将 BoundingBox 扩展 0.2 cm，填充浅蓝色并使用粗画笔绘制轮廓::

    gmt psconvert map.ps -A -I+m0.2c -N+glightblue+pthick -Tf

为裁剪后的 example_01.ps 文件创建一个宽度为 5 cm、分辨率为 300 dpi 的 PNG 版本::

    gmt psconvert example_01.ps -A -I+s5c -Tg

从 3 个独立的 PS 文件中创建一个包含 3 页的 PDF 文件::

    gmt psconvert -TF -Fabc a.ps b.ps c.ps

使用 :doc:`coast` 创建一个简单的线性投影地图，并结合紧凑 BoundingBox 计算将其转换为带有 .tfw 文件的 TIF::

    gmt coast -JX12cd -R-10/-4/37/43 -W1 -Di -Bg30m -G200 --MAP_FRAME_TYPE=inside -ps cara
    gmt psconvert cara.ps -Tt -W

创建上述示例的墨卡托投影版本，并使用 GDAL 生成真正的 GeoTIFF 文件::

    gmt coast -JM0/12c -R-10/-4/37/43 -W1 -Di -Bg30m -G200 --MAP_FRAME_TYPE=inside -ps cara
    gdalwarp -s_srs +proj=merc cara.tif carageo.tiff

创建巴塔哥尼亚 (Patagonia) 的极地方位立体投影 GeoTIFF 文件::

    gmt coast -JS-55/-60/15c -R-77/-55/-57.5/-48+r -Di -Gred -Bg2 --MAP_FRAME_TYPE=inside -ps patagonia
    gmt psconvert patagonia.ps -Tt -W+g -V

创建一个可在 Google Earth 中使用的简单 KML 文件::

    gmt grdimage lonlatgrid.nc -Jx1 -Ccolors.cpt -B0g2 --MAP_FRAME_TYPE=inside -ps tile
    gmt psconvert tile.ps -Tg -W+k+t"my title"+l256/-1 -V

Ghostscript 选项
-----------------------

**psconvert** 中的大多数转换工作由 Ghostscript 处理。在大多数 Unix 系统上，该程序以 **gs** 命令提供；对于 Windows 系统，则有一个名为 **gswin64c** 的版本。
Ghostscript 接受丰富的命令行选项来修改其行为。其中许多选项是由上述 GMT 选项间接设置的。然而，高级用户可能需要添加额外的选项来微调结果。
使用 :option:`-S` 查看实际运行的命令，并通过一个或多个 :option:`-C` 选项添加自定义选项。
例如，若要为所有图像开启图像插值 (image interpolation)，从而以牺牲速度为代价提高缩放图像的质量，请使用 **-C**-dDOINTERPOLATE。
有关完整文档，请参阅 https://www.ghostscript.com/ 。

制作 KMZ 文件
--------------------

如果您制作了一系列 KML 文件（这些文件可能依赖于本地 PNG 图像等其他项），您可以将它们合并为一个 KMZ 文件，以节省空间并将相关文件归类在一起。
`gmt_shell_functions.sh <https://docs.generic-mapping-tools.org/6.6/gmt_shell_functions.sh.html>`_ 中的 Bash 函数 **gmt_build_kmz** 可用于实现此目的。
在使用该函数之前，您需要先运行 source gmt_shell_functions.sh。

弃用说明
----------------

- 6.5.0： **-N** 选项的修改器 **+i** 已弃用（但仍受支持）。`#7972 <https://github.com/GenericMappingTools/gmt/pull/7972>`_
- 6.3.0： **-A** 选项的修改器 **+m**、**+g** 等已移至 **-I** 、 **-N** 或 **-W** 选项。`#5583 <https://github.com/GenericMappingTools/gmt/pull/5583>`_
