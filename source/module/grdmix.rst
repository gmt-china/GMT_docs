:author: 何星辰, 田冬冬
:date: 2025-10-20

.. index:: ! grdmix
.. program:: grdmix
.. include:: common_SYN_OPTs.rst_

grdmix
=============

:官方文档: :doc:`gmt:grdmix`  
:简介: 混合和变换网格和图像

**grdmix** 将执行涉及图像和网格的各种操作。
我们可以使用 *alpha* 网格、图像或常数，为输入的 *raster1* 图像添加新的 alpha（透明度）层；
或者使用 *weights* 对 *raster1* 和 *raster2* （网格或图像）进行混合，
*raster1* 的权重为 *weights*，而 *raster2* 的权重为 *1 - weights*，并将结果保存为 *outfile*。
另外，我们还可以将图像分解为其组成部分（红、绿、蓝或灰度）网格层，或从归一化的分量网格构建图像。
所有操作都支持使用 *intensity* 网格调整最终彩色图像的亮度、将彩色图像转换为单色图像或移除 alpha 层。
所有的 *raster?*、*alpha*、*intensity* 和 *weights* 文件必须具有相同的尺寸。
可选的 *alpha*、*intensity* 和 *weights* 文件也可以替换为常数值。

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_mixing.png
    :width: 600 px
    :align: center

    将 NASA 蓝色大理石图像分解为红、绿和蓝分量，
    在相同空间分辨率下获取地形的梯度（灰度），
    并将它们组合以获得带有坡度阴影的蓝色大理石图像。

语法
--------

**gmt grdmix**
*raster1* [ *raster2* [ *raster3*]]
:option:`-G`\ *outfile*
[ :option:`-A`\ *alpha*\ [**+o**] ]
[ :option:`-C`\ [*section*/]\ *master*\|\ *cpt*\|\ *color*\ :math:`_1`,\ *color*\ :math:`_2`\ [,\ *color*\ :math:`_3`\ ,...]\ [**+h**\ [*hinge*]][**+i**\ *dz*][**+u**\|\ **U**\ *unit*][**+s**\ *fname*] ]
[ :option:`-D` ]
[ :option:`-I`\ *intensity* ]
[ :option:`-M` ]
[ :option:`-N`\ [**i**\|\ **o**][*divisor*] ]
[ :option:`-Q` ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *weights* ]
[ :option:`-f`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]


必选选项
------------------

*raster1* [ *raster2* [ *raster3*]]
    若仅给出一个输入且未设置 :option:`-C`，则 *raster1* 必须为图像。
    若给出两个输入，则 *raster1* 和 *raster2* 必须都是图像或网格。
    若给出三个输入，则它们必须都是网格，并且必须设置 :option:`-C`，
    除非这三个网格分别表示红、绿和蓝通道（范围为 0–255），
    此时可以省略 :option:`-C`。

.. option:: -G

**-G**\ *outfile*
    输出栅格的名称。对于图像，请使用以下扩展名之一：
    tif（GeoTIFF）、gif、png、jpg、bmp 或 ppm。
    对于网格，请参见 :doc:`网格格式 </grid/format>`。

可选选项
------------------

.. option:: -A

**-A**\ *alpha*\ [**+o**]
    获取一个常数 alpha（0–1），或一个网格（0–1 或 NaN），
    或图像（0–255，会被归一化为 0–1）。
    alpha 被视为透明度，因此 0 表示不透明像素，
    而 1（或 NaN）表示 100% 透明度 *t*。
    输出图像将基于这些值添加透明层。
    完全不透明的节点必须为零。
    如果你的常数或网格表示的是不透明度 (*o*) 而不是透明度，
    则添加修饰符 **+o**，我们会将 NaN 或 1 视为 100% 不透明，
    并且透明度 *t* = 1 - *o*。

.. _-C1:

