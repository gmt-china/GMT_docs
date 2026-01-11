:author: 田冬冬, 朱邓达, 陈箫翰
:date: 2026-01-09

.. index:: ! plot3d
.. program:: plot3d

plot3d
===============

:官方文档: :doc:`gmt:plot3d`
:简介: 在3D视角图中绘制符号、线段或多边形

从文件或标准输入读取至少 (*x, y, z*) 三列数据，并在 3D 空间中绘制线条、多边形或符号。
如果选择了符号但未指定符号大小，则将第四列数据解释为符号大小。符号大小小于或等于 0 的数据将被跳过。
如果未指定符号，则输入数据的最后一列必须包含符号代码（参见下方 :option:`-S` 选项）。
如果未使用 :option:`-S` 选项，将绘制连接数据点的线条。要显式闭合多边形，请使用 :option:`-L` 选项。
使用 :option:`-G` 选择填充颜色。如果设置了 :option:`-G` ，:option:`-W` 将控制是否绘制多边形的边框。
如果选择了绘制符号，:option:`-G` 和 :option:`-W` 分别决定填充颜色和是否显示边框。

语法
--------

**gmt plot3d**
[ *table* ]
:option:`-J`\ *parameters*
:option:`-Jz|Z`\ *parameters*
:option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*]
[ :option:`-A`\ [**x**\|\ **y**] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ *dx*/*dy*\ [/*dz*] ]
[ :option:`-G`\ *fill*\|\ **+g**\|\ **+z** ]
[ :option:`-H`\ [*scale*] ]
[ :option:`-I`\ [*intens*] ]
[ :option:`-L`\ [**+b**\|\ **d**\|\ **D**][**+xl**\|\ **r**\|\ *x0*][**+yl**\|\ **r**\|\ *y0*][**+p**\ *pen*] ]
[ :option:`-N` ]
[ :option:`-Q` ]
[ :option:`-S`\ [*symbol*][*size*][/*size_y*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [*pen*][*attr*] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ *value*\|\ *file*\ [**+t**\|\ **T**] ]
[ :option:`-a`\ *flags* ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-l`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

.. include:: explain_intables.rst_

必须选项
------------------

.. include:: explain_-J.rst_

.. include:: explain_-Jz.rst_

.. include:: explain_-Rz.rst_

可选选项
------------------

.. include:: explain_line_draw.rst_

.. include:: explain_-B.rst_

.. include:: create_cpt.rst_
..

    本选项可以使符号和多边形的填充颜色、线段和多边形的线条颜色由 Z 值决定。

    #. 若绘制符号（即使用 :option:`-S` 选项），则符号的填充色由数据的第四列 Z 值决定，
       其他数据列依次后移一列。绘制多波段 3D 柱体时除外，每个波段的颜色均取自 CPT 中的各个切片。
    #. 若绘制线段或多边形（即未使用 :option:`-S` 选项），则需要在多段数据的数据段头记录中指定
       :option:`-Z`\ *val* (参见 :ref:`table-ascii-attrs` )。CPT文件中 *val* 所对应的颜色，
       即为线段或多边形的颜色。

.. option:: -D

**-D**\ *dx*/*dy*\ [/*dz*]
    将绘图符号或线的位置按指定的偏移量 *dx*/*dy*\ [/*dz*] 偏移 [默认无偏移]。
    可以为每个值附加尺寸单位，例如 **c** （厘米）、　**i** （英寸）或 **p** （点）。

.. option:: -G

**-G**\ *fill*\|\ **+g**\|\ **+z**
    设置符号或多边形的填充颜色或图案 [默认不填充]。
    本模块会在头段记录中搜索 :option:`-G` 和 :option:`-W` 选项，并覆盖对应选项的设置。
    如果头段记录中有 :option:`-Z`\ *val* 选项，使用 **-G+z** 通过 :option:`-C`\ *cpt* 和 *val* 值来分配填充颜色（如果通过 :option:`-Z` 设置了透明度，处理方式相同）。
    如果 *fill* = *auto*\ [*-segment*] 或 *auto-table*，将循环使用由 :term:`COLOR_SET` 定义的填充颜色，并按段或按表进行更改。任何 *transparency* 设置保持不变。

    使用 **+g** 启用多边形的基于顶点的颜色渐变（使用 Gouraud 着色）。会自动检测输入数据格式，并支持以下三种格式：

    1. **RGB 格式**：*x y z r g b*，其中 RGB 值的范围为 0-255。
    2. **颜色名称格式**：*x y z colorname*，其中 *colorname* 可以是颜色名字（如 "red"、"blue"）、十六进制颜色（如 "#FF0000"）、斜杠分隔的 RGB（如 "255/0/0"）、H-S-V 或 C/M/Y/K 格式。
    3. **CPT 格式**：*x y z value*，其中 *value* 值通过 :option:`-C` 指定的 CPT 映射为颜色。

    支持具有任意数量顶点的多边形，并使用从第一个顶点开始的扇形三角剖分自动进行三角化。
    每个顶点都有自己的颜色，Gouraud 着色会在多边形面上创建平滑的颜色渐变。使用 :option:`-W` 为渐变多边形添加轮廓。

.. option:: -H

**-H**\ [*scale*]
    从数据中读取 *scale* 列，对每一条记录的符号大小和画笔宽度进行缩放。
    *scale* 列为 *w* 和 *size* 列之后的第一个数据列。
    也可以指定一个固定的 *scale* 数值进行统一缩放。

.. option:: -I

**-I**\ *intens*
    使用提供的 *intens* 值（在 :math:`\pm 1` 范围内），通过模拟光照来调节填充颜色 [默认无光照]。
    如果未提供光照强度值，将从符号参数之后的第一个数据列中读取 *intens*。

.. option:: -L

**-L**\ [**+b**\|\ **d**\|\ **D**][**+xl**\|\ **r**\|\ *x0*][**+yb**\|\ **t**\|\ *y0*][**+p**\ *pen*]
    强制闭合多边形。或者附加以下选项从线段构建多边形：  

    - **+d** - 使用额外的第 3 列中提供的偏差值 **dy(x)**，围绕 **y(x)** 构建对称包络。  
    - **+D** - 使用额外的第 3-4 列中的偏差值 **dy1(x)** 和 **dy2(x)**，围绕 **y(x)** 构建非对称包络。  
    - **+b** - 使用额外的第 3-4 列中提供的边界值 **yl(x)** 和 **yh(x)**，围绕 **y(x)** 构建非对称包络。  
    - **+x** - 将首点和末点连接到锚点 **xmin** （附加 **l** ）、 **xmax** （附加 **r** ）或 **x0** （附加 **it** ）。  
    - **+y** - 将首点和末点连接到锚点 **ymin** （附加 **b** ）、 **ymax** （附加 **t** ）或 **y0** （附加 **it** ）。  

    这些多边形可以通过 :option:`-G` 着色，并可通过添加修饰符 **+ppen** 来描边 [默认无描边]。  

    **注意：** 如果数据段头使用了 :option:`-Z` 选项，则需要使用 :option:`-L` 以确保数据被解释为多边形，否则它们将被视为线段。

.. option:: -N

**-N**\ [**c**\|\ **r**]
    不要裁剪落在地图边界外的符号 [默认仅绘制坐标严格位于地图边界内的点]。
    对于周期性（360 度经度）的地图，若符号出现在重复边界上，则会被重复绘制两次，以防它们被重复的边界裁剪。  

    - 使用 **-N** 可关闭裁剪，并且不绘制重复的符号。  
    - 使用 **-Nr** 可关闭裁剪，同时保留重复符号的绘制。  
    - 使用 **-Nc** 可保留裁剪，但关闭重复符号的绘制。

    本选项也可以用于线或多边形，但请注意，这会导致不再考虑周期性（例如经度），并可能产生意想不到的后果。

.. option:: -Q

**-Q**
    关闭基于与观察者距离的自动排序。默认情况下，会对项目进行排序，使前景中的项目在背景中的项目之后绘制。

.. option:: -S

**-S**\ [*symbol*][*size*]
    本命令可以绘制所有 :doc:`plot` 命令支持的二维符号，但注意在视觉效果上仅仅是从三维视角观察平面符号。
    例如只能绘制出三维视角观察的平面圆点，而无法绘制一个三维球体。

    此外还支持以下真正的三维符号绘制:

    .. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_base_symbols3D.png
        :width: 600 px
        :align: center

        立方体和柱体符号都是 3D 的，其颜色可以根据视角进行调节（小写 **u** 和 **o**），也可以为统一颜色（大写 **U** 和 **O**）。柱体还可以通过 **+v|i** 修饰符表示多波段符号。

    **-So**\ *size*\ [**c**\|\ **i**\|\ **p**\|\ **q**][**+b**\ \|\ **B**\ [*base*]][**+v**\|\ **i**\ *nz*]
        柱体（3D）从基底延伸到 z 坐标。 *size* 设置基底宽度（如果 **xsize** 和 **ysize** 不相同，则分别使用它们）。
        可以用 **xsize** 和 **ysize** 作为两个额外的数据列。默认情况下，基底 *base* 为 0。附加 **+b**\ *base* 来更改此值。
        如果未附加 *base* ，则从最后一列输入数据中读取该值。如果柱体的高度是相对于基底来测量的，请使用 **+B**\ [*base*] [相对于原点]。
        为了模拟阴影，面颜色将会修改。使用 **-SO** 来禁用 3D 照明。
        通常情况下，只有一个 z 值会被考虑。对于多段柱体，可以附加 **+v**\ *nz* （并输入相对于基底的 **nz** 个完整的 z 值），
        或者附加 **+i**\ *nz* （并提供 **nz** 个增量 **dz** ，这些增量的总和为实际的 z 值）。
        多段柱体修饰符需要 :option:`-C`，其 z 值必须等于波段号（0, 1, …, nz-1），以分配段颜色。
        因此，输入记录可以是 **(x y z1 z2 … zn)** 或 **(x y dz1 dz2 … dzn)**。
        
    **-Su**\ *size*\ [**c**\|\ **i**\|\ **p**\|\ **q**]
        绘制三维立方体。*size* 参数设定所有边的长度。如果 *size* 是以 x 单位表示的数量，则在后面添加 **q** [默认使用绘图距离单位]。
        立方体各个面的颜色会被调整以模拟阴影效果。使用 **-SU** 可以禁用三维光照效果。
    
    **-SP**\ *size*\ [**c**\|\ **i**\|\ **p**][**+a**\ *azimuth*][**+e**\ *elevation*][**+f**][**+n**]
        直径为 *size* 的三维球体 [默认单位为 **c** (cm)]。球体通过径向渐变进行渲染，颜色从光源处的白色过渡到另一侧的填充色，从而产生三维视觉效果。
        可附加以下选项：

        * **+a**\ *azimuth* - 设置光源方位角 [默认值：0，从右侧照射]。
        * **+e**\ *elevation* - 设置光源仰角 [默认值：90，垂直于观察平面]。
        * **+f** - 使用扁平/恒定填充色（无渐变着色）。
        * **+n** - 仅绘制轮廓（无填充）。

        轮廓画笔属性由 :option:`-W` 控制。如果未通过 :option:`-G` 指定填充色，球体默认为灰色。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*pen*][*attr*] 
    设置线条或符号轮廓的画笔属性 [默认值： *width* (宽度) = 0.25p， *color* (颜色) = 黑色， *style* (样式) = 实线]。可以使用以下修饰符来改变线条的外观：

    * **+c** ：将从 cpt 文件查找的颜色应用到符号或填充。添加 **l** 表示线条颜色将从 CPT 获取(参见 :option:`-C`)。
      如果添加 **f**，则 cpt 文件中的颜色将应用于符号填充。如果未给出参数，则颜色同时用于画笔和填充。
    * **+o** ：添加 *offset*\ [*unit*]，将在距离端点给定 *offset* 距离处开始和停止绘制线条。
      添加 **c** | **i** | **p** 中的一个 *unit* 表示地图上的绘图距离偏移，或者添加地图距离单位[默认是笛卡尔距离]。
      如果线条的起点和终点需要不同的偏移量，请将 *offset* 写作 *b_offset*/*e_offset* 的形式。
    * **+s** ：使用贝塞尔样条绘制线条[默认是线性样条]。
    * **+v** ：给定 [**b**\|\ **e**]\ *vspecs*，在线条端点添加矢量箭头。在前面添加 **b** (起点)或 **e** (终点)可以仅在一端添加矢量[默认对线条两端都添加]。
      **注意**：由于 **+v** 可能需要额外的修饰符，因此它必须放在画笔规格的最后。更多关于此类修饰符的信息，请参见矢量属性。
    * **+z** ：如果设置了 :option:`-Z`，则通过 :option:`-C`\ *cpt* 和获得的 *value* 值分配画笔颜色(如果通过 :option:`-Z` 设置透明度也是如此)。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ *value*\|\ *file*\ [**+t**\|\ **T**]
    控制线条和多边形的颜色或透明度。本选项需要使用 :option:`-C` 指定cpt，然后选择以下两种模式之一：

    1. 添加一个 *value*，颜色通过 CPT 查找。
    2. 提供一个文件 *file* 的名称，该文件为输入数据中的每个多边形或线条提供一个 *value* 值(从最后一列读取)。

    控制颜色需要和 :option:`-G` 或 :option:`-W` 一起使用：

    * **-G+z** ：控制多边形填充颜色
    * **-W+z** ：控制线条颜色

    以下两个附加参数可用于处理透明度和/或颜色：

    * **+t** ：改为控制多边形或线条的透明度。 *value* 值将被假定为 :math:`0\text{-}100\%` 范围内的透明度。
    * **+T** ：通过 *file* 提供两列数据：最后一列必须是 *value* 值，而倒数第二列为透明度（范围为 :math:`0\text{-}100\%`）。

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_
..

    如果使用了 :option:`-S` 选项则本选项无效。

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-l.rst_

.. include:: explain_-qi.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: auto_legend_info.rst_

示例
--------

在三维空间(0-10)、(0-10)、(0-100)的投影上，按照 heights.xyz 文件中列出的位置绘制蓝色柱状图(宽度 = 1.25 厘米)，
刻度间隔分别为 2、2、10，从东南方向以 30 度仰角进行观察::

    gmt plot3d heights.xyz -R0/10/0/10/0/100 -Jx1.25c -Jz0.125c -So1.25c \
              -Gblue -Bx2+lXLABEL -By2+lYLABEL -Bz10+lZLABEL -B+t"3-D PLOT" -p135/30 \
              -U+c -W -pdf heights

根据 *level* 值 65，使用 *t.cpt* 文件指定的颜色和轮廓来绘制一个点::

    echo 175 30 0 | gmt plot3d -R150/200/20/50 -JM15c -B -Sc0.5c -Z65 -G+z -Ct.cpt -pdf map

社区绘图示例
--------------

:doc:`/examples/ex029/index`, :doc:`/examples/ex030/index`

官方绘图示例
--------------

https://docs.generic-mapping-tools.org/latest/gallery/ex10.html ::

		#!/usr/bin/env bash
		#		GMT EXAMPLE 10
		#
		# Purpose:	Make 3-D bar graph on top of perspective map
		# GMT modules:	coast, text, plot3d, legend, makecpt, math
		#
		gmt begin ex10
			gmt coast -Rd -JQ0/37.5/20c -Sazure2 -Gwheat -Wfaint -A5000 -p200/40
			gmt makecpt -Cpurple,blue,darkgreen,yellow,red -T0,1,2,3,4,5
			gmt math -T @languages_10.txt -o0:2 -C2 3 COL ADD 4 COL ADD 5 COL ADD 6 COL ADD = \
				| gmt text -p -Gwhite@30 -D-0.6c/0 -F+f30p,Helvetica-Bold,firebrick=thinner+jRM+z
			gmt plot3d @languages_10.txt -R-180/180/-90/90/0/2500 -JZ6c -So0.75c+Z5 -C -Wthinner \
				--FONT_TITLE=30p,Times-Bold --MAP_TITLE_OFFSET=-2c -p --FORMAT_GEO_MAP=dddF \
				-B -Bza500+lLanguages -BWSneZ+t"World Languages By Continent"
			gmt legend -JZ -DjLB+o0.5c+w3.5c/0+jBL --FONT=Helvetica-Bold \
				-F+glightgrey+pthinner+s-4p/-6p/grey20@40 -p @legend_10.txt
		gmt end show

.. figure:: https://docs.generic-mapping-tools.org/latest/_images/ex10.png
    :align: center
