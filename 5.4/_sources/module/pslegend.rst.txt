.. index:: ! pslegend

pslegend
==========

:官方文档: :doc:`gmt:pslegend`
:简介: 在图上添加图例

选项
----

``-C<dx>/<dy>``
    设置图例边框与内部图例之间的空白，默认值为 ``4p/4p``

``-D[g|j|J|n|x]<refpoint>+w<width>[/<height>][+j<justify>][+l<spacing>][+o<dx>[/<dy>]]``
    设置图例的位置和大小

    - ``[g|j|J|n|x]<refpoint>`` 指定底图上的参考点，见 :doc:`/basis/embellishment`
    - ``+w<width>/<height>`` 用于指定图例框的尺寸，若 ``<height>`` 未指定或取0，则GMT会自动估算所需的高度
    - ``+j<justify>`` 指定图例上的锚点，默认锚点是 ``BL`` ，见 :doc:`/basis/embellishment` 一节
    - ``+o<dx>/<dy>`` 指定参考点的额外偏移量
    - ``+l<spacing>`` 行间距因子，默认值为1.1，则当前字体大小的1.1倍

    该选项几个比较有用的用法是：

    #. 将图例放在左下角： ``-DjBL+w4c+o0.2c/0.2c``
    #. 将图例放在左上角： ``-DjTL+w4c+o0.2c/0.2c``
    #. 将图例放在右下角： ``-DjBR+w4c+o0.2c/0.2c``
    #. 将图例放在右上角： ``-DjTR+w4c+o0.2c/0.2c``

``-F``
    控制图例的背景属性，见 :doc:`/basis/embellishment` 一节

    默认图例无边框，使用该选项则会给图例绘制边框。

图例文件格式
------------

图例文件用于控制图例中各项的布局。图例文件中的每个记录对应图例中的一项，图例中
每项的顺序由记录的先后顺序决定。每个记录的第一个字符决定了当前记录的图例类型。
GMT中共有14种图例类型，列举如下：

``# comment``
    以#开头的行或空行都会被跳过

``A cptname``
    指定CPT文件，使得某些记录可以通过指定Z值来设定颜色，可以多次使用该记录以
    指定不同的CPT文件

``B cptname offset height [optional arguments]``
    绘制水平colorbar

    #. ``offset`` 是colorbar相对于图例框左边界的距离
    #. ``height`` 是colorbar高度，其后可以加上子选项 ``+e[b|f][<length>]][+h][+ma|c|l|u][+n[<txt>]``
    #. 还可以添加其他一些参数：-B、-I、-L、-M、-N、-S、-Z、-p等，详情见 :doc:`psscale` 命令

``C textcolor``
    接下来的所有文本所使用的颜色。

    可以直接指定颜色，也可以用 ``z=<val>`` 指定Z值，以从CPT文件中查找相应的颜色
    （CPT文件由A记录指定），若 ``textcolor`` 为 ``-`` ，则使用默认颜色

``D [offset] pen [-|+|=]``
    绘制一条水平线

    #. ``offset`` 为线条左右顶端与图例边框的空白距离
    #. ``pen`` 为线条属性

       #. 默认值为0
       #. 若未指定pen，则使用 ``MAP_GRID_PEN_PRIMARY``
       #. 若pen设置为 ``-`` ，则绘制一条不可见的线

    #. 默认情况下，线条上下各留出四分之一的行间距， ``-|+|=`` 分别表示线条
       上方无空白、线条下方无空白和线条上下均无空白。

``F fill1 fill2 ... filln``
    指定单元的填充色。

    可以直接指定颜色，也可使用 ``z=<value>`` 形式指定从CPT文件中查找颜色。
    若只给定了一个 ``fill`` ，则整行都使用相同的填充色，否则依次为当前行的
    每列应用不同的 ``fill`` ，若 ``fill`` 为 ``-`` ，则不填充。

``G gap``
    给定一个垂直空白

    空白的高度由 ``gap`` 决定， ``gap`` 可以用 ``i|c|p`` 单位，也可以用 ``l``
    作为单位表示多少行空白， ``gap`` 也可以取负值，表示将当前行上移。

``H fontsize|- font|- header``
    为图例指定一个居中的标题。

    #. ``header`` 为标题
    #. ``fontsize`` 为字号
    #. ``font`` 为字体号
    #. ``-`` 表示使用默认的文字大小以及默认字体 ``FONT_TITLE``

``I imagefile width justification``
    将EPS或光栅文件放在图例中

    #. ``width`` 为图片宽度
    #. ``justification`` 为图片的对齐方式

``L fontsize|- font|- justification label``
    在图例中某列增加指定的文字

    #. ``label`` 为显示的文本
    #. ``fontsize`` 为字号
    #. ``font`` 为字体号
    #. ``justification`` 为对齐方式，可以取 ``L|C|R`` ，分别表示左对齐、居中对齐和右对齐
    #. ``-`` 表示使用默认的文字大小以及默认字体 ``FONT_TITLE``

``M slon|- slat length [+f][+l[label]][+u] [-Fparam] [-Rw/e/s/n -Jparam]``
    在图例中绘制比例尺，在 :doc:`psbasemap` 命令中有详细介绍

``N ncolumns`` 或 ``N relwidth1 relwidth2 ... relwidthn``
    修改图例中的列数

    默认只有一列，该记录仅对S和L记录有效。该记录指定的列数会一直有效直到再次
    使用N记录。 ``ncolumns`` 用于指定若干个等宽的列， ``relwidth1 relwidth2 ... relwidthn``
    用于指定每列所占的相对宽度，所有宽度的和应等于 ``-D`` 选项所设置的宽度相等。

``P paragraph-mode-header-for-pstext``
    在图例中添加段落，参考 :doc:`pstext` 命令中的段落模式

``S [dx1 symbol size fill pen] [dx2 text]``
    在图例中绘制符号

    #. ``symbol`` 指定要绘制的符号类型， 见 :doc:`psxy` 命令的 ``-S`` 选项。若 ``symbol`` 设置为 ``-`` 则表示绘制线段
    #. ``dx1`` 是符号中心与左边界的距离
    #. ``dx2`` 是 ``text`` 与左边界的距离
    #. ``text`` 的字体由参数 ``FONT_ANNOT_PRIMARY`` 控制
    #. ``fill`` 和 ``pen`` 控制符号的填充和轮廓颜色，设置为 ``-`` 则表示不填充或无轮廓颜色
    #. ``fill`` 可以使用 ``z=<val>`` 的形式，从CPT文件中查找颜色
    #. ``dx1`` 除了可以指定距离，还可以使用 ``L|C|R`` 表示符号在当前列的对齐方式
    #. 若S记录中无其他参数，则直接调至下一列
    #. 若 ``symbol`` 取为 ``f|q|v`` ，则可以在 ``symbol`` 后加上额外的子选项
    #. 某些符号可能需要指定多个size，将多个size用逗号分隔作为size即可

``T paragraph-text``
    用参数 ``FONT_ANNOT_PRIMARY`` 打印一段文本

``V [offset] pen``
    在两列之间绘制垂直的线条

示例
----

.. literalinclude:: /scripts/pslegend_ex1.sh
   :language: bash

.. figure:: /images/pslegend_ex1.*
   :width: 100%
   :align: center

   pslegend示例图1

.. literalinclude:: /scripts/pslegend_ex2.sh
   :language: bash

.. figure:: /images/pslegend_ex2.*
   :width: 100%
   :align: center

   pslegend示例图2
