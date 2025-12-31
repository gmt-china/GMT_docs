:author: 田冬冬, 朱邓达
:date: 2025-06-14

.. index:: ! grdimage
.. program:: grdimage

grdimage
==========

:官方文档: :doc:`gmt:grdimage`
:简介: 绘制网格数据或图片

语法
----

**gmt grdimage** 
*grid* \| *image*
:option:`-J`\ *parameters*
[ :option:`-A`\ *out_img*\ [**=**\ *driver*] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-D`\ [**r**] ]
[ :option:`-E`\ [**i**\|\ *dpi*] ]
[ :option:`-G`\ *color*\ [**+b**\|\ **f**] ]
[ :option:`-I`\ [*file*\|\ *intens*\|\ **+a**\ *azimuth*][**+d**][**+m**\ *ambient*][**+n**\ *args*] ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-Q`\ [*color*][**+i**][**+t**][**+z**\ *value*] ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*] ]
[ :option:`-T`\ [**+o**\ [*pen*]][**+s**] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-f`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-x`\ [[-]n] ]
[ :doc:`--PAR=value </conf/overview>` ]

描述
--------

**grdimage** 读取一个二维网格文件，并通过构建一个矩形图像并根据 z 值和 CPT 文件为像素分配灰度
（或颜色）来生成灰度阴影（或彩色）地图。可以通过提供一个强度值在 ±1 范围内的文件或指令从输入数据网格中推导强度值来添加光照。
超出此范围的值将被裁剪。此类光照强度文件可使用 :doc:`grdgradient` 从网格创建，并可使用 :doc:`grdmath` 或 :doc:`grdhisteq` 进行修改。
或者，传入 *image* ，它可以是一个图片文件（带地理参考或不带）。此时也可使用通过 :option:`-I` 选项提供的文件进行光照。
这里，如果图片没有坐标，则使用强度文件的坐标。

使用地图投影时，网格首先会在具有相同尺寸的新矩形网格上重新采样。使用 :option:`-E` 选项设置一个较大的 dpi 值，获得更高分辨率的图像。
为了获取每个地图像素的重采样值（从而确定其阴影或颜色），会将其位置反向投影回输入网格，然后在输入网格周围进行插值。
默认情况下使用双三次插值 (bi-cubic interpolation)。为了避免混叠，还会将输入网格节点正向投影。
如果两个或多个节点投影到同一个像素上，则使用它们的平均值。插值和混叠通过 :doc:`/option/n` 进行控制。

请注意，在使用地图投影绘图时，每个网格节点上绘制的小矩形并不会根据所选的投影方式进行变形。
因此当网格间距较大时，绘制出的图像会产生一定的失真与变形。 此时可以使用 :option:`-E` 选项设置一个较大的 dpi 值，
将图像重采样成较高的分辨率缓解这一问题。 当然最根本的解决方式是使用分辨率更高的数据，
生成网格间距更小的 grd 网格文件进行绘图。

:option:`-R` 选项可用于选择比网格范围更大或更小的地图区域。:option:`-A` 允许直接输出到光栅文件，而不是通过 PostScript 绘图。

.. note::

    当前 GMT 6.5 版本 不支持 :option:`-Q` 和 :option:`-I` 同时使用，可切换到 GMT 6.4 或 GMT 开发版本，
    详见 `PR #8643 <https://github.com/GenericMappingTools/gmt/pull/8643>`_ 。

必选选项
--------

*grid* \| *image*
    2D 网格 *grid* 或图片 *image* 。

.. include:: explain_-J.rst_

可选选项
--------

.. option:: -A

**-A**\ *out_img*\ [**=**\ *driver*]

    将图片以光栅格式保存，而非默认的 PostScript 格式，后跟 *out_img* 以选择图像文件名和扩展名。
    如果扩展名为 .bmp, .gif, .jp[e]g, .png, 或 .tif 之一，则不需要驱动 *driver* 信息，对于其它格式则必须指定。
    *driver* 是 GDAL 程序使用的驱动代码，详见 :doc:`/utilities/gdal` 。
    可以添加 **+c**\ *options* 指定一个或多个拼接的 **GDAL -co** 选项的列表 *options* 。
    例如，输出 GeoPDF 并启用 TerraGo 格式，使用 *=PDF+cGEO_ENCODING=OGC_BP* 。

    **注：**
    (1) 如果选择了 tiff 文件 (.tif)，具体输出格式需根据实际情况——如果指定的 GMT 投影语法可以转换到 `PROJ <https://proj.org/>`_ 语法，
    则输出为带有地理坐标信息的 GeoTIFF 图片，否则输出为普通 tiff。
    (2) 会丢失所有矢量元素。
    (3) :option:`-B` 不能和 :option:`-A` 同时使用，因为不输出 PostScript 。


