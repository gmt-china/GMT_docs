.. index:: ! postscript

PostScript
==========

GMT生成的图片为PS格式，全称是PostScript。这一节将简单介绍一下PS语言与PS格式。

PS是什么
--------

PostScript是一种用于描述\ **矢量图形**\ 的页面描述语言。简单的说，用PostScript
语言写成的文件就是PS格式的图片，一般文件后缀用 ``ps``\ ，简称为PS文件。

提到格式，很多人都会有畏惧感，总觉得格式是个很复杂的东西。其实，格式不过是一种
定义，定义了将信息以何种方式保存到文件中，那些用于打开某种格式的软件，只不过
恰好知道了格式的定义，并且根据定义将文件中的信息提取出来，然后呈现给用户，
仅此而已。比如 ``doc``\ ，用MS Word可以打开，用WPS也可以打开，如果你愿意，
你也可以自己读 ``doc`` 的格式定义，自己写代码读取 ``doc`` 格式的文件。

下面教你怎样从零创建一个PS格式的文件，以消除对PS格式的陌生感。

#. 首先打开你最常用的一款\ **文本编辑器**\ （比如 ``vim`` 、 ``gedit`` 或 ``notepad++`` ），
   新建一个空白文件；
#. 将如下内容复制到该空白文件中:

   .. code-block:: postscript

      %! PS-Adobe-3.0
      /Helvetica findfont 20 scalefont setfont
      150 400 moveto
      (PostScript is not that hard!) show

      showpage
      %%Trailer
      %%EOF

#. 将该文件以文件名 ``simple.ps`` 保存
#. Linux下用命令 ``gs simple.ps`` 查看该文件；Windows下应该直接双击就可以看到

解释一下这个文件:

- ``%! PS-Adobe-3.0`` 表明该文件是PostScript格式，且是PS3.0版
- ``Helvetica`` 是PS内置的一种字体，\ ``findfont`` 命令用于寻找、缩放、设置字体
- ``150 400 moveto`` 将坐标原点移动到某位置
- ``(text) show`` 用于显示文字
- ``showpage`` 表示显示该页

是不是很简单？GMT的绘图模块本质上就是生成一堆PS代码，只要把这些PS代码按照一定的
规则保存到纯文本文件中，即可用PS阅读器查看绘图效果。

PS的优点
--------

GMT所有的绘图模块都只能生成PS代码，将这些PS代码保存到PS文件中即可完成绘图。

不管当初GMT是以什么理由选择PS作为图像格式的，就今天来看，PS文件具有如下优势：

1. 矢量图形格式

   PS是矢量图形格式，即用点、直线或多边形等数学方程的几何元素来表示图像。因而
   可以任意旋转与缩放而不是出现图像失真。

2. 易于转换为其他格式

   GMT提供了 ``psconvert`` 模块，可以很方便地将PS文件以任意精度转换为jpeg、
   png、eps、pdf等图片格式，以满足不同情形下的需求。

PS阅读器
--------

PS阅读器，或称PS解释器，是用于查看PS文件的软件。

- `ghostscript <http://ghostscript.com/>`_
- `gsview <http://www.gsview.com/>`_
- `evince <https://wiki.gnome.org/Apps/Evince>`_
- `zathura <https://pwmt.org/projects/zathura/>`_ (Linux only)
- `SumatraPDF <http://www.sumatrapdfreader.org/free-pdf-reader.html>`_ (Windows only)

将PS转换为其他格式
------------------

GMT提供了 ``psconvert`` 模块，可以很方便地将PS文件以任意精度转换为jpeg、png、eps、
pdf等图片格式，以满足不同情形下的需求。

比如，将 PS 文件转化为 JPG 文件::

    gmt psconvert test.ps

转换为 JPG 格式的过程中对其进行裁剪并旋转::

    gmt psconvert -A -P test.ps

转化为 PDF 格式::

    gmt psconvert -Tf -A -P test.ps
