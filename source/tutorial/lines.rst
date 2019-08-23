绘制线段和多边形
================

.. include:: notes.rst_

绘制线条和多边形是日常绘图最常见的需求之一，也是所有绘图软件必备的功能。
这一节我们将学习如何使用 GMT 的 :doc:`/module/plot` 模块绘制线段和多边形。

绘制一条线段
------------

既然是要绘制一条线段，我们就必须提供线段上数据点的信息，即数据的X坐标和Y坐标。
因而我们的输入数据中需要有两列，第一列为X坐标，第二列为Y坐标。

以下面的数据为例，这个数据中包含了三个坐标点的信息::

    2   2
    8   2
    5   7

为了利用这三个数据点绘制一条线段，我们将数据保存到文件名为 :file:`lines-1.dat` 的文件中，
供下面的GMT脚本使用。

下面的例子中，我们使用 **basemap** 模块绘制了一张底图，并使用 **plot** 模块绘制
输入文件 :file:`lines-1.dat` 中的数据。

图中，\ **plot** 模块在绘图时自动将三个点连接起来，绘制出了一条线段。

.. gmtplot::
    :width: 50%

    gmt begin SimpleLine png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-1.dat
    gmt end

想要修改线段的粗细或颜色？很简单，可以使用 **plot** 模块的 **-W** 选项设置画笔属性。
画笔属性包括三个部分：线宽、颜色以及线型，三者之间用逗号隔开。

下面的脚本中，我们给 **plot** 模块添加了 **-W2p,red,-** 选项，
设置了画笔属性为 **2p** 宽的红色虚线。\ **p** 是GMT中的一个长度单位。

.. gmtplot::
    :width: 50%

    gmt begin SimpleLine png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-1.dat -W2p,red,-
    gmt end

你可以尝试修改线宽、颜色和线型，并查看绘图效果。几种常见的线型包括 
``-``\ 、\ ``.``\ 、\ ``.-``\ 和 \ ``-.``\ 。

绘制一个多边形
--------------

**plot** 在绘制线段时默认是不将线段首尾连接起来的，
可以使用 **-L** 选项将线段的首尾连接起来，构成了一个闭合多边形。

.. gmtplot::
    :width: 50%

    gmt begin polygon png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-1.dat -W4p,lightblue -L
    gmt end

我们还可以使用 **-G** 选项为闭合多边形填充颜色。

.. gmtplot::
    :width: 50%

    gmt begin polygon png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-1.dat -W4p,lightblue -Glightred -L
    gmt end

这样我们就得到了一个内部为浅红色、轮廓为浅蓝色的多边形了。如果只想要填充颜色而不绘制轮廓，
只需要使用 **-G** 而不使用 **-W** 即可。

.. gmtplot::
    :width: 50%

    gmt begin polygon png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-1.dat -Glightred -L
    gmt end

绘制多条线段
------------

学会了如何绘制一条线段，我们就可以通过多次调用 **plot** 模块来绘制多条线段了。
但是，如果画几十条线段就需要写几十行 **plot** 命令并准确几十个输入
文件了，这样太麻烦也太不切实际了。

实际上，我们可以将所有线段的数据点都保存到一个输入文件中，例如::

    > 
    1 	2
    4 	2
    4 	8
    >
    9	2 
    6 	2
    6	8

每个线段都包含了三个数据点，在第一个数据点之前有一个 **>** 用于标记新的一段数据的开始。
这种数据称之为\ **多段数据**\ 。我们将上面的数据保存到文件 :file:`lines-2.dat` 中，
供下面的脚本使用。

与绘制一条线段的命令完全相同，由于输入数据中有两段数据，\ **plot** 模块为我们绘制出了
两条线段。同样的，两条线段均为线宽为 **1p** 的红色实线。

.. gmtplot::
    :width: 50%

    gmt begin MultiLines png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-2.dat -W1p,red 
    gmt end

绘制多个多边形
--------------

使用相同的输入数据，通过加上 **-L** 可以构成闭合多边形，加上 **-G** 为多边形设置填充色。

.. gmtplot::
    :width: 50%

    gmt begin MultiPolygons png,pdf
    gmt basemap -JX10c -R0/10/0/10 -Baf
    gmt plot lines-2.dat -W1p,red -L -Glightred
    gmt end

大圆弧路径
----------

在笛卡尔坐标系下，绘制线段时，任意两点之间会以直线方式连接；
而在地理投影下，任意两点之间则使用大圆弧路径方法会连接。
如果想要在地理投影下也是要直线连接两点，则需要使用 **-A** 选项设置画笔属性。

下面的命令中，我们首先使用 **coast** 绘制了一张全球地图，接着使用 **plot** 模块
绘制了地球上两点之间的连线（红色，以大圆弧路径方式连接），然后，
我们加上了 **-A** 选项再次绘制了这两点之间的连线（蓝色，以直线方式连接）。

.. gmtplot::
    :width: 80%

    cat > twopoints.dat << EOF
    115		30
    250 	30
    EOF

    gmt begin map png,pdf
    gmt coast -JH180/12c -Rg -B0 -W0.5p -A10000
    gmt plot twopoints.dat -W2p,red 
    gmt plot twopoints.dat -W2p,blue -A
    gmt end

