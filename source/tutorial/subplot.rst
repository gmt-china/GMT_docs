GMT子图模式
===========

.. note::

    **subplot** 模块在6.0.0rc3发布后进行了一系列修正，最大的改变在于，
    新版中行列号以及索引号均从0开始。本模块文档采用的是最新版本的用法，
    对于 6.0.0rc3 用户并不完全适用。

    等到6.0.0正式版发布，这一问题将不再存在。

有些时候，尤其是发表文章时，需要将多张独立的图放在一张图中，并编号abcd，
一般称这些独立的图为子图。

GMT中有两种方式可以绘制多子图：

- 常规方式：在绘图时使用 :doc:`/option/XY` 手动移动每个子图的原点
- 现代方式：使用 :doc:`/module/subplot` 模块提供的子图模式来布局和管理多子图

现代方式更加简洁易用，建议使用现代方式。仅当图片非常复杂或不规则时，才推荐
使用常规方式。

子图布局
--------

:doc:`/module/subplot` 模块提供的子图模式可以非常方便地绘制多子图。

**subplot begin** 用于设计子图的布局、尺寸以及其它属性。其将整张画布划分为
N行M列的规则网格区域，每个网格区域内都可以包含一张独立的子图。例如::

    gmt subplot begin 2x3 -Fs5c/3c

定义了一个2行3列的子图布局。\ **-Fs5c/3c** 则指定了每个子图区域的宽度为5厘米，
高度为3厘米。相邻子图之间的间隔则可以用 **-M** 选项控制。
最终得到的子图布局如下图所示：

.. gmtplot::
    :show-code: false
    :width: 80%

    #!/usr/bin/env bash
    nrow=2
    ncol=3
    gmt begin subplot png,pdf
    gmt subplot begin ${nrow}x${ncol} -Fs5c/3c+d -Blrtb
        for index in $(seq 0 $((nrow*ncol-1))); do
        i=$((index/ncol))
        j=$((index%ncol))
        echo 0.5 0.5 '@;red;'$i,$j'@;;' '(@;blue;'$index'@;;)' | gmt text -R0/1/0/1 -F+f20p -c
        done
    gmt subplot end
    gmt end

**subplot set** 用于激活指定的子图，接下来的所有绘图命令都将在该子图内进行绘制。
为了指定某个子图，则需要知道每个子图的编号。GMT中可以通过 **行号,列号** 或者
**索引号** （即第几个子图）的方式来指定子图。

.. note::

    行号、列号和索引号，均从0开始起算。因而对于一个N行M列的子图布局而言，
    行号为0到N-1，列号为0到M-1，索引号为0到N*M-1。

上图中同样给出了每个子图的编号，图中红色数字为子图的行列号，而括号中的蓝色数字则
是子图的索引号。因而，你可以使用如下命令中的任意一个来激活第三个子图，接下来的所有
绘图命令均只在第三个子图内进行::

    gmt subplot set 1,0

    gmt subplot set 3

最后记得使用 **subplot end** 退出子图模式::

    gmt subplot end

第一张子图
----------

下面就利用上面学到的知识绘制一张2行2列的子图。

.. gmtplot::
    :width: 60%

    gmt begin map png,pdf
      gmt set FONT_TAG 15p FONT_HEADING 20p MAP_HEADING_OFFSET 0p
      gmt subplot begin 2x2 -Fs5c/3c -A -M0.2c/0.1c -T"My Subplot Heading"
        gmt subplot set 0
        gmt basemap -R0/10/0/10 -JX? -Baf -BWSen

        gmt subplot set 1
        gmt basemap -R0/20/0/10 -JX? -Baf -BWSen

        gmt subplot set 2
        gmt basemap -R0/10/0/20 -JX? -Baf -BWSen

        gmt subplot set 3
        gmt basemap -R0/20/0/20 -JX? -Baf -BWSen
      gmt subplot end
    gmt end

在这个例子中，我们用 **subplot begin** 定义了一个2行2列（\ **2x2**\ ）的子图布局，
每个子图区域宽5厘米高3厘米（\ **-Fs5c/3c**\ ）。除此之外，我们还使用了一些可选
选项对图的细节进行微调：

