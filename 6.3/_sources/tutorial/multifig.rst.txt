GMT 多图模式
============

如果你想要在一个脚本中同时绘制多张图，并且想要在多张图之间来回切换，则需要使用
:doc:`/module/figure` 模块。

:doc:`/module/figure` 的用法与 :doc:`/module/begin` 相同，唯一的区别在于，
你可以在 **gmt begin** 和 **gmt end** 中多次使用 **gmt figure** 来创建新图，
或激活已有的图。

下面的示例中，我们使用 **figure** 模块在一个脚本中指定了两张图，并不断在
两张图之间来回切换::

    gmt begin
        # Create Fig1 and plot a base map in Fig1
        gmt figure Fig1 png
        gmt basemap -R0/10/0/10 -JX10c -Baf

        # Create Fig2 and plot a base map in Fig2
        gmt figure Fig2 png
        gmt basemap -R0/5/0/5 -JX10c -Baf

        # Switch back to Fig1 and plot a circle
        gmt figure Fig1
        echo 5 5 | gmt plot -Sc1c -W2p

        # Switch back to Fig2 and plot a triangle
        gmt figure Fig2
        echo 1 2 | gmt plot -St1c -W1p
    gmt end show

最终会生成两张图，第一张图中在底图中绘制了圆圈，第二张图中则在底图中绘制了三角形。