.. include:: explain_-B.rst_

.. include:: use_cpt_grd.rst_

.. option:: -D

**-D**\ [**r**]
    GMT 会自动检测输入的标准图片格式（GeoTIFF, TIFF, JPG, PNG, GIF 等），然后使用 GDAL 程序读取。
    对于一些可能未知的图片格式用户需要显式设置 :option:`-D` ，以表明输入文件为图片格式，需用 GDAL 程序读取。
    后跟 **r** 表明范围由 :option:`-R` 指定。例如，用户使用了 **-Rd** 表明图片的全部范围。
    此模式允许用户投影原始图片（即没有参考坐标的图片）。

.. option:: -E

**-E**\ [**i**\|\ *dpi*]
    设置创建投影网格的分辨率（仅当选择的投影方式不是线性或墨卡托投影时），默认 100。
    默认情况下，投影网格的大小（行数和列数）与输入文件相同。指定 **i** 可使用 PostScript 图像操作符在设备分辨率下对图像进行插值。

.. option:: -G

**-G**\ *color*\ [**+b**\|\ **+f**]
    该选项仅当想生成黑白图（1-bit 图像）时才可用。
    此时将输入作为透明掩码，并用指定的颜色 *color* 填充该掩码。
    **+b** 表示绘制背景像素， **+f** 表示绘制前景像素（默认）。

.. include:: explain_intense.rst_

.. option:: -M

**-M**
    使用 YIQ 转换（老式电视）强制将其转换为灰度图。不可与 :option:`-Q` 共用。

.. option:: -N

**-N**
    对于非矩形地图，在地图边界处不对图片做裁剪。

.. option:: -Q

**-Q**\ [*color*][**+i**][**+t**][**+z**\ *value*]
    处理网格或图片的透明度或不透明度。通常有以下几种情况：

    + 网格： :option:`-Q`\ [**+z**\ *value*]

      无参数的 :option:`-Q` 将值为 NaN 的节点处设置为透明色，使用 PostScript Level 3 的 color-masking 功能
      （PS 设备需支持 PS Level 3）。可使用子选项 **+z**\ *value* 将 NaN 值替换为 *value* 。
      此时每个像素点要么是不透明的颜色，要么是完全透明的。

    + RGB 图片： :option:`-Q`\ [*color*]

      后跟 *color* 来将指定颜色 *color* （默认为白色）的像素设为完全透明。
      输出图像中的每个像素要么是不透明的，要么是透明的。

    + Alpha 通道仅为 0 或 255 的 RGBA 图片： :option:`-Q`

      将 Alpha=0 的像素设为完全透明，Alpha=255 为不透明。

    + 渐变 Alpha 通道的 RGBA 图片： :option:`-Q`\ [*color*][**+i**][**+t**]

      将渐变透明度转换为模拟透明，此时每个像素点的颜色 *r,g,b* 转换公式为 :math:`r' = t R + (1-t) r` ，
      其中 :math:`t` 为透明度，:math:`R` 为透明色 *color* （默认为白色）。
      这种转换本质是颜色混合，而非真透明，产生的文件体积较小。
      可使用 **+t** 表明生成真透明效果，但 PostScript无法直接支持，此时将通过 PositScript 的微小色块模拟渐变透明，文件体积激增。
      如果 Alpha 值存储的是不透明度而非透明度，可使用 **+i** 反转 Alpha 值（网格文件不能使用 **+i** ）。

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

.. option:: -T

**-T**\ [**+o**\ [*pen*]][**+s**]
    不做任何插值绘制数据网格，其中将每个以节点为中心的格子转换成一个多边形，然后分别绘制。
    此选项适用于值之间的插值没有意义的分类数据，并且通过 :option:`-C` 提供了分类CPT。
    加上 **+o**\ [*pen*] 可绘制每个小块的轮廓并自定义画笔属性 *pen* 。加上 **+s** 跳过 z=NaN 的节点。

.. include:: explain_-U.rst_

