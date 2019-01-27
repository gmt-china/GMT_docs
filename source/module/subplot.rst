.. index:: ! subplot

subplot
=======

:官方文档: :ref:`gmt:subplot`
:简介: 管理现代模式下子图的配置和选择

``subplot`` 模块可以将当前图片分割成若干个子图的矩阵，每个子图都可以包含一张单独的图片。
``subplot`` 模块有三种模式：

- ``gmt subplot begin`` 用于子图的布局
- ``gmt subplot set`` 用于指定当前绘图在哪一个子图中进行
- ``gmt subplot end`` 用于结束子图模式

``gmt begin``
--------------

语法
~~~~

::

    gmt subplot begin <nrows>x<ncols>
                      -F[f|s]<width>/<height>[:<wfracs>/<hfracs>]
                      [-A<autolabel>]
                      [-B<params>]
                      [-J<params>]
                      [-M<margins>]
                      [-R<params>]
                      [-S<layout>]
                      [-T<title>]

必须选项
~~~~~~~~

``<nrows>x<ncols>``
    指定子图的行数和列数。每一行拥有相同数目的子图。
    若需要实现每行有不同的子图数目，你需要多次叠加使用 subplot 模块。
    注意：你无需再每个子图内都绘图。

``-F[f|s]<widths>/<height>[:<wfracs>/<hfracs>]``
    指定图片的长宽。

    有两种方式：

    -   ``-Ff`` 指定整张图片的尺寸。每张子图的尺寸会根据整张图片的尺寸以及子图的数目自动计算。
        在计算子图尺寸时会考虑每个子图的刻度线、标记、标签所占据的空间，以及不同子图之间的空白。
        最外圈的刻度线、标记和标签不算在整张图片尺寸之内。为了给每行或每列指定不同的子图尺寸，
        可以在冒号后面加上一系列以逗号分隔的宽度比例，然后再加上一个斜杠，并加上一系列以逗号
        分隔的高度比例。单个数则表示所有行或列有相同的宽度或高度。

        例如，``-Ff4i/4i:3,1/1,2``会使得第一列的宽度是第二列的三倍，而第二行的高度则
        是第一行的两倍。默认是所有行以及列的尺度是相同的。

    -   ``-Fs`` 直接指定每个子图的尺寸。此时，整张图的尺寸由子图的尺寸以及刻度线、标记、标签和
        子图之间的空白共同决定，其中，最外圈的刻度线、标记、标签不算在整张图的尺寸之内。
        为了给每行或每列指定不同的子图尺寸，可以加上一系列以逗号分隔的宽度，
        然后再加上一个斜杠，并加上一系列以逗号分隔的高度。单个数则表示所有行或列有相同的宽度或高度。

        例如，``-Fs2i,3i/3i`` 使得第一列为2英寸宽，第二列为3英寸宽，所有列的高度均为3英寸。
        值的数目必须是一个或者与行数/列数相匹配。对于地理地图而言，每张子图的高度由地图区域以及
        投影方式决定。有两个选择：(1) 同时指定 ``-R`` 和 ``-J`` ，并利用其计算每张子图的高度，
        所有的子图必须共享相同的研究区域和投影方式，且你必须指定一个0高度；（2）不同尝试并
        修改子图的高度以得到最佳的绘图布局。

可选选项
~~~~~~~~

