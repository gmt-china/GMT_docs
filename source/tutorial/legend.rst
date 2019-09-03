添加图例
========

在图中画了很多线条和符号之后，通常还需要添加一个图例。GMT中使用 :doc:`/module/legend`
模块添加图例。

**legend** 模块支持绘制很复杂的图例，其输入文件有自己的一套规则，
详情见 **legend** 模块的说明文档。这节只介绍最简单也最常用的图例，即符号和
线条的图例。针对绘制符号和线条，\ **legend** 的输入格式为：

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

	gmt begin map png,pdf
	gmt basemap -R0/10/0/8 -JX10c/8c -Baf -BWSen
	gmt legend -DjBR+w2.8c+o0.1c/0.1c -F+p1p+glightblue << EOF
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
	gmt end

我们可以通过修改 **-D** 和 **-F** 进一步修改图例的位置和属性。
上面的例子中，

- **jBR** 表示将图例放在底图的右下角（BottomRight）
- **+o0.1c/0.1c** 表示将图例在右下角的基础上再加上额外的偏移量
- **+w2.8c** 设置了图例框的宽度
- **-F+p1p+glightblue** 则设置了图例框的轮廓和填充色
