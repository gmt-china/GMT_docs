:author: 田冬冬, 姚家园, 邓山泉, 陈箫翰
:date: 2026-01-13

.. index:: ! text
.. program:: text

text
====

:官方文档: :doc:`gmt:text`
:简介: 在图上写文本

**text** 绘制各种大小、字体和方向的文本字符串，并可以选择绘制和标注地图边界。
支持希腊字母、下标、上标和小型大写字母，详情请参考 :doc:`/basis/special-character` 和 :doc:`/basis/escape-character` 。
使用 :option:`-G` 或 :option:`-W` 选项，可以绘制文本下方的背景矩形。注意这不适用于包含上/下标、符号或组合字符的字符串，除非在段落模式 :option:`-M` 下。

将字符串包含在 @[ ... @[ 或 <math> ... </math> 之中可以排版 LaTeX 表达式，详情请参见 :doc:`/basis/latex`。

语法
----------

**gmt text**
[ *textfiles* ]
[ :option:`-A` ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ [*dx*\ [/*dy*]][**+to**\|\ **O**\|\ **c**\|\ **C**] ]
[ :option:`-D`\ [**j**\|\ **J**]\ *dx*\ [/*dy*][**+v**\ [*pen*]] ]
[ :option:`-F`\ [**+a**\ [*angle*]][**+c**\ [*justify*]][**+f**\ [*font*]][**+j**\ [*justify*]][**+h**\|\ **l**\|\ **r**\ [*first*]\|\ **t**\ *text*\|\ **z**\ [*format*]] ]
[ :option:`-G`\ [*fill*][**+n**] ]
[ :option:`-J`\ *parameters* ]
[ :option:`-Jz|Z`\ *parameters* ]
[ :option:`-L` ]
[ :option:`-M` ]
[ :option:`-N` ]
[ :option:`-Q`\ **l**\|\ **u** ]
[ :option:`-R`\ *west*/*east*/*south*/*north*\ [/*zmin*/*zmax*][**+r**][**+u**\ *unit*] ]
[ :option:`-S`\ [*dx*/*dy*/][*shade*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z` ]
[ :option:`-a`\ *flags* ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-w`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*textfiles*
    一个或多个输入文件，每行格式为 *x* *y* [*font* *angle* *justify*] *text* 。
    根据 :option:`-F` 的参数决定是否需要方括号中的项。如果未给定文件， **text** 将读取标准输入。
    *font* 格式为 [*size*,][*fontname*,][*color*]，其中 *size* 是以磅 (points) 为单位的文本大小， *fontname* 是要使用的字体， *color* 设置字体颜色。
    *font* 后附加 =\ *pen* 可以设置文字的描边轮廓。 *angle* 是从水平方向开始逆时针方向测量的角度（单位为度）， *justify* 设置对齐方式。
    *fontname* 可以用字体编号表示，也可以用字体名称表示。使用 :option:`-L` 可以列出所有的字体编号和名称。

    (*x*,\ *y*) 是文本字符串锚点的坐标位置，锚点由对齐方式 *justify* 设置。详情请参见 :doc:`/basis/anchor` 。

可选选项
--------

.. option:: -A

**-A**
    默认情况下， 输入数据中 *angle* 是指沿水平方向逆时针旋转的角度。
    :option:`-A` 选项表明 *angle* 是方位角，即相对于北向顺时针旋转的角度。

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ [*dx*\ [/*dy*]][**+to**\|\ **O**\|\ **c**\|\ **C**]
    设置文本框与文本之间的空白区域，默认值为字体大小的15%。该选项仅当指定了 :option:`-W` 或 :option:`-G` 选项时才有效。
    *dx* 可以是具体的距离值也可以接 **%** 表示空白与当前字号的百分比，例如 **-C1c/1c** 或 **-C20%/30%**。
    如果未指定 *dy* ，则默认为与 *dx* 相等。 **+t** 可以用于进一步控制文本框的形状：

    - **+to** ：直角矩形 [默认值]
    - **+tO** ：圆角矩形
    - **+tc** ：凹矩形（仅限段落模式 :option:`-M` 时有效）
    - **+tC** ：凸矩形（仅限段落模式 :option:`-M` 时有效）

.. option:: -D

**-D**\ [**j**\|\ **J**]\ *dx*\ [/*dy*][**+v**\ [*pen*]]
    文本在指定坐标的基础上偏移 *dx*,\ *dy* ，默认值为 ``0/0`` 即不偏移。如果未指定 *dy* ，则默认为与 *dx* 相等。

    使用 **text** 经常遇到的情况是在台站处标记台站名，此时传递的位置参数通常是台站坐标，因而会将文本置于台站坐标处。
    该选项用于将文本稍稍偏离台站坐标位置以避免文本挡住台站处的符号。

    - **-Dj** ：表示沿着 *justify* 的方向偏移
    - **-DJ** ：表示将角落处的对角线偏移量缩短 :math:`\sqrt{2}` 倍
    
    附加 **+v** 表示绘制一条连接初始位置与偏移后位置的直线， *pen* 控制连线的画笔属性。
    **注意**： **-Dj|J** 选项不能与段落模式 :option:`-M` 一起使用。

.. option:: -F

**-F**\ [**+a**\ [*angle*]][**+c**\ [*justify*]][**+f**\ [*font*]][**+j**\ [*justify*]][**+h**\|\ **l**\|\ **r**\ [*first*]\|\ **t**\ *text*\|\ **z**\ [*format*]]
    默认情况下，文本将水平放置，字体属性由 :term:`FONT_ANNOT_PRIMARY` 控制，对齐方式为中心位置的锚点。
    使用本选项可以设置字体、角度和对齐方式：

    - **+a** ：设置文本角度。如果未给出具体角度，则输入文件中必须包含一列角度数据。
    - **+A** ：强制将文本基线转换为 -90/+90 范围（防止文本颠倒）。
    - **+c** ：附加对齐方式 *justify* ，从而使用从 :option:`-R` 选项中提取的坐标，而不是从输入文件中读取。
      例如， **-F+c**\ TL 将从 :option:`-R` 范围中获取 *x_min* 和 *y_max* ，将文本绘制在地图的左上角。
    - **+f** ：设置字体 [*size*][,\ *fontname*][,\ *color*] 。如果未给出字体信息，则输入文件中必须包含一列字体信息。
    - **+j** ：设置对齐方式。如果未给出对齐方式，则输入文件中必须包含一列该信息。

    通常，文本是从数据记录中读取的。可以设置其他的数据读取替代方式：

    - **+h** ：使用最近的段头作为要绘制的文本。
    - **+l** ：使用最近的分段标签作为要绘制的文本。
    - **+r** ：使用记录编号作为要绘制的文本，从 *first* [默认为 0] 开始计数。
    - **+t** ：使用附加的 *text* 设置固定文本字符串。如果 *text* 中包含加号字符，则 **+t** 必须放在本选项参数的最后。
    - **+z** ：使用附加的 *format* 将输入的 *z* 值格式化为字符串 [如果未附加格式，则使用 :term:`FORMAT_FLOAT_MAP` ]。

    **注意**：

    - :option:`-F`\ **+h**\|\ **l**\|\ **r**\|\ **t**\|\ **z** 不能与段落模式 :option:`-M` 一起使用。
    - 如果 :option:`-Z` 生效，则用于格式化的 *z* 值要位于第 4 列而非第 3 列。如果只想从尾随文本中提取特定单词而非整行，请使用 **-it**\ *word* 指定所需的单词（0 代表第一个单词）。
    - 从数据文件中读取的项，其顺序应与 :option:`-F` 中指定的附加选项 **顺序一致**。
      例如： **-F**\ **+f**\ 12p,Helvetica-Bold,red\ **+j+a** 设置了 12 磅红色粗体 Helvetica 字体，指定了对齐方式和角度两个附加选项，但没有设置具体的值。
      那么在输入数据的 *x* *y* 之后、文本内容之前，必须有对齐方式和角度两列数据。

.. option:: -G

**-G**\ [*fill*][**+n**]
    设置文本框的填充图案 *fill* [默认不填充]。如果不设置 *fill* ，本选项会开启裁剪功能，裁剪范围为文本范围。裁剪功能可通过 :doc:`clip` **-C** 关闭。
    用 **-G+n** 则只开启裁剪功能，不绘制文本。 **注意**：此功能不能与 LaTeX 表达式同时使用。

.. include:: explain_-J.rst_

.. include:: explain_-Jz.rst_

.. option:: -L

**-L**
    用于列出 GMT 所支持的所有字体的名称及其对应的编号。

.. option:: -M

**-M**
    段落模式，用于输入大量文本。输入文件必须是多段数据。数据段头记录的格式为::

        > X Y [font angle justify] linespace parwidth parjust

    第一个字符是数据段开始标识符，默认为 **>** 。是否需要 *font angle justify* 由 :option:`-F` 选项控制。
    *linespace* 和 *parwidth* 分别为行间距和段落宽度。
    段落文本的对齐方式由 *parjust* 控制，可以是 **l** 左对齐、 **c** 居中对齐、 **r** 右对齐或 **j** 两端对齐。
    段头记录之后是一行或多行段落文本。文本中可以包含转义序列，但不支持组合字符。可以用空行分隔不同的段落。

    请注意，在此模式下，通过 :option:`-F`\ **+j** 设置的对齐方式只适用于文本框，
    而文本本身的对齐方式则由 *parjust* 决定。此模式不能与 LaTeX 表达式同时使用。

.. option:: -N

**-N**
    位于地图边界外的文本也被绘制。

    默认情况下，若文本超过了底图边框，则不显示该文本，即文本被裁剪掉了。
    使用本选项，即便文本超出了底图边框的范围，也依然会显示。

.. option:: -Q

**-Q**\ **l**\|\ **u**
    所有文本以小写（ **l** ）或大写（ **u** ）显示。

.. include:: explain_-Rz.rst_

.. option:: -S

**-S**\ [*dx*/*dy*/][*shade*]
    在文本框下方绘制一个有偏移的背景阴影区域， *dx/dy* 表示相对于文本框的偏移量 [默认 4\ **p**/-4\ **p** ]。
    而 *shade* 设置用于阴影的填充颜色 [默认 gray50]。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*
    设置文本框边框的画笔属性，默认值为 width = 0.25p, color = black, style = solid。
    注意不能与 LaTeX 表达式同时使用。

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**
    对文字进行3D投影。需要在数据的第三列指定文本的Z位置，数据格式为::

        X   Y   Z   Text

    此时强制使用 :option:`-N` 选项。
    **注意**：段落模式尚未实现此功能。如果使用了 :option:`-F`\ **+z**，则文本的Z位置要放在第 4 列。

.. include:: explain_-aspatial.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. option:: -i

**-it**\ *word*
    用于从尾随文本中选择特定的单词 [默认使用整个尾随文本]。 *word* 表示单词的序号，第一个单词为 0。注意，此选项不能用于指定数值列。

.. include:: explain_perspective.rst_
..

    段落模式尚未实现此功能。

.. include:: explain_-qi.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

下面的例子中设置文本框的相关属性：蓝色边框、淡蓝填充色、圆角矩形，空白为 100%/100% ::

    gmt text -R0/10/0/5 -JX10c/5c -B1 -Wblue -Glightblue -C100%/100%+tO -pdf text << EOF
    3   1   Text1
    6   3   Text2
    EOF

段落模式示例：

.. gmtplot:: text/text_-M.sh
   :width: 80%
   :show-code: true

Windows 注意事项
------------------------------

请注意，在 Windows 系统下，百分号 (%) 是变量指示符（类似于 Unix 下的 $）。若要在批处理脚本中表示普通的百分号，需要重复该符号 (%%)。
因此，字体切换机制（@%\ *font*\ % 和 @%%）可能需要双倍数量的百分号。这仅适用于脚本内部或由 DOS 处理的文本。由该模块打开并读取的数据文件不需要这种重复。

组合字符
--------------------

如果要组合的两个字符来自不同的字体（例如 Symbol 和 Times），则允许为第二个字符（但不能是第一个）添加转义代码，以临时更改该字符的字体。
例如，序列 "@!\\227@~\\145@~" 将打印 epsilon 字符（来自 Symbol 字体的八进制代码 \\145），并带有由重叠打印的点（来自当前字体的八进制代码 \\227，假设为 ISOLatin1 字符集）表示的时间导数。

限制
-----------

在段落模式下，组合字符和其他转义序列的存在可能会导致不理想的断词。此外，如果在字体设置中要求了轮廓画笔属性，则在段落模式下该设置无效。
请注意，如果有任何单个单词的宽度超过了您选择的段落宽度，则段落宽度会自动扩大以适应最宽的单词。

从外部接口调用
---------------------------

当从外部接口调用该模块时，我们对 :option:`-F` 设置施加了以下限制：
如果指定了 **+a** （从输入读取角度），则它必须出现在 **+f** （从输入读取字体）和 **+j** （从输入读取对齐方式）之前（如果存在这些选项）。
因为角度是一个数值列，而字体和对齐方式必须作为尾随文本的一部分进行编码。

相关模块
--------

:doc:`clip`,
:doc:`psconvert`,
:doc:`basemap`,
:doc:`legend`,
:doc:`plot`