``-A<autolabel>``
    为每个子图指定自动的标签。 ``<autolabel>`` 可以是一个数字或字母，默认为 ``a``\ 。

    该选项设置了左上角第一张子图的标签，并按照顺序自动设置其他子图的标签。也可以在数字或字母的一侧
    或两侧加上括号（需要注意，UNIX下可能需要对括号进行转义）。

    Use **+j**\ \|\ **J**\ *refpoint* to specify where the tag should be placed in the subplot [TL].
    Note: **+j** sets the justification of the tag to *refpoint* (suitable for interior tags)
    while **+J** instead selects the mirror opposite (suitable for exterior tags).
    Append **+c**\ *dx*\ [/*dy*] to set the clearance between the tag and a surrounding text box
    requested via **+g** or **p** [3pt/3pt, i.e., 15% of the :ref:`FONT_TAG size <FONT_TAG>` size].
    Append **+g**\ *fill* to paint the tag's text box with *fill* [no painting].
    Append **+o**\ *dx*\ [/*dy*] to offset the tag's reference point in the direction implied
    by the justification [4pt/4pt, i.e., 20% of the :ref:`FONT_TAG size <FONT_TAG>`].
    Append **+p**\ *pen* to draw the outline of the tag's text box using selected *pen* [no outline].
    Append **+r** to typeset your tag numbers using lowercase Roman numerals;
    use **+R** for uppercase Roman numerals [Arabic numerals].
    Append **+v** to increase tag numbers vertically down columns [horizontally across rows].

.. _subplot_set-C1:

**-C**\ *side*\ /*clearance*\ [**u**\ ]
    Reserve a space of dimension *clearance* between the margin and the subplot on the specified
    side, using *side* values from **w**, **e**, **s**, or **n**.  The option is repeatable to set aside space
    on more than one side.  Such space will be left untouched by the main map plotting but can
    be accessed by modules that plot scales, bars, text, etc.  Settings specified under **begin** mode apply to all panels.

.. _-J:

.. |Add_-J| unicode:: 0x20 .. just an invisible code
.. include:: explain_-J.rst_

.. _subplot_begin-M:

**-M**\ *margins*
    This is clearance that is added around each subplot beyond the automatic space allocated for tick marks,
    annotations, and labels.  The margins can be a single value, a pair of values separated by slashes
    (for setting separate horizontal and vertical margins), or the full set of four margins (for setting
    separate left, right, bottom, and top margins) [0.5c].

.. _-R:

.. |Add_-R| unicode:: 0x20 .. just an invisible code
.. include:: explain_-R.rst_

.. _subplot_begin-S:

**-S**\ *layout*
    Set subplot layout for shared axes. May be set separately for rows (**-SR**) and columns (**-SC**).
    **-SC**: Use when all subplots in a **C**\ olumn share a common *x*-range. The first (i.e., **t**\ op) and the last
    (i.e., **b**\ ottom) rows will have *x* annotations; append **t** or **b** to select only one of those two rows [both].
    Append **+l** if annotated *x*-axes should have a label [none]; optionally append the label if it is the same
    for the entire subplot.
    **-SR**: Use when all subplots in a **R**\ ow share a common *y*-range. The first (i.e., **l**\ eft) and the last
    (i.e., **r**\ ight) columns will have *y*-annotations; append **l** or **r** to select only one of those two columns [both].
    Append **+l** if annotated *y*-axes will have a label [none]; optionally, append the label if it is the same
    for the entire subplot.
    Append **+p** to make all annotations axis-parallel [horizontal]; if used you may have to set **-C** to secure
    extra space for long horizontal annotations.
    Append **+t** to make space for subplot titles for each row; use **+tc** for top row titles only [no subplot titles].
    Labels and titles that depends on which row or column are specified as usual via a panel's **-B** setting.

.. _subplot_begin-T:

**-T**\ *heading*
    While individual subplots can have titles (see **-S** or **-B**), the entire figure may also have a
    overarching *heading* [no heading]. Font is determined by setting :ref:`FONT_HEADING <FONT_HEADING>`.

.. _subplot_begin-V:

.. |Add_-V| unicode:: 0x20 .. just an invisible code
.. include:: explain_-V.rst_

.. include:: explain_help.rst_

Synopsis (set mode)
-------------------

**gmt subplot set** *row,col* [ **-A**\ *fixedlabel*] [ **-C**\ *side*\ /*clearance*\ [**u**\ ] ] [ |SYN_OPT-V| ]

Before you start plotting you must first select the active subplot panel.
Note: Any **-J** option passed when plotting subplots must not give the width or scale
since the dimensions of the map are completely determined by the subplot size and your region.
Specifying map width will result in an error.  For Cartesian plots: If you want the scale
to apply *equally* to both dimensions then you must specify **-Jx** [The default **-JX** will
fill the subplot using unequal scales].

Required Arguments
------------------

*row,col*
    Sets the current subplot until further notice.  As an alternative, you may bypass the **set** mode and
    instead supply the common option **-c**\ *row,col* to the first plot command you issue in that subplot.
    GMT maintains information about the current figure and subplot.

Optional Arguments
------------------

.. _subplot_set-A:

**-A**\ *fixedlabel*
    Overrides the automatic labeling with the given string.  No modifiers are allowed.
    Placement, justification, etc. are all inherited from how **-A** was specified by the
    initial **subplot begin** command.

.. _subplot_set-C2:

**-C**\ *side*\ /*clearance*\ [**u**\ ]
    Reserve a space of dimension *clearance* between the margin and the subplot on the specified
    side, using *side* values from **w**, **e**, **s**, or **n**.  The option is repeatable to set aside space
    on more than one side.  Such space will be left untouched by the main map plotting but can
    be accessed by modules that plot scales, bars, text, etc.  This setting overrides the common
    clearances set by **-C** during **subplot begin**.

.. _subplot_set-V:

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

Any number of plotting command can now take place and all output will be directed to the
selected subplot panel.  There are a few other rules that need to be followed:
(1) The subplot machinery expects the first plotting command in a new subplot window
to take care of plotting the base frame.  The particulars of this frame may have been
specified by the **-S** option in **subplot begin**.  In either case, should you need to set or override
frame and axis parameters then you must specify these **-B** options with this first plot
command.  (2) The subplot machinery automatically uses the **-X** and **-Y** options under
the hood so these options are not available while a subplot is active.

Synopsis (end mode)
-------------------

**gmt subplot end** [ |SYN_OPT-V| ]

This command finalizes the current subplot, including any placement of tags, and updates the
dimensions of the last plot to that of the entire subplot. This allows **-X** and **-Y** to
use *w* and *h* in setting the current point relative to the entire subplot.  We also reset
the current plot location to where it was prior to the subplot.

Optional Arguments
------------------

.. _subplot_end-V:

.. include:: explain_-V.rst_
.. include:: explain_help.rst_


Examples
--------

To make a minimalistic 2x2 basemap layout called panels.pdf, try

   ::

    gmt begin panels pdf
      gmt subplot begin 2x2 -Fs3i -M5p -A -SCb -SRl -Bwstr
        gmt psbasemap -R0/80/0/10 -c1,1
        gmt psbasemap -c1,2
        gmt psbasemap -c2,1
        gmt psbasemap -c2,2
      gmt subplot end
    gmt end
