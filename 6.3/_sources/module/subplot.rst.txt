.. index:: ! subplot
.. include:: common_SYN_OPTs.rst_

subplot
=======

:官方文档: :doc:`gmt:subplot`
:简介: 管理和设置子图模式

**subplot** 模块可以将当前纸张分隔成若干个网格区域，每个区域内都可以包含一张
单独的子图。

**subplot**  模块提供了三条指令：

- **subplot begin** 进入子图模式，并设置子图的布局
- **subplot set** 用于指定接下来的绘图操作在哪一个子图中进行
- **subplot end** 用于结束子图模式

在子图模式中，需要注意如下几点：

- |-X| 和 |-Y| 选项无法在子图模式中使用，可以使用 |-C| 选项作为替代
- 在使用 |-J| 选项时，可以使用 **?** 来指定地图宽度或比例尺，此时，GMT会根据
  子图的大小自动确定最合适的地图尺寸
- 对于笛卡尔投影，若想要X和Y轴共用相同的比例尺，则可以使用 **-Jx?**

subplot begin 语法
------------------

**gmt subplot begin**
*nrows*\ **x**\ *ncols*
|-F|\ [**f**\|\ **s**]\ *width*\ /*height*\ [**+f**\ *wfracs*\ /*hfracs*][**+c**\ *dx/dy*][**+g**\ *fill*][**+p**\ *pen*][**+w**\ *pen*]
[ |-A|\ [*autolabel*][**+j**\|\ **J**\ *refpoint*][**+c**\ *dx*\ /\ *dy*][**+g**\ *fill*][**+p**\ *pen*][**+o**\ *dx*/*dy*][**+r**][**+R**][**+v**] ]
[ |-C|\ [*side*]\ *clearance* ]
[ |SYN_OPT-B| ]
[ |SYN_OPT-J| ]
[ |-M|\ *margins* ]
[ |SYN_OPT-R| ]
[ |-S|\ *layout* ]
[ |-T|\ *title* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT--| ]

必须选项
--------

*nrows*\ **x**\ *ncols*
    指定子图的行数和列数。中间为小写英文字母 **x**，不是星号或其他符号。

    每一行和每一列均有相同的子图数目。注意：你无需在每个子图内都绘图。

.. _-F:

