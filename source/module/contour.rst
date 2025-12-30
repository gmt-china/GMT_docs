:author: 田冬冬, 陈箫翰, 朱邓达
:date: 2025-12-30

.. index:: ! contour
.. program:: contour

contour
==========

:官方文档: :doc:`gmt:contour`
:简介: 使用直接三角化法对数据进行等值线绘制

语法
--------

**gmt contour**
[ *table* ]
:option:`-J`\ *parameters*
[ :option:`-Jz|Z`\ *parameters* ]
:option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*]
[ :option:`-A`\ [**n**\|\ *contours*][*labelinfo*] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *contours* ]
[ :option:`-D`\ [*template*] ]
[ :option:`-E`\ *indexfile* ]
[ :option:`-G`\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params* ]
[ :option:`-I` ]
[ :option:`-L`\ *pen* ]
[ :option:`-N` ]
[ :option:`-Q`\ [*cut*][**+z**] ]
[ :option:`-S`\ [*p*\|\ *t*] ]
[ :option:`-T`\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]] ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-b`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-l`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
--------

.. include:: explain_-J.rst_

.. include:: explain_-Jz.rst_

.. include:: explain_-Rz.rst_

可选选项
------------------

.. option:: -A

**-A**\ [**n**\|\ *contours*][*labelinfo*]
    :option:`-A`\ *contours* 设置标注间隔，如果在 :option:`-C` 选项中指定标注间隔的话，
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

**-D**\ [*template*]

.. include:: explain_contdump.rst_

.. option:: -E

**-E**\ *indexfile*\ [**+b**]
    指定包含网络信息的文件名。每条记录必须包含一个三角形的三个节点编号 [默认使用 Delaunay 三角剖分计算这些信息（见 :doc:`triangulate`）]。
    如果 *indexfile* 是二进制文件，且其读取方式与二进制输入 *table* 相同，则可以附加 **+b** 以加快读取速度 [默认以 ASCII 格式读取节点]。

.. option:: -G

**-G**\ [**d**\|\ **f**\|\ **n**\|\ **l**\|\ **L**\|\ **x**\|\ **X**]\ *params*

.. warning::
    某些时候等值线图会出现标注数字消失不见的情况。这是由于数字被标注在绘图范围外所致。
    这种情况应该使用下面的 :option:`-G` 选项手动设置标注在等值线上的位置。

.. include:: explain_contlabel.rst_

    :option:`-G` 选项的用法示例可以参考 :doc:`/module/grdcontour` 模块的 :ref:`gmt-grdcontour-examples` 小节

.. option:: -I

**-I**
    使用 CPT 文件对三角形着色。

.. option:: -L

**-L**\ *pen*
    指定画笔属性绘制底层的三角形网格 [默认不绘制网格]。

.. option:: -N

**-N**
    对绘图边界外的图形不进行裁剪 [默认会进行裁剪]。

.. option:: -Q

**-Q**\ [*n*\|\ *length*\ [*unit*]][**+z**]
    不绘制点数少于 *n* 的等值线 [默认绘制所有等值线]。
    或者也可以指定最小等值线 *长度*（以距离单位表示，可用单位及距离计算方式见 :doc:`/basis/unit` ），
    包括 **c**（使用用户坐标的笛卡尔距离）或 **C**（坐标投影后当前绘图单位下的绘图长度单位）。附加 **+z** 以排除零等值线。

.. option:: -S

**-S**\ [**p**\|\ **t**]
    跳过所有落在区域外的输入 *x, y, z* 点 [默认使用三角剖分中的所有数据]。
    或者使用 **-St** 跳过三个顶点均在区域外的三角形。不带修饰符的 :option:`-S` 默认为 **-Sp**。

.. option:: -T

**-T**\ [**h**\|\ **l**][**+a**][**+d**\ *gap*\ [/*length*]][**+l**\ [*labels*]]

.. include:: explain_contticks.rst_

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*type*]\ *pen*\ [**+c**\ [**l**\|\ **f**]]
    设置等值线的线型。默认情况下，有标注的等值线线型 *pen* 为 ``0.75p,black`` ，
    无标注的等值线线型 *pen* 为 ``0.25p,black`` 。如果要设置有标注的等值线线型，*type* 应该设置为 **a** ，
    例如 ``-Wa1.75p,red`` 。无标注的等值线线型，*type* 应该设置为 **c** ，例如 ``-Wc1.25p,red`` 。
    如果加上 **+cl** ，则使用 :option:`-C` 选项所指定的CPT文件为不同的等值线设置颜色;
    如果使用 **+cf** ，则为标注设置颜色;
    使用 **+c** 则同时为等值线和标注设置颜色。

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-l.rst_

    通常，图例中默认选择带标注的等值线。通过将 *label* 设置为 [*annotcontlabel*][/*contlabel*] 格式，
    可以改选普通等值线或者同时选择两者。如果任一标签中包含斜杠 (/) 字符，则改用 | 作为这两个标签的分隔符。

.. include:: explain_-qi.rst_

.. include:: explain_colon.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-s.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
--------

使用 GMT 远程数据服务器上的数据文件 *@Table_5_11.txt* ，以25为间隔绘制等值线，以50为间隔标注：

.. gmtplot:: contour/contour_ex1.sh
    :width: 80%
    :show-code: true

只绘制并标注750和800两条等值线：

.. gmtplot:: contour/contour_ex2.sh
    :width: 80%
    :show-code: true

使用CPT文件temp.cpt定义的间隔绘制等值线

   ::

    gmt contour temp.xyz -R0/150/0/100 -Jx0.1i -Ctemp.cpt -W0.25p

相关模块
--------

:doc:`grdcontour`,
:doc:`grdimage`,
:doc:`nearneighbor`,
:doc:`basemap`,
:doc:`colorbar`,
:doc:`surface`,
:doc:`triangulate`