.. index:: ! text

text
====

:官方文档: :doc:`gmt:text`
:简介: 在图上写文本

该命令用于在图上添加文本，可以自由控制文本的大小、颜色、字体、角度。

除了可以添加键盘上可直接输入的字符外，还可以通过使用转义字符、特殊字体以及八进制码
实现希腊字母、上下标等功能，详见 :doc:`/basis/text`\ 、\ :doc:`/basis/escape-character`\ 、
:doc:`/basis/special-character`\ 。

必选选项
--------

``<textfiles>``
    输入文件。最简单的情况下，输入数据包括三列，其格式为::

        X  Y  text

    示例::

        echo 2 2 SHOW TEXTS | gmt text -JX10c -R0/5/0/5 -Ba -pdf test

    若使用了 ``-F`` 选项，则输入数据的格式为::

        x  y  [font  angle  justify]  text

    其中，括号内的三项是否存在以及三项的顺序由 ``-F`` 选项决定。

可选选项
--------

.. _-A:

**-A**
    默认情况下， 输入数据中 *angle* 是指沿水平方向逆时针旋转的角度。
    **-A** 选项表明 *angle* 是方位角，即相对于北向顺时针旋转的角度。

.. _-C:

**-C**\ [*dx/dy*][**+to**\|\ **O**\|\ **c**\|\ **C**]
    设置文本框与文本之间的空白区域，默认值为字体大小的15%。
    该选项仅当指定了 **-W** 或 **-G** 选项时才有效。
    *dx* 可以是具体的距离值也可以接 **%** 表示空白与当前字号的百分比。
    例如 **-C1c/1c** 或 **-C20%/30%**\ 。

    **+t** 可以用于进一步控制文本框的形状

    - **+to**: 直角矩形 [默认值]
    - **+tO**: 圆角矩形
    - **+Tc**: 凹矩形（与 **-M** 选项一起使用）
    - **-TC**：凸矩形（与 **-M** 选项一起使用）

    下图展示了 **-C** 选项的作用。

    .. gmtplot:: /scripts/text_clearance.sh
       :show-code: false
       :width: 80%

``-D[j|J]<dx>[/<dy>][+v[<pen>]]``
    文本在指定坐标的基础上偏移 ``<dx>/<dy>`` ，默认值为 ``0/0`` 即不偏移。

    使用text经常遇到的情况是在台站处标记台站名，此时传递给text的位置参数
    通常是台站坐标，因而text会将文本置于台站坐标处，该选择用于将文本稍稍偏
    离台站坐标位置以避免文本挡住台站处的符号。

    #. 若不指定 ``<dy>`` ，则默认 ``<dy>=<dx>``
    #. ``-Dj<dx>/<dy>`` 表示沿着 ``<justify>`` 所指定的方向偏移
    #. ``-DJ<dx>/<dy>`` 表示shorten diagonal offsets at corners by sqrt(2)
    #. 偏移量后加上 ``+v`` 表示绘制一条连接初始位置与偏移后位置的直线
    #. ``+v<pen>`` 控制连线的画笔属性

