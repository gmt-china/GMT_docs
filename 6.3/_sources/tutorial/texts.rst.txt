添加文字
========

GMT 的 :doc:`/module/text` 模块可以用于添加文字。

最简单的示例
------------

若需要添加文字，则输入数据中必须给出文字的 X 和 Y 坐标以及具体的文字。
因而，输入数据有三列::

    X   Y   text

下面的示例首先用 **basemap** 模块绘制了一张底图，然后使用 **text** 模块
在底图的不同位置添加了文字。

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text << EOF
    5 1 GMT TEXT1
    5 3 GMT TEXT2
    5 5 GMT TEXT3
    EOF
    gmt end show

文字属性
--------

当然，我们可以为文字设置更丰富的属性，比如文字大小、字体、文字颜色以及文字旋转角度等。
这可以通过 **-F** 选项来实现。

**-F+f**\ *font* 可以设置文字的属性，包括文字大小、字体和颜色，三者之间用逗号分隔。
**-F+a** 则可以设置文字的旋转角度。

.. note::

    GMT 默认支持 35 种字体，可以使用 ``gmt text -L`` 查看 GMT 支持的字体名及其对应的字体编号。

下面的示例中，**-F+f16p,1,red+a30** 即表示文字大小为 16p，字体为 1 号字体，颜色为红色，
文字旋转角度为 30 度。

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text -F+f16p,1,red+a30 << EOF
    5 1 GMT TEXT1
    5 3 GMT TEXT2
    5 5 GMT TEXT3
    EOF
    gmt end show

文本框
------

对于每个文本字符串，我们还可以为其加上文本框。

- **-W** 选项控制文本框的画笔属性
- **-G** 选项控制文本框的填充色
- **-C** 选项控制文字与文本框之间的空白

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text -F+f16p,1,red+a30 -W1p -Glightblue -C25%/25% << EOF
    5 1 GMT TEXT1
    5 3 GMT TEXT2
    5 5 GMT TEXT3
    EOF
    gmt end show

对齐方式
--------

对于任意一个文本，我们还可以设置其对齐方式与偏移量。GMT 中文本的默认对齐方式
为居中对齐，即将整个文本的中心放在指定的 X 和 Y 坐标处。当然，用户也可以自行指定
文本的对齐方式。

文本的对齐方式由水平对齐方式和垂直对齐方式共同决定。水平对齐方式有三种：
左对齐（**L**\ eft）、居中对齐（**C**\ enter）和右对齐（**R**\ ight）。
垂直对齐方式有三种：顶部对齐（**T**\ op）、居中对齐（**M**\ iddle）和
底部对齐（**B**\ ottom）。三种水平对齐方式和三种垂直对齐方式，构成了文本的 9 种
对齐方式。

**-F+j** 用于指定文本对齐方式。下面的示例中，**-F+jTL** 表示文本对齐方式
为 **TL**\ （Top + Left），即表示以左上角方式对齐。从下图中可以看到，三个
文本框的左上角被放在了 (5,1)、(5,3) 和 (5,5) 处。

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text -F+f16p,1,red+jTL -W1p << EOF
    5 1 GMT TEXT1
    5 3 GMT TEXT2
    5 5 GMT TEXT3
    EOF
    gmt end show

文本偏移量
----------

使用 **-D** 选项还可以对文本设置额外的偏移量。下面的示例中，
**-D0.5c/0.5c** 分别设置了文本在 X 方向和 Y 方向的偏移量。

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text -F+f16p,1,red+jTL -D0.5c/0.5c -W1p << EOF
    5 1 GMT TEXT1
    5 3 GMT TEXT2
    5 5 GMT TEXT3
    EOF
    gmt end show

变化的文字属性
--------------

如果想要不同的文字有不同的文本属性，可以多次调用 **text** 模块，每次设置不同的
文本属性。当然，还有更加灵活的办法，可以一个命令中实现变化的文字属性。

下面的例子中，使用了 **-F+f+a+j** 选项。上面已经介绍到，**+f** 设置文本属性，
**+a** 设置文本旋转角度，**+j** 设置文本对齐方式。但我们并没有指定具体的属性
值，因而需要在输入数据中增加额外的数据列。输入数据的格式由 **+f**、**+a**\ 和
**+j** 的顺序决定，因而此时输入数据的格式为::

    X   Y   font    angle   justification   text

下面的示例中，第三列为字体属性，第四列为文本旋转角度，第五列为文本对齐方式。

.. gmtplot::
    :width: 60%

    gmt begin map
    gmt basemap -R0/10/0/6 -JX10c/6c -Bafg1 -BWSen
    gmt text -F+f+a+j -W1p -Glightblue << EOF
    5 1 12p,0,red       0   TL GMT TEXT1
    5 3 15p,1,blue      30  MC GMT TEXT2
    5 5 18p,2,yellow    180 TL GMT TEXT3
    EOF
    gmt end show
