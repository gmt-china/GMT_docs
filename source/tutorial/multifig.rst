GMT多图模式
===========

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