-   **-A**: 对每个子图进行自动编号abcd
-   **-M0.2c/0.1c**: 调整相邻子图之间的空白距离，X方向间隔为0.2厘米，Y方向间隔为0.1厘米
-   **-T"My Subplot Heading"**: 为整张图加上一个总标题
-   调整子图编号的大小（:ref:`FONT_TAG <FONT_TAG>`\ ）、总标题文字大小（:ref:`FONT_HEADING <FONT_HEADING>`\ ）
    以及总标题相对于底图的偏移量（:ref:`MAP_HEADING_OFFSET <MAP_HEADING_OFFSET>`\ ）

在子图模式内，我们使用 **subplot set 0** 的方式依次激活每个子图。在每个子图内绘图时，
我们使用了线性投影方式 **-JX?**\ 。通常我们需要指定图片的宽度或高度，这里我们使用了
**?** 让GMT根据子图区域的大小自动帮我们选择最合适的子图宽度。

.. tip::

    本示例中使用了如下命令来依次激活四个子图::

        gmt subplot set 0
        gmt subplot set 1
        gmt subplot set 2
        gmt subplot set 3

    实际上，我们可以直接使用 **subplot set** 而不指定子图编号，GMT会自动为我们
    激活“下一个”子图。

共用X/Y轴
---------

上面示例中的四张子图，每行的两张子图有相同的Y轴范围，每列的两张子图有相同的
X轴范围。此时可以使用 **-S** 选项设置各子图之间共用X或Y轴。

.. gmtplot::
    :width: 60%

    gmt begin map png,pdf
      gmt set FONT_TAG 15p FONT_HEADING 20p MAP_HEADING_OFFSET 10p
      gmt subplot begin 2x2 -Fs5c/3c -A -M0.2c/0.2c -T"My Subplot Heading" -SRl -SCb -BWSrt
        gmt basemap -R0/10/0/10 -JX? -c
        gmt basemap -R0/20/0/10 -JX? -c
        gmt basemap -R0/10/0/20 -JX? -c
        gmt basemap -R0/20/0/20 -JX? -c
      gmt subplot end
    gmt end

**-SRl** 表示一行内（\ **R**\ ow\ ）的子图共用Y轴，且只在左边（\ **l**\ ）轴显示标注，
**-SCb** 表示一列内（\ **C**\ olumn\ ）的子图共用X轴，且只在底部（\ **b**\ ）轴显示标注。

当然你也可以不使用 **-S** 选项，而是在每个子图中使用不同的 **-B** 选项分别
为每个子图设置不同的轴属性。

复杂布局
--------

**subplot** 目前尚不支持嵌套。如果想要使用更复杂的子图布局，则需要更多的人工调整。

下面的例子在一个2行2列的子图布局中绘制了三张子图，其中第一张子图占据了第一行。

.. gmtplot::
    :width: 75%

    gmt begin complex-subplot png,pdf
      gmt subplot begin 2x2 -Fs5c/3c -A
        gmt subplot set 0 -A'(a)'
        gmt basemap -R0/10/0/10 -JX11.75/3c -Baf -BWSen
        gmt subplot set 2 -A'(b)'
        gmt basemap -R0/5/0/5 -JX? -Baf -BWSen
        gmt subplot set 3 -A'(c)'
        gmt basemap -R0/5/0/5 -JX? -Baf -BWSen
      gmt subplot end
    gmt end

在绘制三个底图时，后两个底图均使用了 **-JX?**\ ，因而GMT会自动根据子图区域的
大小确定子图的尺寸；而为了使得第一张子图占据两个子图区域的空间，我们使用了
**-JX11.75c/3c** 来人工指定其子图宽度，其中子图宽度11.75厘米是需要人工调整的。

由于我们跳过了第二个子图区域，自动标签功能会将三个子图依次编号为a、c、d，
这显然不是我们想要的，因而我们使用了 **-A'(a)'** 选项手动设置子图编号。
需要注意的是，由于小括号在Bash中有特殊含义，所以这里 **(a)** 两边加了
单引号以避免Bash对小括号进行解释。
