添加图例
========

绘制了线条与符号后，通常还需要添加图例，以解释不同数据的含义。
GMT 中使用 :doc:`/module/legend` 模块添加图例。

自动图例
--------

在使用 :doc:`/module/plot` 模块绘制线条或符号时，可以额外加上 **-l**\ *label*
选项以指定当前线段或符号的图例标签。

下面的示例中，我们利用前面学到的知识绘制了线段和两种符号，同时使用了 **-l**
选项为线段和符号均添加了标签。在绘图结束时，GMT 会自动根据命令中提供的信息
在右上角绘制了图例。

.. gmtplot::
    :width: 50%

    gmt begin auto-legend
    gmt basemap -R0/10/0/10 -JX10c -Baf
    gmt plot -W1p,blue -l"Profile" << EOF
    3 3
    6 8
    EOF
    gmt plot -Gred -Sa0.3c -W0.5p -l"Event" << EOF
    5  5
    EOF
    gmt plot -Gblue -St0.3c -W0.5p -l"Station" << EOF
    2 3
    4 6
    8 5
    EOF
    gmt end show

还可以为 **-l** 选项加上其它子选项以控制图例的位置、大小以及其它显示效果，
在本教程中不再赘述。

设置图例属性
------------

GMT 使用 **legend** 模块添加图例。上面的示例中我们并没有调用 **legend** 模块，
而是 GMT 在绘图结束时自动调用了 **legend** 添加图例。我们也可以显式调用
**legend** 模块，并设置图例的更多属性。

.. gmtplot::
    :width: 50%

    gmt begin auto-legend
    gmt basemap -R0/10/0/10 -JX10c -Baf
    gmt plot -W1p,blue -l"Profile" << EOF
    3 3
    6 8
    EOF
    gmt plot -Gred -Sa0.3c -W0.5p -l"Event" << EOF
    5  5
    EOF
    gmt plot -Gblue -St0.3c -W0.5p -l"Station" << EOF
    2 3
    4 6
    8 5
    EOF
    gmt legend -DjBR+o0.1c/0.1c -F+p1p+glightblue
    gmt end show

这个示例中，我们显式调用了 **legend** 选项，并设置了 **-D** 和 **-F** 选项。

- **jBR** 表示将图例放在底图的右下角（BottomRight）
- **+o0.1c/0.1c** 表示将图例在右下角的基础上再加上额外的偏移量
- **-F+p1p+glightblue** 则设置了图例框的轮廓和填充色

手动设置图例
------------

如果对于自动生成的图例不满意，还可以使用 :doc:`/module/legend` 模块绘制更复杂的图例，
其输入文件有自己的一套规则，详情见 :doc:`/module/legend` 模块的说明文档。
这节只介绍最简单也最常用的图例，即符号和线条的图例。
针对绘制符号和线条，:doc:`/module/legend` 的输入格式为：

    **S** *dx1* *symbol* *size* *fill* *pen* *dx2* *text*

- **S** 表明这一行用于绘制符号或线段。
- *dx1* 是符号或线段与图例左边框的距离
- *symbol* 是要绘制的符号类型代码；若想要绘制线段，则设置 *symbol* 为 **-**
- *size* 符号尺寸或线段长度
- *fill* 符号填充色；若不需要填充色，则可设置为 **-**
- *pen* 符号轮廓的画笔颜色；若不需要绘制符号轮廓，则可设置为 **-**
- *text* 符号对应的文字说明
- *dx2* 文字与左边框之间的距离

下面的示例中，我们绘制了四种符号，以及线段、矢量线和断层线。

.. gmtplot::
    :width: 70%

	gmt begin map
	gmt basemap -R0/10/0/8 -JX10c/8c -Baf -BWSen
	cat > legend.txt << EOF
	# symbols
	S 0.25c c 0.3c -      0.25p,blue 0.8c circle
	S 0.25c t 0.3c cyan   0.25p      0.8c triangle
	S 0.25c i 0.3c blue   0.25p,red  0.8c triangle2
	S 0.25c e 0.3c yellow 0.25p      0.8c ellipse
	# lines
	S 0.25c - 0.5c - 0.25p 0.8c line
	S 0.25c - 0.5c - 0.25p,- 0.8c dashline
	S 0.25c v0.1i+a40+e 0.25i magenta 0.25p 0.8c vector
	S 0.25c f0.1i+l+t 0.25i blue 0.25p 0.8c fault
	EOF
	gmt legend legend.txt -DjBR+w2.8c+o0.1c/0.1c -F+p1p+glightblue
	gmt end show