**-F**\ [**f**\|\ **s**]\ *width*\ /*height*\ [**+f**\ *wfracs*\ /*hfracs*][**+c**\ *dx/dy*][**+g**\ *fill*][**+p**\ *pen*][**+w**\ *pen*]
    指定图片的尺寸。有两种方式：

    - **-Ff**: 直接指定整张图片的尺寸
    - **-Fs**: 指定单个子图的尺寸

    除此之外，还可以为整张图加上背景色和边框:

    - **+p**\ *pen*: 为整张图加上背景矩形边框
    - **+w**\ *pen*: 绘制子图区域之间的水平和垂直分割线
    - **+g**\ *fill*: 为整张图的背景矩形填充颜色
    - **+c**\ *dx/dy*: 设置背景矩形与整张图之间的额外空白

    **-F**\ [**f**]\ *width*/*height*\ [**+f**\ *wfracs*\ /*hfracs*]
        指定整张图片的宽度 *width* 和高度 *height*。

        这种情况下，GMT会根据整张图片的尺寸以及子图的数目自动计算每张子图的尺寸。
        在计算子图尺寸时会考虑每个子图的刻度线、标注、标签所占据的空间，以及不同子图
        之间的间隔。整张图的最外圈的刻度线、标记和标签不算在整张图片尺寸之内。

        默认所有行和列的尺寸都是相同的。若想要子图的每一行具有不同的高度，
        或者子图的每一列具有不同的宽度，则可以使用
        **+f**，后面紧跟着一系列逗号分隔的宽度比例和以逗号分隔的高度比例。
        单个数则表示所有行或列有相同的宽度或高度。

        例如，对于一个2x2的子图，使用\ **-Ff**\ 12c/12c+f3,1/1,2 则表示

        - 整张图的宽度和高度均为12厘米
        - 第一列占3个宽度，第二列占1个宽度
        - 第一行占1个高度，第二行占2个高度

    **-Fs**\ *widths*/*heights*
        通过指定每个子图的宽度和高度间接指定图片尺寸。

        在这种情况下，整张图片的尺寸由每个子图的尺寸以及刻度线、标注、标签占据的
        空间和子图之间的间隙共同决定，但最外圈的刻度线、标记、标签所占据的空间不算
        在整张图的尺寸之内。

        默认所有行和列的尺寸都是相同的。若想要给每行或每列指定不同的子图尺寸，
        可以加上一系列以逗号分隔的宽度，然后再加上一个斜杠，并加上一系列以逗号分隔的高度。
        单个数则表示所有行或列有相同的宽度或高度。

        例如，对于一个2x2的子图，使用 **-Fs**\ 4c,8c/4c 则表示
        第一列为4厘米宽，第二列为8厘米宽，所有列的高度均为4厘米高。
        注意，宽度值或高度值的数目必须是一个或者与行数/列数相匹配。

        对于地理地图而言，每张子图的高度由地图区域 |-R| 以及投影方式 |-J| 决定。
        有两个选择：(1) 指定子图高度为0，并同时指定 |-R| 和 **-J**，
        利用其计算每张子图的高度，但要求所有子图必须共享相同的研究区域和投影方式；
        (2) 不断尝试并修改子图的高度以得到最佳的绘图布局。

可选选项
--------

.. _-A:

**-A**\ [*autolabel*][**+j**\|\ **J**\ *refpoint*][**+c**\ *dx*\ /\ *dy*][**+g**\ *fill*][**+p**\ *pen*][**+o**\ *dx*/*dy*][**+r**][**+R**][**+v**]
    为子图自动添加编号。

    *autolabel* 可以是单个数字或字母，也可以在数字或字母的一侧或两侧加上括号。
    其设置了左上角第一张子图的编号，而其余子图则按照递增的顺序依次编号。
    默认值为 **a)**。

    .. note::

       括号在Unix Shell中有特殊含义，可以将其用单引号括起来，即 ``'(a)'``。

    加上子选项可以指定编号的更多属性：

    - **+j**\|\ **J**\ *refpoint*: 指定编号在子图中的位置，默认值为 ``TL``，
      即编号位于子图的左上角。**+j** 和 **+J** 分别适用于子图编号位于子图内部和
      外部的情况
    - **+o**\ *dx*\ [/*dy*] 设置子图编号相对于 **+j|J** 指定的参考位置间的额外偏移量，
      默认值为 :term:`FONT_TAG` 的20%
    - **+p**\ *pen* 为子图编号加上文本框
    - **+g**\ *fill* 为子图编号的文本框填充颜色
    - **+c**\ *dx*\ [/*dy*]: 设置子图编号与文本框轮廓间的距离，默认值为 :term:`FONT_TAG` 的15%
    - **+r** 表示用小写罗马数字编号
    - **+R** 表示用大小罗马数字编号
    - **+v** 表示沿着垂直列方向依次增加编号，默认沿着水平行方向依次增加

.. |Add_-B| replace:: 该选项会应用到所有子图。
.. include:: explain_-B.rst_

.. _-C:

**-C**\ [*side*]\ *clearance*
    设置子图区域内某个边的额外空白量。这些额外的空白量可以用于绘制比例尺、
    添加额外的文字等。

    *side* 可以取 **e** **w** **s** **n** 分别代表东西南北四条边；
    也可以取 **x** 或 **y**，分别表示设置东西或南北方向两条边的空白；
    若不指定 *side*，则表示同时设置四条边上的空白量。

    该选项可以重复多次，对不同边分别设置不同的间距。

    **subplot begin** 中该选项对所有子图均有效，而 **subplot set** 中使用该选项
    则仅对当前子图有效。

    .. note::

       在子图模式内不能使用 |-X| 和 **-Y**，可以使用 |-C| 作为替代。

.. include:: explain_-J.rst_

.. _-M:

**-M**\ *margins*
    相邻子图之间的额外空白

    *margins* 可以有三种情况：

    #. 取一个值，表示子图四个方向的空白 [默认值为 :term:`FONT_ANNOT_PRIMARY` 规定的字体大小]
    #. 取两个值，表示子图的水平和垂直方向的空白，两个值之间用斜杠分隔
    #. 取四个值，表示子图的左右下上四个方向的空白，四个值之间用斜杠分隔

    *margins* 允许设置为负值，进一步缩小子图间距。

.. |Add_-R| replace:: 该选项会应用于所有子图
.. include:: explain_-R.rst_

.. _-S:

**-SC**\ [**b**\|\ **t**][**+l**\ *label*][**+t**]
    设置一列中的所有子图共用X轴

    当一列所有子图共用X轴时，默认只有第一行子图的顶部（**t**） X轴
    和最后一个子图的底部（**b**）X轴有标注。

    - **-SCb** 一列中只有最后一行子图的底部X轴有标注
    - **-SCt** 一列中只有第一行子图的顶部X轴有标注
    - **+l**\ *label* 为共用的X轴添加标注
    - **+t** 为每个子图的标题预留空间
    - **+tc** 为第一行的所有子图的标题预留空间

**-SR**\ [**l**\|\ **r**][**+l**\ *label*][**+p**][**+t**]
    设置一行中所有子图共用Y轴

    当一行所有子图共用X轴时，默认只有第一列子图的左边Y轴和最后一列子图的右边Y轴有标注。

    - **-SRl** 一行中只有第一列子图的左边Y轴有标注
    - **-SRr** 一行中只有最后一列子图的右边Y轴有标注
    - **+l**\ *label* 为共用的Y轴添加标注
    - **+p** 设置所有标注与Y轴平行

.. _-T:

**-T**\ *heading*
    设置整张图的总标题，标题文字的属性由 :term:`FONT_HEADING` 控制。

    每张子图各自的标题可以用 |-B| 或 |-S| 选项控制。

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_help.rst_

subplot set
-----------

**subplot set** 通过指定子图的行列号或索引号以激活某个特定的子图，
接下来的所有绘图命令将只在该子图内进行绘制。其与 :doc:`/option/c` 功能基本一致。

子图的行号、列号、索引号均从0开始算起。因而对于MxN的子图而言，行号的取值为0到M-1，
列号的取值为0到N-1，索引号的取值则为0到(M*N-1)。

若使用 **subplot set** 但未指定子图的行列号或索引号，则GMT会自动激活“下一个”子图。
例如，对于一个2行2列的图而言，每次使用 **subplot set** 而不指定子图行和列，则
按照行优先顺序依次激活子图 ``0,0`` → ``0,1`` → ``1,0`` → ``1,1``。
若 **subplot begin** 中使用了 **-A+v** 选项，则按照列优先顺序依次激活子图
``0,0`` → ``1,0`` → ``0,1`` → ``1,1``。

subplot set 语法
----------------

**gmt subplot set**
[ *row,col*\|\ *index* ]
[ **-A**\ *fixedlabel*]
[ **-C**\ *side*\ /*clearance* ]
[ |SYN_OPT-V| ]

可选选项
--------

*row,col* | *index*
    指定要激活的子图的行列号或索引号。行列号、索引号均从0开始算起。

    若不指定子图行列号或索引号，则自动激活“下一个”子图。

**-A**\ *fixedlabel*
    设置当前子图的编号，忽略 **subplot begin** 中 |-A| 选项设置的自动编号。

    这一选项可以用于临时修改单个子图的编号，但该选项只能修改编号字符串，
    其余属性（如位置、文本框）等均只能继承自 **subplot begin** 的 |-A| 选项。

**-C**\ *side*/*clearance*
    设置子图的某个边的额外空白量。这些额外的空白量可以用于绘制比例尺、添加额外的文字等。

    *side* 可以取 **e** **w** **s** **n** 分别代表东西南北四条边。
    该选项可以重复多次，对不同边分别设置不同的间距。
    **subplot begin** 该选项对所有子图均有效，而 **subplot set** 中使用该选项
    则仅对当前子图有效。

    .. note::

       在子图模式下不能使用 |-X| 和 **-Y**，可以使用 |-C| 作为替代。

subplot end
-----------

该命令用于结束当前的子图模式。

在结束子图模式时，其会进行如下操作：

- 对所有子图进行编号
- 将绘图原点重置回之前的原点位置
- 更新历史信息，设置为线性投影，并给出整张图的大小，使得用户可以使用 **-DJ** 方式
  放置colorbar等。

subplot end 语法
----------------

**gmt subplot end** [ |SYN_OPT-V| ]

示例
----

下面的示例展示了如何设置一张2x2布局的图，并使用不同的方式指定要激活的子图。
不同的设置方式的效果是相同的，用户在使用时可根据需求选择最直观最简便的方式。

**方法1: 使用 subplot set 指定子图行列号**

注意行列号均从0开始。

.. gmtplot::

    gmt begin map
        gmt subplot begin 2x2 -Fs5c/2.5c -A
        gmt subplot set 0,0
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 0,1
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 1,0
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 1,1
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot end
    gmt end show

**方法2: 使用 subplot set 指定子图索引号**

注意子图索引号从0开始::

    gmt begin map
        gmt subplot begin 2x2 -Fs5c/2.5c -A
        gmt subplot set 0
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 1
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 2
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set 3
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot end
    gmt end show

**方法3: 使用 subplot set 但不指定子图号**

每次使用 **subplot set** 但不指定子图行列号或索引号，则会自动激活“下一个”子图::

    gmt begin map
        gmt subplot begin 2x2 -Fs5c/2.5c -A
        gmt subplot set
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot set
        gmt basemap -R0/10/0/10 -Baf
        gmt subplot end
    gmt end show

**方法4: 使用 -c 选项**

:doc:`/option/c` 的功能与 **subplot set** 类似，可以用于激活指定的子图。
其后可以接子图行列号或索引号，也可以只使用 **-c** 自动激活下一个子图::

    gmt begin map
        gmt subplot begin 2x2 -Fs5c/2.5c -A
        gmt basemap -R0/10/0/10 -Baf -c
        gmt basemap -R0/10/0/10 -Baf -c
        gmt basemap -R0/10/0/10 -Baf -c
        gmt basemap -R0/10/0/10 -Baf -c
        gmt subplot end
    gmt end show

下面展示了如何设置一个2x2的图，并设置共用X和Y轴:

.. gmtplot::

    gmt begin panels
      gmt subplot begin 2x2 -Fs10c/5c -M5p -A -SCb -SRl -Bwstr -R0/80/0/10
        gmt subplot set
        gmt basemap
        gmt subplot set
        gmt basemap
        gmt subplot set
        gmt basemap
        gmt subplot set
        gmt basemap
      gmt subplot end
    gmt end show

下面的示例展示了如何绘制一个不完全规则的子图。这个示例中，实际上只使用了子图0、
2、3，而第一张图同时占据了子图0和1的空间。在这种情况下，GMT的自动编号功能无法
正确编号，因而需要在 **subplot set** 中为每个子图单独指定编号。

.. gmtplot::

    gmt begin map
        gmt subplot begin 2x2 -Fs5c/3c -A -M0

        gmt subplot set 0
        gmt basemap -R0/20/0/10 -JX11.2c/3c -Baf -BWSen

        gmt subplot set 2 -A'(b)'
        gmt basemap -R0/20/0/10 -JX? -Baf -BWSen

        gmt subplot set 3 -A'(c)'
        gmt basemap -R0/20/0/10 -JX? -Baf -BWSen

        gmt subplot end
    gmt end show

相关模块
--------

:doc:`begin`,
:doc:`clear`,
:doc:`docs`,
:doc:`end`,
:doc:`figure`,
:doc:`inset`
