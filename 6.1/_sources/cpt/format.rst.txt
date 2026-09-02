CPT类型
=======

CPT文件可以分成两类，一种适用于分类数据，一种适用于常规数据。
下面会逐一介绍两种类型的CPT文件的格式，以及其如何实现数值与颜色之间的映射。

分类CPT
-------

分类CPT文件适用于分类数据。所谓分类数据，是指数据只能取有限个离散的值。
比如将陆地分为不同的类型：沙漠、森林、冰川等等。定义1代表沙漠，2代表森林，
3代表冰川。显然值取1.5是没有意义的。

分类CPT中，对于每个分类要指定唯一的 key，对应的颜色以及一个可选的标签。
分类CPT文件的格式为（中括号表示该项是可选项）::

    key1      fill1     [;label1]
    key2      fill2     [;label2]
    ...
    keyn      filln     [;labeln]
    B         fill_background
    F         fill_foreground
    N         fill_nan

其中：

- *key* 是分类数据的可能取值。如果 *key* 取数值，则必须单调递增但可不连续
- *fill* 是相应数据的填充色。可以是颜色，也可以是图案，见 :doc:`/basis/fill` 一节
- *label* 则是数据的标签（可选），\ *label* 前需要一个分号。
  通常设置为类型名，其主要有两个用途：让用户知道每一个可能取值代表的具体类型；
  在使用 :doc:`/module/colorbar` 绘制色标时可以将标签显示到色标旁边。

*key* 还可以取以下特殊值：

- **B**\ ：定义小于 *key1* 的值的填充色，即背景色，默认值由 :term:`COLOR_BACKGROUND` 控制
- **F**\ ：定义大于 *keyn* 的值的填充色，即前景色，默认值由 :term:`COLOR_FOREGROUND` 控制
- **N**\ ：定义值为 NaN 时使用的填充色，默认值由 :term:`COLOR_NAN` 控制

下面是一个分类CPT文件的示例，从中可以看出分类CPT文件是如何完成数据与颜色之间的映射。

.. gmtplot::
    :width: 75%

    gmt begin categorical-cpt png,pdf

    # 写一个分类CPT到文件 types.cpt
    cat > types.cpt << EOF
    0   yellow   ;desert
    1   blue     ;forest
    2   red      ;iceland
    B   white
    F   black
    N   gray
    EOF

    # 绘制圆，其中第三列Z值以及CPT中颜色的对应关系决定了圆的颜色
    gmt plot -R0/12/0/6 -JX8c/4c -Baf -BWSen -Sc1c -W1p -Ctypes.cpt << EOF
    1  3  -1
    3  3  0
    5  3  1
    7  3  2
    9  3  3.1
    11 3  NaN
    EOF

    # 绘制色标
    gmt colorbar -Ctypes.cpt -DJBC+e+n
    gmt end show

常规CPT
-------

常规CPT文件适用于连续变化的数据。对于连续变化的数据，无法为每个可能的数据值
都指定颜色，通常的做法是为某些特定值指定颜色，其它值的颜色则通过插值得到。

常规CPT文件的格式为（中括号表示该项为可选项）::

    z0     color_min_1  z1   color_max_1    [L|U|B]    [;label1]
    z1     color_min_2  z2   color_max_2    [L|U|B]    [;label2]
    ...
    zn-1   color_min_n  zn   color_max_n    [L|U|B]    [;labeln]
    B   fill_background
    F   fill_foreground
    N   fill_nan

常规CPT文件中的每一行均定义了一个Z值范围所对应的颜色范围。以第一行为例，
其定义了数据值为 *z0* 时的颜色为 *color_min_1*\ ，
数据值为 *z1* 时的颜色为 *color_max_1*\ ，而数据值位于 *z0* 到
*z1* 之间时颜色则通过对 *color_min_1* 和 *color_max_1* 线性或非线性
插值得到。由此即定义了任意数值与颜色之间的映射关系。

在每一行后面，还可以加上两个可选项：

- *label* 是Z值范围所对应的标签，在标签前需要加一个分号 **;**\ 。
  使用 :doc:`/module/colorbar` 模块绘制色标时加上 **-L** 选项则会
  将 *label* 作为色标的标注
- **L**\|\ **U**\|\ **B** 也是可选项，用于控制绘制色标时标注的放置位置。
  **L**\ 、\ **U**\ 、\ **B**\ 分别表示标注每个Z值范围的下限、
  上限或者同时标注Z值上下限。当然，也可以使用标准选项 **-B** 控制色标的标注和刻度

Z值还可以取以下特殊值：

- **B**\ ：定义小于 *z0* 的值的填充色，即背景色，默认值由 :term:`COLOR_BACKGROUND` 控制
- **F**\ ：定义大于 *zn* 的值的填充色，即前景色，默认值由 :term:`COLOR_FOREGROUND` 控制
- **N**\ ：定义值为 NaN 时使用的填充色，默认值由 :term:`COLOR_NAN` 控制

GMT对于常规CPT文件的格式由如下要求：

#. Z值必须单调递增
#. Z值不能存在间断，即每行的最大Z值必须与下一行的最小Z值相同
#. **B**\ 、\ **F**\ 、\ **N** 语句要放在CPT文件的开头或结尾
#. 可以指定颜色也可以指定填充图案，若 *color_min_1* 指定了填充图案，则
   *color_max_1* 必须设置为 **-**

常规CPT文件的格式是很灵活的，其又可以进一步细分为连续型CPT和间断性CPT：

**连续型CPT**
    当每一行的最大Z值与下一行的最小Z值对应同一个颜色。
    例如，下面的示例CPT文件中在Z取1处颜色是连续的::

        0    black      1  red
        1    red        2    yellow

**间断型CPT**
    即某一行的最大Z值与下一行的最小Z值对应不同的颜色。
    例如，下面的示例CPT文件中，第一行表明Z取1时为红色，第二行表明Z取1时为蓝色，
    即在Z取1处颜色存在间断::

        0	 black	 1    red
        1	 blue    2    yellow

    进一步，当某一行内最小Z值和最大Z值对应相同的颜色时则构成了单色间断型CPT。
    例如，下面的示例CPT文件中，第一行指定了Z取0和0.5均定义为黑色，意味着Z取0到
    1之间的任意数值均为黑色。第二行则指定了Z取1到2之间的任意数值均为红色::

        0	black	1	black
        1	red     2	red

下图展示了上面提到的三种常见的常规CPT：

.. gmtplot::
    :width: 50%

    gmt begin regular-cpt png,pdf

    # 连续型CPT
    cat > continuous.cpt << EOF
    0    black      1    red
    1    red        2    yellow
    EOF
    gmt colorbar -Ccontinuous.cpt -Dx0c/0c+w5c+h

    # 间断型CPT
    cat > discontinuous.cpt << EOF
    0      black   1    red
    1      blue    2    yellow
    EOF
    gmt colorbar -Cdiscontinuous.cpt -Dx0c/0c+w5c+h -Y1.5c

    # 单色间断型CPT
    cat > discontinous-2.cpt << EOF
    0       black   1     black
    1       red     2     red
    EOF
    gmt colorbar -Cdiscontinous-2.cpt -Dx0c/0c+w5c+h -Y1.5c

    gmt end show
