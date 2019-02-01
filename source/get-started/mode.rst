绘图模式
========

GMT自6.0.0版本开始，引入了一种全新的绘图命令执行模式，称之为现代模式。
而GMT5以及之前的命令风格则称之为经典模式。GMT6既支持经典模式也支持现代模式，
因而GMT6可以完全兼容GMT5的代码。

现代模式与经典模式可以完成相同的绘图功能，但现代模式大大简化了绘图代码，
因而推荐使用现代模式而非经典模式。

本手册将只使用现代模式，而不介绍经典模式。对于GMT新用户而言，只需要了解现代
模式即可；而对于GMT老用户，建议阅读 :doc:`现代模式与经典模式的差异 </appendix/modes-difference>`
并开始使用现代模式进行绘图。

基本用法
--------

现代模式下，GMT用 :doc:`/module/begin` 开始一个绘图，并用 :doc:`/module/end` 结束一个绘图，
所有的绘图命令均放在二者之间。其基本用法如下::

    gmt begin <figname> <formats>
    gmt commands ...
    gmt end

其中 ``<figname>`` 指定了要生成的图片名，\ ``<formats>`` 则指定了图片的格式。
这二者都是可选的，默认的文件名为 ``gmtsession``\ ，默认的图片格式为PDF格式。

例如::

    gmt begin map pdf,png
    gmt basemap -JX10c/10c -R0/10/0/10 -Baf
    gmt end

会绘制一张底图，并保存为PDF和PNG格式的图片 ``map.pdf`` 和 ``map.png``\ 。

单行模式
--------

以上面的示例为例，真正的绘图命令只有一个，而写的时候却需要写三行命令，未免
有些麻烦。针对这种情况，GMT提供了单行模式的命令，即当绘图脚本只有一个命令即可
绘制完成时，可以省略 ``gmt begin`` 和 ``gmt end``\ ，只需要在绘图命令后加上
``-<format> <figname>`` 即可。

例如，上面的命令可以简化为单行模式::

    gmt basemap -JX10c/10c -R0/10/0/10 -Baf -pdf map

当然，单行模式的应用场景有限，且只能生成一种格式的图片。

多图模式
--------

多图模式，允许用户可以同时画多张图，并在绘图过程中，随意切换到任意一张图。
多图模式可以通过 :doc:`/module/figure` 模块实现，其语法为::

    gmt figure <figname> <formats> <options>

该模块的语法与 ``gmt begin`` 语法类似，具体见模块的说明文档 :doc:`/module/figure`\ 。
其用于指定图件的名称及格式，以及图片格式转换过程中的细节选项，并且可以用于
在多个子图之间切换。

下面的示例，使用多图模式在一个脚本中同时绘制了两张图，并在两张图中不断切换::

    # 开始绘图
    gmt begin

    # 在 Fig1 中绘制底图
    gmt figure Fig1 png
    gmt basemap -R0/10/0/10 -JX10c -Baf

    # 在 Fig2 中绘制底图
    gmt figure Fig2 png
    gmt basemap -R0/5/0/5 -JX10c -Baf

    # 切换回 Fig1，并绘制圆圈
    gmt figure Fig1
    echo 5 5 | gmt plot -Sc1c -W2p

    # 切换回 Fig2，并绘制三角形
    gmt figure Fig2
    echo 1 2 | gmt plot -St1c -W1p

    # 结束绘图
    gmt end

子图模式
--------

有些时候需要把多张图放在一张图中，最直接的做法是分别绘制不同的图，然后
通过移动各个图的绘图原点，将多张图拼接成一张图。

针对这种需求，GMT的 :doc:`/module/subplot` 模块提供了子图模式。
子图模式的基本思想是将整体绘图区域分割成M行N列的网格，每个网格区域内均可以
绘制一张子图。子图模式主要适用于子图具有相似的底图的情况，若子图的底图差异
太大，配置和微调子图还是有些麻烦。

子图模式的特色在于：

- 自动控制每个子图的位置而无需用户自己移动坐标原点；
- 自动为每个子图编号；
- 每张子图可以有各自的子图标题，整张图也可以有自己的标题；
- 多张子图可以共享X轴或Y轴

子图模式的选项比较多，此处仅举一个示例，详细用法见 :doc:`/module/subplot` 的
说明文档。本示例中整张图片包含了2行3列共计6个子图，且每列的两张子图共享X轴，
每列的子图共享Y轴。

.. gmt-plot::
    :language: bash

    gmt begin subplot-example png,pdf
    gmt subplot begin 2x3 -Fs4c/4c -A'(a)' -M5p/10p -BWsrt -SCb -SRl -T"Subplot Example"
        gmt subplot set 1,1
        gmt basemap -R0/80/0/10

        gmt subplot set 1,2
        gmt basemap -R0/50/0/10

        gmt subplot set 1,3
        gmt basemap -R0/20/0/10

        gmt subplot set 2,1
        gmt basemap -R0/80/0/20

        gmt subplot set 2,2
        gmt basemap -R0/50/0/20

        gmt subplot set 2,3
        gmt basemap -R0/20/0/20
    gmt subplot end
    gmt end



图中图模式
--------

在绘制研究区域的地图时，有时研究区域的范围比较小。在这种情况下，为了更好地显示
研究区域的具体地理位置，通过会绘制一个更大区域的地图，并在大区域地图中框出研究
区域的位置，这种图件称之为 inset map，中文没有统一的翻译，通常称之为图中图或者
图中图。图中图模式可以通过模块 :doc:`/module/inset` 实现。

``inset begin`` 用于进入图中图模式，其作用是在图纸上标记出一个矩形区域，并将绘图
原点移动到该矩形区域的左下角，接下来的所有绘图命令均只在该图中图区域内操作，
而 ``gmt end`` 则用于退出图中图模式，并将坐标原点移动回原大图中。

下面仅展示一个简单的示例：

.. gmt-plot::

    gmt begin inset png
        gmt basemap -R0/40/40/60 -JM6.5i -Bafg -B+glightgreen

        # 图中图模式
        gmt inset begin -DjTR+w2.5i+o0.2i -F+gpink+p0.5p -M0.1i
            gmt basemap -Rg -JA20/20/2.3i -Bafg
            echo INSET | gmt text -F+f12p+cTR
        gmt inset end

        echo MAP | gmt text -F+f18p+cBL -Dj0.2i
    gmt end
