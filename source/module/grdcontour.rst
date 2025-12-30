:author: 田冬冬, 陈箫翰, 朱邓达
:date: 2025-08-25

.. index:: ! grdcontour
.. program:: grdcontour


**********
grdcontour
**********

:官方文档: :doc:`gmt:grdcontour`
:简介: 根据网格文件绘制等值线

语法
--------

.. include:: common_SYN_OPTs.rst_

**gmt grdcontour** *grid*
:option:`-J`\ *parameters* [ :option:`-A`\ [**n**\|\ *contours*][*labelinfo*] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *contours*\|\ *cpt* ]
[ :option:`-D`\ *template* ]
[ :option:`-F`\ [**l**\|\ **r**] ]
[ :option:`-G`\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params* ]
[ :option:`-L`\ *low/high*\|\ **n**\|\ **N**\|\ **P**\|\ **p** ]
[ :option:`-N`\ [*cpt*] ]
[ :option:`-Q`\ [*n*\|\ *length*\ [*unit*]][**+z**] ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*] ]
[ :option:`-S`\ *smoothfactor* ]
[ :option:`-T`\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ [**+o**\ *shift*][**+s**\ *factor*][**+p**] ]
[ :option:`-bo`\ *binary* ]
[ :option:`-do`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ **-ho**\ [*n*] ]
[ :option:`-l`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

描述
-----------

**grdcontour** 读取一个二维grid网格文件，并绘制等值线。或者将等值线的x、y、z位置保存到一个或多个输出文件（或标准输出），不绘制图像。

必选选项
------------------

*grid*
    二维grid网格文件

.. include:: explain_-J.rst_

可选选项
------------------

.. option:: -A

**-A**\ [**n**]\|\ [*contours*][*labelinfo*]
    **-A**\ *contours* 设置标注间隔，如果在 :option:`-C` 选项中指定标注间隔的话，
    这里的设置会被覆盖。**-An** 则为不进行标注。也可以用 ``-A20,80,100`` 类似的用法，对指定的
    等值线进行标注。如果只想要标注一条等值线，需要在末尾加上逗号，例如 ``-A20,`` ，这样 ``20`` 就不会被认为是标注间隔。
    *labelinfo* 代表可以在最后追加下列额外选项:

.. include:: explain_clabelinfo.rst_

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *contours*
    指定绘制等值线的形式，具体说明如下:

    (1) 如果 *contours* 是一个以 ".cpt" 结尾的文件名，GMT会查找对应的CPT文件，
        把CPT文件中的颜色块的边界绘制为等值线，并进行标注。如果使用了 ``-An`` 选项则只绘制等值线不标注。

    (2) 如果 *contours* 是一个不以 ".cpt" 结尾的文件名，GMT会读取其中的内容作为等值线设置。
        每行为一条等值线的设置，以如下格式给出：
        *contour-level* [*angle*] **C**\|\ **c**\|\ **A**\|\ **a** [*pen*]，中括号表示可选项。
        **C** 或 **c** 表示绘制等值线但不标注，而 **A** 或 **a** 表示绘制等值线并进行标注。
        *angle* 设置标注的旋转角。 *pen* 设置等值线的线型。

    (3) 如果 *contours* 是一串用逗号隔开的数字，例如 ``-C20,80,100`` ，则绘制对应的等值线。
        如果只想要绘制一条等值线，需要在末尾加上逗号，例如 ``-C20,`` 。

    (4) 如果没有指定 *contours* ，则默认使用当前CPT文件。

    (5) 如果 *contours* 是一个常数，则以这个常数为间隔绘制等值线。

    如果 :option:`-C` 和 :option:`-A` 都没有指定的话，则自动计算合适的间隔绘制标注等值线。

.. option:: -D

**-D**\ *template* 
    将等值线转存为线段文件，不绘制图像。后面可以加上C语言的 `printf <https://linux.die.net/man/3/printf>`_ 函数
    的格式说明符作为输出文件名模板。如果不指定文件名模板则全部打印到标准输出。如果文件名不含格式说明符则全部输出到
    单个文件。  

    + 如果有浮点数格式(e.g., %6.2f)，其被替换为等值线的z值。
    + 如果有整数格式(e.g., %06d)，其被替换为等值线的计数索引。
    + 如果有字符格式(%c)，其被替换为 C 或 O ，分别代表闭合等值线和开放等值线。
    
    这3个说明符可以任何顺序组合在一起，以定义输出的文件名。

    例如，只给定 %c 则输出两个文件，只给定 %f 则等值线的每一级输出为一个文件，给定 %d 则每条等值线输出到独立文件中。

.. option:: -F

**-F**\ [**l**\|\ **r**]
    使用 :option:`-D` 时，设置按顺序输出等值线的线段。 **-Fl** （默认值）表示沿着高z值在左侧的等值线方向， 
    **-Fr** 表示沿着高z值在右侧的等值线方向，不使用 **-F** 则为任意方向。

.. option:: -G

**-G**\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params*

.. warning::
    某些时候等值线图会出现标注数字消失不见的情况。这是由于数字被标注在绘图范围外所致。
    这种情况应该使用下面的 **-G** 选项手动设置标注在等值线上的位置。

.. include:: explain_contlabel.rst_

.. option:: -L

**-L**\ *low/high*\|\ **n**\|\ **N**\|\ **P**\|\ **p**
    不绘制小于 *low* 大于 *high* 的等值线。 也可以设置为 **-Ln** 只绘制负值，
    或 **-Lp** 只绘制正值。使用大写的 **-LN** 或 **-LP** 表示包括0等值线。

.. option:: -N

**-N**\ [*cpt*]
    指定 *cpt* 文件，对等值线之间的区域填充颜色。

.. option:: -Q

**-Q**\ [*n*\|\ *length*\ [*unit*]][**+z**]
    不绘制少于 *n* 个点的等值线（默认绘制所有等值线）。或者，以距离 *unit* 为单位给出最小等值线长度 *length* ，
    其中 *unit* 可使用地理距离单位 **d|m|s|e|f|k|M|n|u** ，
    也可使用 **c**\ （用户坐标的笛卡尔距离）和 **C**\ （坐标投影后的笛卡尔距离）。可加上 **+z** 以去除零等值线。


.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

.. option:: -S
    
**-S**\ *smoothfactor*
    在 *网格尺寸/smoothfactor* 间隔下重采样等值线。 

.. option:: -T

**-T**\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]]
    在最内层闭合等值线上每隔一段 *gap* 距离向着下降方向的刻度。
    用户可以加上 **h** 或 **l** 来选择分别只在极大值区域或极小值区域绘制。还支持以下选项：  

    + **+a** - 对所有闭合等值线绘制刻度，而不只是最内层。
    + **+d** - 后面加上 *gap*\ [/*length*] 来设置刻度间的距离 *gap* 以及刻度线长度 *length*
      （可加上单位 **c**\ ，\ **i**\ 或\ **p**），默认 15\ **p**\ /\ 3\ **p** 。
    + **+l** - 在极小值和极大值区域中的最内层闭合等值线中心进行标注。
      如果不设置 *label* 则使用 **-** 和 **+** 作为标注。如果正好为两个字符，例如 **+l**\ *LH* ，
      则极小值和极大值区域各取一个字符作为标注（ *L* 和 *H* ）。
      对于更复杂的标签，用逗号分隔字符串（例如，\ **+l**\ *lo,hi* ）。
      如果使用 :option:`-C` 给定了文件，且设置了 :option:`-T` ，则只有被标记为大写字母 C 或 A 
      的等值线才会有刻度和极大极小值标注。 **注意：** 极大极小值标注有时可能在最内层等值线的外面，
      因为仅使用了等值线坐标的平均值来确定标注坐标。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] :ref:`(more ...) <set-pens>`
    设置等值线的线型。默认情况下，有标注的等值线线型 *pen* 为 ``0.75p,black`` ，
    无标注的等值线线型 *pen* 为 ``0.25p,black`` 。如果要设置有标注的等值线线型，*type* 应该设置为 **a** ，
    例如 ``-Wa1.75p,red`` 。无标注的等值线线型，*type* 应该设置为 **c** ，例如 ``-Wc1.25p,red`` 。
    如果加上 **+cl** ，则使用 :option:`-C` 选项所指定的CPT文件为不同的等值线设置颜色;
    如果使用 **+cf** ，则为标注设置颜色;
    使用 **+c** 则同时为等值线和标注设置颜色。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ [**+o**\ *shift*][**+s**\ *factor*][**+p**]
    在计算等值线之前，从数据中减去 *shift* 再乘以 *factor* （默认-o0+s1）。
    在 :option:`-A`\ ，\ :option:`-C`\ 和\ :option:`-L`\ 中指定的值是缩放之后的。
    后面加上 **-p** 表明网格数据的z值是360度周期循环的（例如相位数据，角度分布），
    这要求零等值线必须特殊处理。

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-l.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

基础示例
----------

使用网格文件AK_gulf_grav.nc，以10为间隔绘制等值线，以20为间隔标注，标注文字大小10p。

.. gmtplot:: grdcontour/grdcontour-ex1.sh
    :width: 80%
    :show-code: true

只绘制20和60两条等值线，只标注40等值线。

.. gmtplot:: grdcontour/grdcontour-ex2.sh
    :width: 80%
    :show-code: true

以10为间隔绘制等值线，以50为间隔标注，设置图标题为"Gravity Anomalies"。
将有标注的等值线设置为粗红线，将无标注的等值线设置为蓝色的细短划线。

.. gmtplot:: grdcontour/grdcontour-ex3.sh
    :width: 80%
    :show-code: true

将负值等值线设置为蓝色，正值等值线设置为红色，0等值线设置为黑色。

.. gmtplot:: grdcontour/grdcontour-ex4.sh
    :width: 80%
    :show-code: true

分两个文件 *contours_C.txt* 和 *contours_O.txt* 保存闭合等值线和开放等值线::

    gmt grdcontour @AK_gulf_grav.nc -C150 -S4 -DAK_contours_%c.txt

.. _gmt-grdcontour-examples:

进阶示例
----------

第1个实例绘制等值线，并通过指定 **-Gd** 选项的参数，沿等值线每1.5英寸放置一个标注。

.. gmtplot:: grdcontour/grdcontour-annot1.sh
    :width: 80%
    :show-code: true

第2个实例通过指定 **-Gn** 选项的参数，指定每条等值线上标注的个数。每条等值线上只放置1个标注，并且要求等值线的长度不小于1英寸。

.. gmtplot:: grdcontour/grdcontour-annot2.sh
    :width: 80%
    :show-code: true

第3个实例通过指定 **-Gf** 选项的参数，给定标注所在位置的坐标。
由于坐标不是严格位于等值线上，因此需要在参数中指定标注位置与等值线距离的上限。标注的位置为等值线上与给定点距离最小的点。
模块会根据等值线的几何形状，自动计算标注的角度。

.. gmtplot:: grdcontour/grdcontour-annot3.sh
    :width: 80%
    :show-code: true

第4个实例通过指定 **-GL** 选项的参数来定义线段，将标注放置在大圆弧线段与等值线的交点。
图中的标注位于数据最值点连线(**Z-/Z+**)与等值线的交点。同一幅地图中，可以分别指定多条线段。

.. gmtplot:: grdcontour/grdcontour-annot4.sh
    :width: 80%
    :show-code: true

如果需要指定的与等值线相交的线段比较多，或线段数据来自其他数据集，可以使用广义的相交算法确定标注的位置。
通过指定 **-GX** 选项的参数(多段数据文件 *cross.txt* )，确定标注的位置。
多段数据文件 *cross.txt* 中定义了三条折线，模块在这三条折线与等值线交点位置处进行标注。

.. gmtplot:: grdcontour/grdcontour-annot5.sh
    :width: 80%
    :show-code: true
