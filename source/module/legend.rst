.. index:: ! legend
.. include:: common_SYN_OPTs.rst_

legend
======

:官方文档: :doc:`gmt:legend`
:简介: 在图上添加图例

**legend** 模块用于绘制图例，图例由图例文件控制。如无特别说明，
标注的字体由 :term:`FONT_ANNOT_PRIMARY` 控制。
若图例中含有中文，必须将 :term:`FONT_ANNOT_PRIMARY` 设置为中文字体。

语法
----

**gmt legend** [ *specfile* ]
|-D|\ *refpoint*
[ |SYN_OPT-B| ]
[ |-C|\ *dx*/*dy* ]
[ |-F|\ *box* ]
[ |-J|\ *parameters* ]
[ |SYN_OPT-R| ]
[ |-S|\ *scale* ]
[ |-T|\ *file* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必须选项
--------

.. _-D:

**-D**\ [**g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ **+w**\ *width*\ [/*height*]\ [**+j**\ *justify*]\ [**+l**\ *spacing*]\ [**+o**\ *dx*\ [/*dy*]]
    指定图例框的尺寸和位置

    简单介绍各子选项的含义，详情见 :doc:`/basis/embellishment`

    - **g**\|\ **j**\|\ **J**\|\ **n**\|\ **x**]\ *refpoint*\ 指定地图上的参考点

      .. include:: explain_refpoint.rst_

    - **+j**\ *justify* 指定图例框的锚点（默认锚点在左下角(BL)）
    - **+o**\ *dx*/*dy* 在参考点的基础上设置图例框的额外偏移量
    - **+w**\ *width*\ [/*height*] 指定图例框的尺寸。若 *height* 为0或未指定，
      则根据图例内容自动估算图例框高度。
    - **+l**\ *spacing* 设置图例里的行间距 [默认值1.1，即当前字体大小的1.1倍]

    该选项几个比较有用的用法是：

    - 将图例放在左下角： **-DjBL+w4c+o0.2c/0.2c**
    - 将图例放在左上角： **-DjTL+w4c+o0.2c/0.2c**
    - 将图例放在右下角： **-DjBR+w4c+o0.2c/0.2c**
    - 将图例放在右上角： **-DjTR+w4c+o0.2c/0.2c**


可选选项
--------

.. include:: explain_-B.rst_

.. _-C:

**-C**\ *dx*/*dy*
    设置图例边框与内部图例之间的空白 [默认值 4p/4p]

.. _-F:

**-F**\ [**+c**\ *clearances*][**+g**\ *fill*][**+i**\ [[*gap*/]\ *pen*]][**+p**\ [*pen*]][**+r**\ [*radius*]][**+s**\ [[*dx*/*dy*/][*shade*]]]
    控制图例的背景面板属性

    若只使用 |-F| 而不使用其它子选项，则绘制图例框。
    下面简单介绍各子选项，详细用法见 :doc:`/basis/embellishment`

    .. include:: explain_-F_box.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *scale*
    对图例中的所有符号大小乘以 *scale* [默认值为 1]

.. _-T:

**-T**\ *file*
    将隐藏的图例文件输出到文件中 [仅适用于现代模式]

    现代模式下，某些模块（如 :doc:`plot`）可以使用 **-l** 选项自动编辑一个隐藏的图例文件。
    在最终成图时，会根据这一图例文件绘制图例。
    该选项可将该隐藏图例文件的内容保存到新文件中，使得用户可以在自动图例文件的基础
    上做进一步自定义。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

图例文件格式
------------

图例文件用于控制图例中各项的布局。图例文件中的每个记录对应图例中的一项，图例中
每项的顺序由记录的先后顺序决定。每个记录的第一个字符决定了当前记录的图例类型。
GMT中共有14种图例类型，列举如下：

**#** *comment*
    以 # 开头的行或空行是注释行，会被跳过

**A** *cptname*
    指定CPT文件，使得某些记录可以通过指定Z值来设定颜色，可以多次使用该记录以
    指定不同的CPT文件

**B** *cptname offset height* [ *optional arguments* ]
    绘制水平colorbar

    - *offset* 是colorbar相对于图例框左边界的距离
    - *height* 是colorbar高度，其后可以加上子选项 [**+e**\ [**b**\|\ **f**][*length*]][**+h**][**+m**\ [**a**\|\ **c**\|\ **l**\|\ **u**]][**+n**\ [*txt*]]
    - *optional arguments* 为 :doc:`colorbar` 模块的其它选项，如 |-B| **-I** |-L| **-M** |-N| **-S** |-Z| **-p**

**C** *textcolor*
    接下来的文本所使用的颜色

    可以直接指定颜色，也可以用 z=\ *val* 指定Z值，以从CPT文件中查找相应的颜色
    （CPT文件由 **A** 记录指定）。
    若 *textcolor* 为 **-**，则使用默认颜色。

**D** [*offset*] *pen* [**-**\|\ **+**\|\ **=**]
    绘制一条水平线

    - *offset* 为线条左右顶端与图例边框的空白距离 [默认为0]
    - *pen* 为线条的画笔属性。若未指定 *pen*，则使用 :term:`MAP_GRID_PEN_PRIMARY`。
      若 *pen* 设置为 **-**，则绘制一条不可见的线（供 **V** 记录使用）
    - 默认情况下，线条上下各留出四分之一的行间距，**-**\|\ **+**\|\ **=**
      分别表示线条上方无空白、线条下方无空白和线条上下均无空白。

**F** *fill1 fill2 ... filln*
    指定单元的填充色。

    可以直接指定颜色，也可使用 z=\ *value* 形式指定从CPT文件（由 **A** 记录指定）中查找颜色。
    若只给定了一个 *fill*，则整行都使用相同的填充色，否则依次为当前行的
    每列应用不同的 *fill*\ （列数由 **N** 记录控制）。若 *fill* 为 **-**，则不填充。

**G** *gap*
    给定一个垂直空白

    空白的高度由 *gap* 决定，*gap* 可以用 **i**\|\ **c**\|\ **p** 单位，
    也可以用 **l**  作为单位表示几倍行距的空白，*gap* 也可以取负值，表示将当前行上移。

**H** *font*\|\ **-** *header*
    为图例指定一个居中的标题。

    *header* 为标题，*font* 为文字属性。若字体为 **-** 则使用默认字体 :term:`FONT_TITLE`。

**I** *imagefile width justification*
    将EPS或光栅文件放在图例中

    *width* 为图片宽度；\ *justification* 为图片的对齐方式。

**L** *font*\|\ **-** *justification label*
    在某一列增加指定的文字

    *label* 为显示的文本，*font* 为字体。若 *font* 为 **-** 则使用默认字体
    :term:`FONT_LABEL`。*justification* 为对齐方式，可以取
    **L**\|\ **C**\|\ **R**，分别表示左对齐、居中对齐和右对齐

**M** *slon*\|\ **-** *slat* *length*\ [**+f**][**+l**\ [*label*]][**+u**] [**-F**\ *param*] [ **-R**\ *w/e/s/n* **-J**\ *param* ]
    在图例中绘制比例尺。

    *slon* 和 *slat* 用于指定绘制哪一点的比例尺。*slon* 仅对特定的倾斜投影有效。
    对于一般投影，应设置为 **-**。

    *length* 为比例尺长度，其后可以接长度单位，以及多个子选项。子选项的具体含义见
    :doc:`basemap` 模块的 |-L| 选项。

    若想要为比例尺加上背景面板，则可以使用 :doc:`basemap` 的 |-F| 选项。
    此外，还可以加上 |-R| 和 |-J| 指定比例尺所使用的投影参数。

**N** [*ncolumns* or *relwidth1 relwidth2 ... relwidthn*]
    修改图例中的列数 [默认为1列]

    该记录仅对 **S** 和 **L** 记录有效。该记录指定的列数会一直有效直到再次
    使用 **N** 记录。
    *ncolumns* 用于指定若干个等宽的列，*relwidth1 relwidth2 ... relwidthn*
    用于指定每列所占的相对宽度，所有宽度的和应等于 |-D| 选项所设置的宽度相等。

**P** *paragraph-mode-header-for-pstext*
    在图例中添加文本段落，参考 :doc:`text` 命令中的段落模式

**S** [*dx1 symbol size fill pen* [ *dx2 text* ]]
    在图例中绘制符号

    - *dx1* 符号中心与左边框的距离。若为 **-** 则自动设置为最大的符号大小的一半。
      *dx1* 除了可以指定距离，还可以使用 **L**\|\ **C**\|\ **R** 表示符号在
      当前列的对齐方式
    - *symbol* 指定要绘制的符号类型，见 :doc:`plot` 命令的 |-S| 选项。*symbol* 为 **-** 表示绘制线段
    - *size* 符号大小
    - *fill* 符号的填充色。使用 **-** 表示不填充。*fill* 也可以用 z=\ *val* 的形式从CPT文件中根据Z值查找颜色
    - *pen* 符号的轮廓属性。使用 **-** 表示不绘制轮廓
    - *dx2* 是 *text* 与左边框的距离。使用 **-** 则自动设置为最大符号大小的1.5倍
    - *text* 是符号的文字说明，字体由 :term:`FONT_ANNOT_PRIMARY` 控制

    若只有 **S** 而不接其它任何信息，则直接跳至下一列。若 *symbol* 取 **f** **q** 或 **v**，
    可以在符号后加上更多的子选项，详情见 :doc:`plot` 模块 |-S| 选项。
    某些符号（例如矩形、椭圆等）需要指定多个 *size*，应将多个 *size* 用逗号
    分隔作为 *size* 即可。如果只给了一个 *size*，则其余 *size* 由GMT默认值决定。

**T** *paragraph-text*
    打印一段文本，字体由 :term:`FONT_ANNOT_PRIMARY` 控制

**V** [*offset*] *pen*
    在两列之间绘制垂直的线条

    *offset* 为线条上下两端与图例边框的空白距离 [默认为0]。

默认值
------

对于如下符号，若用户不显式指定属性，绘制图例时使用如下默认值：

- front符号 **f**：front 符号位于左侧，其大小为指定符号大小的30%
- 矢量符号 **v**：箭头大小为符号大小的30%
- 椭圆符号 **e|E**：主轴长度为符号大小，次轴长度是符号大小的65%，方位角为0
- 矩形符号 **r**：宽度为符号大小，高度为宽度的65%
- 旋转矩形符号 **j|J**：宽度为符号大小，高度为宽度的65%，旋转角度为30度
- 圆角矩形符号 **R**：宽度为符号大小，高度为宽度的65%，角半径为宽度的10%
- 数学圆弧符号 **m|M**：角度在-10°-45°，箭头大小为符号大小的30%
- 楔形符号 **w**：角度为-30°到30°

示例
----

.. gmtplot:: legend/legend_ex1.sh
   :width: 100%
   :align: center

   legend示例图1

相关模块
--------

:doc:`gmtlogo`,
:doc:`basemap`,
:doc:`text`,
:doc:`plot`