.. include:: explain_-XY.rst_

.. include:: explain_-f.rst_

.. include:: explain_-n.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

绘制有 NaN 的网格
---------------------

请注意，如果用户的输入网格中存在 NaN 区域，那么由于大多数地图投影所必须进行的重采样操作，
这些 NaN 块的范围可能会扩大。因为 **grdimage** 使用的是 PostScript 彩色图像操作符，
所以对于大多数非线性投影，GMT 必须将用户的网格重采样到等距的矩形格网上。如果用户
发现这些 NaN 区域未得到妥善处理，建议（a）采用线性投影，或者（b）使用 **-T+s** 参数来绘制格子多边形。

.. include:: explain_grdresample.rst_

绘制分类网格
---------------

地理分类网格在节点处的数值不应进行插值（例如，类别 4 和 5 不能平均得到新的类别 4.5）。
然而，使用地图投影来呈现这样的网格需要将其重采样到等距的笛卡尔网格，这通常会导致这种融合现象。
此时程序不知道该网格是否为分类网格，但如果通过 :option:`-C` 提供的分类图谱是分类的，
程序将用 **-nn+a** （开启最近邻网格化并关闭抗锯齿）来覆盖用户所选择的（可能是隐含的） **-n** 设置。
或者，可以使用 :option:`-T` 来绘制每个节点为中心的单独多边形。

绘制分类图片
-----------------

如果给定的是一个单字节的单层图片，并且该文件没有颜色映射，那么 GMT 将把字节值视为类别，
并且需要通过参数 :option:`-C` 来指定一个分类的 CPT。如果没有给出参数 :option:`-C` ，那么 GMT 假定该图像是一个灰度图像，
其值在 0 到 255 的范围内。

透明度的限制
---------------

PostScript 图像模型不支持任何形式的透明度。然而，Adobe 添加了
`pdfMark <https://opensource.adobe.com/dc-acrobat-sdk-docs/library/pdfmark/index.html>`_ ，
它使得 PostScript 能够指定透明度，但只有在使用 Adobe Distiller 或 GhostScript 将 PostScript 或 EPS 转换为 PDF 时才会激活。
每个图形（例如多边形、线条、文本、图像）都可以指定透明度。
然而，对于图像来说，这一点非常有限： GMT 可以选择图像的特定特征来表示透明度，例如特定的 *r*/*g*/*b* 颜色或 *alpha* 通道级别（0 - 255）。
因此，在复杂的 RGBA 图像（颜色 + 透明度）中，像素级别的可变透明度最多只能是单一颜色的可见形式。
GMT 绘制透明的 RGBA 图像的近似方法是模拟颜色的透明效果，但图像本身仍然是不透明的（可通过 :option:`-Q` 参数实现除单一颜色外的透明效果）。
由于多边形可以有不同的透明度，因此 GMT 可以通过带有可单独设定颜色和透明度的正方形符号来模拟图像
（通过（最多）255 个值的 alpha 通道实现）。

识别图片格式
---------------

GMT 通过图片文件的特殊字节来自动识别图像格式。对于可能包含图片或数据集的格式（例如 GeoTIFF），
GMT 会判断其属于哪种类型，并相应地进行处理。如果用户最喜欢的图像格式未被自动识别，
那么请告知 GMT 它的特殊字节，以便添加支持。

.. include:: explain_grdresample.rst_

.. include:: macos_preview_issue.rst_

示例
----

.. include:: explain_example.rst_

绘制远程文件 *@AK_gulf_grav.nc* 并设置照明::

    gmt grdimage @AK_gulf_grav.nc -I+d -B -pdf quick

在一个自定义的 Lambert 地图上绘制 *@AK_gulf_grav.nc* 的灰度图::

    gmt begin alaska_gray
        gmt grd2cpt -Cgray @AK_gulf_grav.nc
        gmt grdimage @AK_gulf_grav.nc -Jl142W/55N/18/24/1.5c -B
    gmt end show

指定光照强度文件::

    gmt grdimage image.nc -Jx10i -Ccolors.cpt -Iintens.nc -B5 -pdf image

以正弦投影绘制远程图片 *@needle.jpg* ::

    gmt grdimage -JI15c -Rd @needle.jpg -pdf needle

相关模块
---------

:doc:`grdcontour`,
:doc:`grdview`,
:doc:`grdgradient`,
:doc:`grdhisteq`