``-F[+a|+A[angle]][+c[justify]][+f[font]][+j[justify]][+h|+l|+r[<first>]|+t<text>|+z<format>]``
    控制文本的角度、对齐方式和字体等属性。

    #. ``+f<font>`` 设置文本的字体， 见 :doc:`/basis/text`
    #. ``+a<angle>`` 文本相对于水平方向逆时针旋转的角度
    #. ``+A<angle>`` force text-baselines to convert into the -90/+90 range
    #. ``+j<justify>`` 文本对齐方式，见 :doc:`/basis/anchor`

    下面的命令中，统一设置了所有文本的字号为30p，4号字体，红色，文本旋转45度，
    且以左上角对齐::

        gmt text -R0/10/0/10 -JX10c/10c -B1g1 -F+f30p,4,red+a45+jTL -pdf text << EOF
        3 4 Text1
        6 8 Text2
        EOF

    若使用了 ``+f`` 子选项，但是未给定 ``<font>`` ，则意味着输入数据的每一行
    需要自定义本行的字体属性，因为输入数据的格式要发生变化。例如 ``-F+f`` 选项
    要求的输入数据的格式为::

        x   y   font    text

    对于 ``+a`` 和 ``+j`` 同理。若 ``+f`` 、 ``+a`` 、 ``+j`` 中有两个以上
    未在命令行中指定参数，则输入数据中要增加多列，每列的顺序由这三个子选项的
    相对顺序决定。比如 ``-F+f+a`` 的输入数据格式是::

        x   y   font   angle  text

    ``-F+a+f`` 的输入数据格式为::

        x   y   angle  font   text

    ``-F+f+j+a`` 表示所有数据都需要单独指定字体、对齐方式和角度，此时输入数据的格式为::

        x   y   font    justification   angle    text

    ``-F+a+j+f`` 与前一个例子类似，唯一的区别在于子选项的顺序不同，而输入数据的
    格式要与子选项的顺序相匹配，此时输入数据的格式为::

        x   y   angle   justification   font    text

    ``-F+f12p,Helvetica-Bold,red+j+a`` 为所有行设置了统一的字体，但每一行需要
    单独指定对齐方式和角度，此时输入数据的格式为::

        x   y   justification   angle   text

    使用 ``+c<justify>`` 选项，则输入数据中不需要XY坐标，只需要文本即可，该选项
    直接从 ``-R`` 选项中提取出范围信息，并由对齐方式决定文本的坐标位置。
    比如 ``-F+cTL`` 表示将文本放在底图的左上角，在加上合适的偏移量即可放在任意
    位置。例如::

        echo '(a)' | gmt text -R0/10/0/10 -JX10c/10c -B1 -F+cTL -Dj0.2c/0.2c -pdf text

    通常来说，要绘制的文本都来自于输入数据的某一列。对于多段数据而言，还可以
    使用其他子选项来设置文本的来源：

    -  ``+h`` 会直接从多段数据的段头记录中提取文本::

            gmt text -R0/10/0/10 -JX10c/10c -B1 -F+h -pdf text << EOF
            > TEXT1
            2  2
            > TEXT2
            5  5
            EOF

    -  ``+l`` 会直接从多段数据的段头记录里的 ``-L<label>`` 中提取信息::

            gmt text -R0/10/0/10 -JX10c/10c -B1 -F+l -pdf text << EOF
            > -LTEXT1
            2  2
            > -LTEXT2
            5  5
            EOF

    -  ``+r<first>`` 会使用记录号作为文本（记录号从 ``<first>`` 起算）
    -  ``+t<text>`` 设置使用一个固定的字符串
    -  ``+z<format>`` 将 Z 值以特定的格式输出为字符串，默认格式由 FORMAT_FLOAT_MAP 控制

``-G``
    设置文本框的填充色。

    除了设置填充色之外， ``-G`` 选项还有两个高级用法，即 ``-Gc`` 和 ``-GC`` 。
    其中， ``-Gc`` 表示先绘制文本，然后将文本框裁剪出来，并打开裁剪选项，之后的
    绘图命令都不会覆盖文本所在区域，最后需要使用 :doc:`clip` 的 ``-C`` 选项
    关闭裁剪。若不想要绘制文本只想要激活裁剪选项，可以使用 ``-GC`` 选项。

``-L``
    用于列出GMT所支持的所有字体名及其对应的字号::

        gmt text -L

``-M``
    段落模式，用于输入大量文本。

    输入文件必须是多段数据。数据段头记录的格式为::

        > X Y [font angle justify] linespace parwidth parjust

    #. 第一个字符是数据段开始标识符，默认为 ``>``
    #. 从第三列开始，包含了本段文本的设置信息
    #. ``font angle justify`` 是可选的，由 ``-F`` 选项控制
    #. ``linespace`` 行间距
    #. ``parwidth`` 段落宽度
    #. ``parjust`` 段落对齐方式，可以取为 ``l`` （左对齐）、 ``c`` （居中对齐）、
       ``r`` （右对齐）、 ``j`` （分散对齐）

    段头记录后即为要显示在图上的文本，每段数据之间用空行分隔。

    .. gmtplot:: /scripts/text_-M.sh

       段落模式示意图

**-N**
    位于地图边界外的文本也被绘制。

    默认情况下，若文本超过了底图边框，则不显示该文本，即文本被裁剪掉了。
    使用 ``-N`` 选项，即便文本超出了底图边框的范围，也依然会显示。

``-Ql|u``
    所有文本以小写（lower case）或大写（upper case）显示

**-W**\ *pen*
    设置文本框的边框属性，默认值为 ``default,black,solid``

``-Z``
    3D投影中，需要在数据的第三列指定文本的Z位置，数据格式为::

        X   Y   Z   Text

    此时强制使用 ``-N`` 选项。

.. include:: explain_-U.rst_

.. include:: explain_-t.rst_

示例
----

下面的例子中设置文本框的相关属性：蓝色边框、淡蓝填充色、圆角矩形，空白为 ``100%/100%`` ::

    gmt text -R0/10/0/5 -JX10c/5c -B1 -Wblue -Glightblue -TO -C100%/100% -pdf text << EOF
    3   1   Text1
    6   3   Text2
    EOF