**-C**
    从一个或三个归一化输入网格构建输出图像；
    这些网格的数值必须全部处于 0–1 范围内
    （如果不是，可使用 **-Ni**）。
    可选地，可使用 :option:`-A` 为颜色添加透明度，
    或使用 :option:`-I` 为颜色添加强度后再输出图像。
    对于三个输入层，输入顺序必须为红网格、绿网格、蓝网格。
    也可以只提供单个输入图像，再通过 :option:`-A` 或 :option:`-I` 增强。
    **注意**：要使用 CPT 查找表从单个输入网格生成图像，
    请参阅 :option:`-C` 的长格式说明。

.. _-C2:

.. include:: use_cpt_grd.rst_

.. option:: -D

**-D**
    将单个图像分解为一个或三个输出网格。
    如果图像包含 alpha（透明）层，将额外输出一个网格。
    所有输出网格的数值都保持原始图像的 0–255 范围；
    但可使用 **-No** 将其归一化至 0–1 范围。
    输出名称由 :option:`-G` 指定的名称模板生成，
    其中必须包含 C 格式字符串 “%c”。
    该代码将分别被替换为 R、G、B 和 A（对于彩色图像），
    或 g、A（对于灰度图像）。

.. option:: -I

**-I**\ *intensity*
    一个常数强度值或网格（范围 ±1），
    用于修改最终输出图像的颜色亮度。

.. option:: -M

**-M**
    强制将图像转换为单色图像，
    使用（电视制式）YIQ 颜色空间转换。

.. option:: -N

**-N**\ [**i**\|\ **o**][*divisor*]
    将所有输入网格从 0–255 归一化到 0–1，
    并将所有输出网格从 0–1 缩放回 0–255。
    若只希望对输入或输出单独启用归一化，
    分别使用 **-Ni** 或 **-No**。
    若需使用除 255 外的除数，请附加可选参数 *divisor*。

.. option:: -Q

**-Q**
    使最终图像变为不透明，
    即移除 alpha 层（如果存在）。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *weights*
    一个常数权重（0–1），或一个网格（0–1），或图像（0–255）作为权重。
    当给出两个输入栅格时，*weights* 应用于 *raster1*，
    而 *(1 - weights)* 应用于 *raster2*，
    然后将两者加权求和。

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

示例
--------

.. include:: explain_example.rst_

要使用一个计算得到的日夜分界权重图像混合地球的夜间与白天视图，可尝试::

    gmt grdmix @earth_day_06m @earth_night_06m -W@weight.png -Gnewmap.png

假设 map1.png 和 map2.png 是不同量的重叠地图，但我们希望使用图像 visible.png
将它们混合为一张图像：当 visible.png 的数值接近 255 时，
输出图像将主要显示 map1.png 的内容；
当数值接近 0 时，将主要显示 map2.png；
介于两者之间的值将导致加权平均。可执行::

    gmt grdmix map1.png map2.png -Wvisible.png -Gnewmap.png -V

若要将网格 transparency.grd 的数值插入图像 gravity.tif 作为 alpha（透明度）层，
并输出为带透明度的 PNG 图像，可执行::

    gmt grdmix gravity.tif -Atransparency.grd -Gmap.png

若要通过 CPT（relief.cpt）将网格 relief.nc 转换为 RGB jpg 图像 relief.jpg，可执行::

    gmt grdmix relief.nc -Crelief.cpt -Grelief.jpg

若要将彩色图像 layers.png 拆分为独立的、归一化后的红、绿、蓝网格（以及可能的 alpha 网格），执行::

    gmt grdmix layers.png -D -Glayer_%c.grd -No

若要将三个归一化网格 red.grd、green.grd 和 blue.grd 重新组合为 TIFF 图像，
同时从网格 intens.grd 应用强度并从网格 transp.grd 添加透明度，可执行::

    gmt grdmix red.grd green.grd and blue.grd -Glayer.tif -Atransp.grd -Iintens.grd


相关模块
--------

:doc:`gmt`, 
:doc:`grdblend`,
:doc:`grdclip`,
:doc:`grdcut`,
:doc:`grdinfo`,
:doc:`grdsample`
