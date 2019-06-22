绘制线条
========

:doc:`/module/plot` 模块可以在图上绘制线段、多边形、符号。

本节主要展示如何绘制线段，线段之间如何连接，以及如何利用CPT文件绘制不同颜色的线段。

简单线段
--------

``-W`` 选项可以用于设置线段属性。以下示例 ``-W2p,blue`` 表示设置线段粗细为2p、颜色为蓝色：

.. gmtplot::
   :language: bash
   :caption: 简单线段示例

   gmt plot -JX16c/9c -R0/8/0/5 -B1 -W2p,blue -png lineSimp << EOF
   >
   1 2
   2 1
   3 4
   5 4
   >
   4 2
   5 3
   5 1
   7 3
   EOF

不同连接方式的线段
------------------

``-A[m|p|x|y]`` 可以进一步设置两点间的连接方式。

在地理坐标下，两点之间默认沿着大圆弧路径连接。下面的示例中：

- 未使用 ``-A`` 表示两点之间默认沿着大圆弧路径连接，图中黑线效果。
- ``-A`` 表示忽略当前的投影方式，直接用直线连接两点，图中红线效果。
- ``-Am`` 先沿着经线画，再沿着纬线画，图中绿线效果。
- ``-Ap`` 先沿着纬线画，再沿着经线画，图中蓝线效果。

.. gmtplot::
   :language: bash
   :caption: 地理坐标下不同连接方式的线段

   cat > input.dat << EOF
   160 10
   20 70
   EOF
   gmt begin lineGeo png,pdf
   gmt basemap -JN90/10c -R0/180/0/90 -Bx60 -By30
   gmt plot input.dat -W1p
   gmt plot input.dat -W1p,red -A
   gmt plot input.dat -W1p,green -Am
   gmt plot input.dat -W1p,blue -Ap
   gmt end

在笛卡尔坐标下，两点之间默认用直线连接。下面的示例中：

- 未使用 ``-A`` 表示两点之间默认用直线连接，图中黑线效果。
- ``-Ax`` 表示先沿着X轴画，再沿着Y轴画，图中绿线效果。
- ``-Ay`` 表示先沿着Y轴画，再沿着X轴画，图中蓝线效果。

.. gmtplot::
   :language: bash
   :caption: 笛卡尔坐标下不同连接方式的线段

   cat > input.dat << EOF
   160 10
   20 70
   EOF
   gmt begin lineCart png,pdf
   gmt basemap -JX16/8c -R0/180/0/90 -Bx60 -By30
   gmt plot input.dat -W1p
   gmt plot input.dat -W1p,green -Ax
   gmt plot input.dat -W1p,blue -Ay
   gmt end

绘制不同颜色的线段
------------------

当需要绘制不同颜色的线段时，可以在每段数据的头段记录中通过 ``-Z<val>`` 给每段
线段赋一个值，然后利用 ``-C`` 选项指定CPT文件或者 ``-C<color1>,<color2>,...``
语法指定Z取不同值时对应的颜色。

.. gmtplot::
   :language: bash
   :caption: 不同颜色的线段示例图

   R=0/9/0/4
   J=X16c/9c

   gmt begin lineColor png,pdf
   gmt makecpt -Crainbow -T-0.5/2.5/1
   gmt basemap -JX16c/9c -R0/9/0/4 -B1
   gmt plot -C -W2p << EOF
   > -Z0
   1 1
   2 3
   > -Z1
   2 1
   3 3
   > -Z2
   3 1
   4 3
   EOF
   gmt plot -Cblue,red,green -W2p << EOF
   > -Z0
   5 3
   6 1
   > -Z1
   6 3
   7 1
   > -Z2
   7 3
   8 1
   EOF
   gmt end

此示例中：

- ``makecpt`` 生成CPT文件，\ ``-T-0.5/2.5/1`` 指定了范围为 ``-0.5/2.5`` 是为了与 ``<val>`` 相对应
- ``-C`` 表示线段颜色分别由生成的 ``lineC.cpt`` 文件指定
- ``-Cblue,red,green`` 表示设置值为0、1、2的线段颜色分别为 blue, red 和 green
