.. index:: ! plot3d
.. include:: common_SYN_OPTs.rst_


******
plot3d
******

:官方文档: :doc:`gmt:plot3d`
:简介: 在3D视角图中绘制符号、线段或多边形


语法
--------

**gmt plot3d** [ *table* ] |-J|\ *parameters*
|-Jz|\ \|\ **Z**\ *parameters*
|SYN_OPT-Rz|
[ |-A|\ [**m**\|\ **p**\|\ **x**\|\ **y**\|\ **r**\|\ **t**] ]
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ *dx*/*dy*\ [/*dz*] ]
[ |-G|\ *fill*\|\ **+z** ]
[ |-L|\ [**+b**\|\ **d**\|\ **D**][**+xl**\|\ **r**\|\ *x0*][**+yl**\|\ **r**\|\ *y0*][**+p**\ *pen*] ]
[ |-N| ]
[ |-Q| ]
[ |-S|\ [*symbol*][*size*][/*size_y*] ]
[ |-W|\ [*pen*][*attr*] ]
[ |-Z|\ *value*\|\ *file*]\ [**+t**\|\ **T**] ]

描述
-----------

从文件或标准输入读取至少 (*x, y, z*) 三列数据，并在 3D 空间中绘制线条、多边形或符号。
如果选择了符号但未指定符号大小，则将第四列数据解释为符号大小。符号大小小于或等于 0 的数据将被跳过。
如果未指定符号，则输入数据的最后一列必须包含符号代码（参见下方 |-S| 选项）。
如果未使用 |-S| 选项，将绘制连接数据点的线条。要显式闭合多边形，请使用 |-L| 选项。
使用 |-G| 选择填充颜色。如果设置了 |-G| ，|-W| 将控制是否绘制多边形的边框。
如果选择了绘制符号，|-G| 和 |-W| 分别决定填充颜色和是否显示边框。

必须选项
------------------

*table*
    输入数据文件文件名。

.. include:: explain_-J.rst_

.. _-Jz:

**-Jz**\|\ **Z**\ *parameters*
    设置Z轴的缩放比例，设置方式与 -Jx|X 相同。

可选选项
------------------

.. _-A:

**-A**\ [**m**\|\ **p**\|\ **x**\|\ **y**\|\ **r**\|\ **t**]

    默认情况下，地理线段以大圆弧的形式绘制。使用 **-A** 将以直线绘制。
    对于笛卡尔坐标数据，点将直接进行连接。附加选项：  

    - **m** - 按照先经线后纬线的顺序绘制线条。  
    - **p** - 按照先纬线后经线的顺序绘制线条。  
    - **r** - 对于极地投影，绘制阶梯曲线，第一步沿径向 (r) 移动。  
    - **t** - 同样为阶梯曲线，但第一步沿角度 (theta) 移动。  
    - **x** - 对于笛卡尔数据，绘制阶梯曲线，第一步沿 x 方向移动。  
    - **y** - 同样为阶梯曲线，但第一步沿 y 方向移动。  

    注意：在 **plot3d** 中，**-A** 选项要求 z 坐标为常数。

.. _-C:

**-C**\ *cpt*
    提供一个 CPT 文件或使用 **-C**\ *color1,color2*\ [*,color3*\ ,...] 来自动从这些颜色生成线性连续的 CPT。
    如果使用了 **-S**，符号的填充颜色将由第四列的值决定。其他字段依次向后移动一列（符号大小将位于第 5 列而不是第 4 列，以此类推）。  
    如果未使用 **-S**，则需要提供一个多段数据文件，其中每个段的头部包含 **-Z**\ *value*，该值通过 CPT 控制线条或多边形（如果设置了 **-L**）的颜色。 
    
    另外，可以参阅 -Z 选项了解如何分配 z 值。

.. _-D:

**-D**\ *dx*/*dy*\ [/*dz*]
    将绘图符号或线的位置按指定的偏移量 *dx*/*dy*\ [/*dz*] 偏移 [默认无偏移]。
    可以为每个值附加尺寸单位，例如 **c**（厘米）、**i**（英寸）或 **p**（点）。

.. _-G:

**-G**\ *fill* 
    选择符号或多边形的填充颜色或图案 [默认无填充]。
    请注意，本命令会首先在输入数据文件的所有段头中搜索 **-G** 和 **-W** 字符串，任何找到的值都会覆盖本设置。  
    如果设置了 **-Z**，可以使用 **-G+z** 通过 **-Ccpt** 和获取的 z 值指定填充颜色。  

.. _-L:

**-L**\ [**+b**\|\ **d**\|\ **D**][**+xl**\|\ **r**\|\ *x0*][**+yb**\|\ **t**\|\ *y0*][**+p**\ *pen*]
    强制闭合多边形。或者附加以下选项从线段构建多边形：  

    - **+d** - 使用额外的第 3 列中提供的偏差值 **dy(x)**，围绕 **y(x)** 构建对称包络。  
    - **+D** - 使用额外的第 3-4 列中的偏差值 **dy1(x)** 和 **dy2(x)**，围绕 **y(x)** 构建非对称包络。  
    - **+b** - 使用额外的第 3-4 列中提供的边界值 **yl(x)** 和 **yh(x)**，围绕 **y(x)** 构建非对称包络。  
    - **+x** - 将首点和末点连接到锚点 **xmin**（附加 **l**）、**xmax**（附加 **r**）或 **x0**（附加 **it**）。  
    - **+y** - 将首点和末点连接到锚点 **ymin**（附加 **b**）、**ymax**（附加 **t**）或 **y0**（附加 **it**）。  

    这些多边形可以通过 **-G** 着色，并可通过添加修饰符 **+ppen** 来描边 [默认无描边]。  

    **注意：** 如果数据段头使用了 **-Z** 选项，则需要使用 **-L** 以确保数据被解释为多边形，否则它们将被视为线段。

.. _-N:

**-N**\ [**c**\|\ **r**]
    不要裁剪落在地图边界外的符号 [默认仅绘制坐标严格位于地图边界内的点]。
    对于周期性（360 度经度）的地图，可能需要将所有符号绘制两次，以防它们被重复的边界裁剪。  

    - 使用 **-N** 可关闭裁剪，并且不绘制重复的符号。  
    - 使用 **-Nr** 可关闭裁剪，同时保留重复符号的绘制。  
    - 使用 **-Nc** 可保留裁剪，但关闭重复符号的绘制。  

.. _-Q:

**-Q**
    关闭基于与观察者距离的自动排序。默认情况下，会对项目进行排序，使前景中的项目在背景中的项目之后绘制。

.. _-S:

**-S**\ [*symbol*][*size*]
    本命令可以绘制所有 *plot* 命令支持的二维符号，但注意在视觉效果上仅仅是从三维视角观察平面符号。
    例如只能绘制出三维视角观察的平面圆点，而无法绘制一个三维球体。

    此外还支持以下真正的三维符号绘制:

    .. figure:: https://docs.generic-mapping-tools.org/latest/_images/GMT_base_symbols3D.*
        :width: 600 px
        :align: center

        立方体和柱体符号都是 3D 的，其颜色可以根据视角进行调节（小写 **u** 和 **o**），
        也可以为统一颜色（大写 **U** 和 **O**）。柱体还可以通过 **+v|i** 修饰符表示多波段符号。

    **-So**\ *size*\ [**c**\|\ **i**\|\ **p**\|\ **q**][**+b**\ \|\ **B**\ [*base*]][**+v**\|\ **i**\ *nz*]
        柱体（3D）从基底延伸到 z 坐标。 *size* 设置基底宽度（如果 **xsize** 和 **ysize** 不相同，则分别使用它们）。
        可以用 **xsize** 和 **ysize** 作为两个额外的数据列。默认情况下，基底 *base* 为 0。附加 **+b**\ *base* 来更改此值。
        如果未附加 *base* ，则从最后一列输入数据中读取该值。如果柱体的高度是相对于基底来测量的，请使用 **+B**\ [*base*] [相对于原点]。
        为了模拟阴影，面颜色将会修改。使用 **-SO** 来禁用 3D 照明。
        通常情况下，只有一个 z 值会被考虑。对于多段柱体，可以附加 **+v**\ *nz*（并输入相对于基底的 **nz** 个完整的 z 值），
        或者附加 **+i**\ *nz*（并提供 **nz** 个增量 **dz**，这些增量的总和为实际的 z 值）。
        多段柱体修饰符需要 **-C**，其 z 值必须等于波段号（0, 1, …, nz-1），以分配段颜色。
        因此，输入记录可以是 **(x y z1 z2 … zn)** 或 **(x y dz1 dz2 … dzn)**。
        
    **-Su**\ *size*\ [**c**\|\ **i**\|\ **p**\|\ **q**]
        c\ **u**\ be (3-D).  The *size* sets length of all sides. Append
        **q** if *size* is a quantity in x-units [Default is plot-distance units].
        The facet colors will be modified to simulate shading.
        Use **-SU** to disable 3-D illumination.

.. |Add_-U| replace:: |Add_-U_links|
.. include:: explain_-U.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. |Add_-V| replace:: |Add_-V_links|
.. include:: explain_-V.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. _-W:

**-W**\ [*pen*][*attr*] :ref:`(more ...) <-Wpen_attrib>`
    Set pen attributes for lines or the outline of symbols [Defaults:
    *width* = 0.25p, *color* = black, *style* = solid]. Modifiers can be used to change the
    appearance of the line:

    - **+c** - Determine how the color from the cpt file lookup is applied to symbol 
      and|or fill.  Append **l** to have the color of the line to be taken from the CPT (see
      |-C|). If instead **f** is appended then the color from the cpt file is applied
      to symbol fill.  If no argument is given the we use the color for both pen and fill.
    - **+o** - Append *offset*\ [*unit*] and we will start and stop drawing the line at the
      given distance *offset* from the end point. Append a *unit* from **c**\|\ **i**\|\ **p** to
      indicate plot distance offsets on the map or append map distance units instead (see Units below)
      [Cartesian distances]. Give *offset* as *b_offset*/*e_offset* if the beginning and end of the
      line should have different offsets.
    - **+s** - Draw the line using a Bezier spline [linear spline].
    - **+v** - Given [**b**\|\ **e**]\ *vspecs*, we place a vector head at the ends of the lines. Prepend
      **b** (beginning) or **e** (end) to add a vector at only one end [Default is shared specs for both end of the line].
      **Note**: Because **+v** may take additional modifiers it must necessarily be given
      at the end of the pen specification. See the `Vector Attributes`_ for more information or such modifiers.
    - **+z** - If |-Z| is set, assign pen color via **-C**\ *cpt* and the *z*-values obtained
      (same if transparency is set via |-Z|).  Finally, if pen *color* = *auto*\ [*-segment*] or *auto-table* then
      we will cycle through the pen colors implied by :term:`COLOR_SET` and change on a per-segment
      or per-table basis.  The *width*, *style*, or *transparency* settings are unchanged.

.. |Add_-XY| replace:: |Add_-XY_links|
.. include:: explain_-XY.rst_
    :start-after: **Syntax**
    :end-before: **Description**

.. _-Z:

**-Z**\ *value*\|\ *file*\ [**+t**\|\ **T**]
    Control the color and|or transparency of line and polygons.
    Instead of specifying a line or polygon fill and outline color via |-G| and |-W|,
    pass a color lookup table via |-C|. Then, select one of two modes:

    1. Append a *value* and the color is looked-up via the CPT.
    2. Give the name of a *file* with one z-value (read from the last column) for each polygon
       or line in the input data.

    To apply the color we must use the |-G| or |-W| options in conjunction with |-Z|:

    - **-G+z** - Apply the color to the polygon fill.
    - **-W+z** - Apply the color to the pen instead.

    Two modifiers is used to also handle transparency and|or color:

    - **+t** - Modulate the transparency of the polygon or line instead; the
      *z*-value will be assumed to be transparency in the 0-100 % range.
    - **+T** - Supply two columns via *file*: The last column must be the *z*-value
      while the penultimate column must have transparencies (in 0-100 % range).

.. include:: explain_-aspatial.rst_

.. |Add_-bi| replace:: [Default is the required number of columns given the chosen settings].
.. include:: explain_-bi.rst_

.. |Add_-di| unicode:: 0x20 .. just an invisible code
.. include:: explain_-di.rst_

.. |Add_-e| unicode:: 0x20 .. just an invisible code
.. include:: explain_-e.rst_

.. |Add_-f| unicode:: 0x20 .. just an invisible code
.. include:: explain_-f.rst_

.. |Add_-g| replace:: The **-g** option is ignored if |-S| is set.
.. include:: explain_-g.rst_

.. |Add_-h| unicode:: 0x20 .. just an invisible code
.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. |Add_-l| unicode:: 0x20 .. just an invisible code
.. include:: explain_-l.rst_

.. |Add_perspective| unicode:: 0x20 .. just an invisible code
.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-tv_full.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_vectors.rst_

.. module_common_ends

.. include:: auto_legend_info.rst_

Examples
--------

.. include:: explain_example.rst_

.. include:: oneliner_info.rst_

To plot blue columns (width = 1.25 cm) at the positions listed in the
file heights.xyz on a 3-D projection of the space (0-10), (0-10),
(0-100), with tickmarks every 2, 2, and 10, viewing it from the
southeast at 30 degree elevation::

    gmt plot3d heights.xyz -R0/10/0/10/0/100 -Jx1.25c -Jz0.125c -So1.25c \
              -Gblue -Bx2+lXLABEL -By2+lYLABEL -Bz10+lZLABEL -B+t"3-D PLOT" -p135/30 \
              -U+c -W -pdf heights

To plot a point with color and outline dictated by the *t.cpt* file for the *level*-value 65::

    echo 175 30 0 | gmt plot3d -R150/200/20/50 -JM15c -B -Sc0.5c -Z65 -G+z -Ct.cpt -pdf map

.. include:: plot3d_notes.rst_

See Also
--------

:doc:`gmt`, :doc:`gmt.conf`,
:doc:`gmtcolors`,
:doc:`basemap`, :doc:`plot`