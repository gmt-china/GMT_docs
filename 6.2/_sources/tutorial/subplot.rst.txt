GMT 子图模式
============

有些时候，尤其是发表文章时，需要将多张独立的图放在一张图中，并编号 abcd，
一般称这些独立的图为子图。

GMT 中有两种方式可以绘制多子图：

- 常规方式：在绘图时使用 :doc:`/option/XY` 手动移动每个子图的原点
- 现代方式：使用 :doc:`/module/subplot` 模块提供的子图模式来布局和管理多子图

现代方式更加简洁易用，建议使用现代方式。仅当图片非常复杂或不规则时，才推荐
使用常规方式。

子图布局
--------

:doc:`/module/subplot` 模块提供的子图模式可以非常方便地绘制多子图。

**subplot begin** 用于设计子图的布局、尺寸以及其它属性。其将整张画布划分为
N 行 M 列的规则网格区域，每个网格区域内都可以包含一张独立的子图。例如::

    gmt subplot begin 2x3 -Fs5c/3c

定义了一个 2 行 3 列的子图布局，注意中间为小写英文字母 **x**，
不是星号或其他符号。**-Fs5c/3c** 则指定了每个子图区域的宽度为 5 厘米，
高度为 3 厘米。相邻子图之间的间隔则可以用 **-M** 选项控制。
最终得到的子图布局如下图所示：

.. gmtplot::
    :show-code: false
    :width: 80%

    #!/usr/bin/env bash
    nrow=2
    ncol=3
    gmt begin subplot png,pdf
    gmt subplot begin ${nrow}x${ncol} -Fs5c/3c -Blrtb
        for index in $(seq 0 $((nrow*ncol-1))); do
        i=$((index/ncol))
        j=$((index%ncol))
        echo 0.5 0.5 '@;red;'$i,$j'@;;' '(@;blue;'$index'@;;)' | gmt text -R0/1/0/1 -F+f20p -c
        done
    gmt subplot end
    gmt end show

**subplot set** 用于激活指定的子图，接下来的所有绘图命令都将在该子图内进行绘制。
为了指定某个子图，则需要知道每个子图的编号。GMT 中可以通过 **行号,列号** 或者
**索引号**\ （即第几个子图）的方式来指定子图。

.. note::

    行号、列号和索引号，均从 0 开始起算。因而对于一个 N 行 M 列的子图布局而言，
    行号为 0 到 N-1，列号为 0 到 M-1，索引号为 0 到 N*M-1。

上图中同样给出了每个子图的编号，图中红色数字为子图的行列号，而括号中的蓝色数字则
是子图的索引号。因而，你可以使用如下命令中的任意一个来激活第三个子图，接下来的所有
绘图命令均只在第三个子图内进行::

    gmt subplot set 1,0

    gmt subplot set 3

最后记得使用 **subplot end** 退出子图模式::

    gmt subplot end

第一张子图
----------

下面就利用上面学到的知识绘制一张 2 行 2 列的子图。

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
    gmt end show

在这个例子中，我们用 **subplot begin** 定义了一个 2 行 2 列（**2x2**）的子图布局，
每个子图区域宽 5 厘米高 3 厘米（**-Fs5c/3c**）。除此之外，我们还使用了一些可选
选项对图的细节进行微调：

-   **-A**: 对每个子图进行自动编号 abcd
-   **-M0.2c/0.1c**: 调整相邻子图之间的空白距离，X 方向间隔为 0.2 厘米，Y 方向间隔为 0.1 厘米
-   **-T"My Subplot Heading"**: 为整张图加上一个总标题
-   调整子图编号的大小（:term:`FONT_TAG`）、总标题文字大小（:term:`FONT_HEADING`）
    以及总标题相对于底图的偏移量（:term:`MAP_HEADING_OFFSET`）

在子图模式内，我们使用 **subplot set 0** 的方式依次激活每个子图。在每个子图内绘图时，
我们使用了线性投影方式 **-JX?**。通常我们需要指定图片的宽度或高度，这里我们使用了
**?** 让 GMT 根据子图区域的大小自动帮我们选择最合适的子图宽度。

.. tip::

    本示例中使用了如下命令来依次激活四个子图::

        gmt subplot set 0
        gmt subplot set 1
        gmt subplot set 2
        gmt subplot set 3

    实际上，我们可以直接使用 **subplot set** 而不指定子图编号，GMT 会自动为我们
    激活 “下一个” 子图。

共用 X/Y 轴
-----------

上面示例中的四张子图，每行的两张子图有相同的 Y 轴范围，每列的两张子图有相同的
X 轴范围。此时可以使用 **-S** 选项设置各子图之间共用 X 或 Y 轴。

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
    gmt end show

**-SRl** 表示一行内（**R**\ ow\ ）的子图共用 Y 轴，且只在左边（**l**）轴显示标注，
**-SCb** 表示一列内（**C**\ olumn\ ）的子图共用 X 轴，且只在底部（**b**）轴显示标注。

当然你也可以不使用 **-S** 选项，而是在每个子图中使用不同的 **-B** 选项分别
为每个子图设置不同的轴属性。

复杂布局
--------

**subplot** 目前尚不支持嵌套。如果想要使用更复杂的子图布局，可以多次调用 **subplot**
并进行人工的调整。

下面的示例中线绘制了一个一行两列的子图布局，然后在其上方绘制了一个等宽的一行
一列的子图布局。

.. gmtplot::
    :width: 75%

    gmt begin complex-subplot png,pdf
      gmt subplot begin 1x2 -Ff15c/3c -A -BWSen
        gmt subplot set 0 -A'(b)'
        gmt basemap -R0/10/0/10 -JX?
        gmt subplot set 1 -A'(c)'
        gmt basemap -R0/10/0/10 -JX?
      gmt subplot end

      gmt subplot begin 1x1 -Ff15c/3c -A -Yh+1c
        gmt subplot set 0 -A'(a)'
        gmt basemap -R0/10/0/10 -JX? -BWSen -Bxa2f1 -Bya2f1
      gmt subplot end
    gmt end show

.. note::

    小括号 :kbd:`()` 在 Bash 中有特殊含义，所以子图标签 **(a)** 两边加了单引号，
    避免 Bash 对小括号进行解释。
    编写 Batch 脚本的 Windows 用户不可以使用单引号，但是可以使用双引号，或者不使用引号。
