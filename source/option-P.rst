``-P`` 选项
===========

在 :doc:`paper` 一节中说过，画布有两种放置方式：Portrait模式和Landscape模式。

.. figure:: /images/GMT_-P.*
   :width: 500px
   :align: center

   ``-P`` 选项指定画布方向

由于历史原因，GMT默认使用Landscape模式，可以通过 ``-P`` 选项设定使用Portrait模式，也可以通过设置GMT参数 :ref:`PS_PAGE_ORIENTATION <PS_PAGE_ORIENTATION>` 来修改纸张方向。

``-P`` 选项设置的是\ **画布的属性**\ ，对于由多个命令绘制而成的图片来说，只有第一个命令的 ``-P`` 选项是有效的。因而其他绘图命令中使用或不使用 ``-P`` 选项，不会影响绘图效果。

Linux下默认的PS阅读器evince可以自动识别两种模式，Landscape模式的PS文件横着放，Portrait模式的文件竖着放，所以看上去总是对的。而 ``gs`` 无法自动识别两种模式，总是将文件竖着放，因而用gs看Landscape模式的PS文件时就会很别扭。

以下是进阶内容，仅供高级用户阅读。

将一个Landscape模式的PS文件与一个Portait模式的PS文件对比::

    $ gmt psbasemap -R0/10/0/10 -JX10c/10c -B1 > 01.ps
    $ gmt psbasemap -R0/10/0/10 -JX10c/10c -B1 -P > 02.ps

两个文件的差异如下::

    $ diff 01.ps 02.ps
    11c11
    < %%Orientation: Landscape
    ---
    > %%Orientation: Portrait
    658c658
    < V 595 0 T 90 R 0.06 0.06 scale
    ---
    > V 0.06 0.06 scale
    661,662c661,662
    < /PSL_page_xsize 14033 def
    < /PSL_page_ysize 9917 def
    ---
    > /PSL_page_xsize 9917 def
    > /PSL_page_ysize 14033 def
    669c669
    < %%GMT: psbasemap -R0/10/0/10 -JX10c/10c -B1
    ---
    > %%GMT: psbasemap -R0/10/0/10 -JX10c/10c -B1 -P

可以发现，两个PS文件的差异主要在于 ``595 0 T 90 R`` 以及交换了 ``PSL_page_xsize`` 和 ``PSL_page_ysize`` 的值。 ``595 0 T 90 R`` 的含义应该是将坐标系移动（ **T**\ ransition）到 ``(595,0)`` 再旋转（ **R**\ otate）90度，即由Portrait模式变成Landscape模式。
