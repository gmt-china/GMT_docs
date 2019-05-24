绘制线条
========

:doc:`/module/psxy` 模块可以在图上绘制线段、多边形、符号。

本节主要讲解如何绘制线段、不同连接方式的线段、利用CPT文件绘制不同颜色线段、断层线。

以下示例使用的数据为
  :download:`dataSimp </gallery/lines/dataSimp>`\ ，
  :download:`dataA </gallery/lines/dataSimp>`\ ，
  :download:`data1 </gallery/lines/data1>`\ ，
  :download:`data2 </gallery/lines/data2>`\ 。
数据格式为含有 ``>`` 分隔的段数据。
  
简单线段
--------

``-W`` 设置线段属性，以下示例 ``-W2p,blue`` 表示设置线段粗细为2p、颜色为蓝色blue

.. gmt-plot::
   :language: bash
   :caption: 简单线段示例

   gmt psxy dataSimp -JX10c/10c -R0/9/0/9 -B1 -W2p,blue > lineSimp.ps
   
不同连接方式的线段
------------------

``-A[m|p|x|y]`` 设置两点间的连接方式。\ ``dataA`` 文件中按顺序保存了 ``(150,-70)``，\ ``(30,70)`` 两点。

.. gmt-plot::
   :language: bash
   :caption: 地理坐标下不同连接方式的线段

   set PS=lineGeo.ps
   gmt psbasemap -JN90/10c -R0/180/-90/90 -Bx60 -By30 -K > $PS
   gmt psxy dataA -J -R -W1p -O -K >> $PS
   gmt psxy dataA -J -R -W1p,red -A -O -K >> $PS
   gmt psxy dataA -J -R -W1p,green -Am -O -K >> $PS
   gmt psxy dataA -J -R -W1p,blue -Ap -O >> $PS

在地理坐标示例中：
- 未使用 ``-A`` 表示两点之间默认沿着大圆弧连接，图中黑线效果。
- ``-A`` 表示忽略当前的投影方式，直接用直线连接两点，图中红线效果。
- ``-Am`` 先沿着经线画，再沿着纬线画，图中绿线效果。
- ``-Ap`` 先沿着纬线画，再沿着经线画，图中蓝线效果。   
   
.. gmt-plot::
   :language: bash
   :caption: 笛卡尔坐标下不同连接方式的线段

PS=lineCart.ps
   gmt psbasemap -JX10/10c -R0/180/-90/90 -Bx60 -By30 -K > $PS
   gmt psxy dataA -J -R -W1p -O -K >> $PS
   gmt psxy dataA -J -R -W1p,green -Ax -O -K >> $PS
   gmt psxy dataA -J -R -W1p,blue -Ay -O >> $PS

在笛卡尔坐标示例中：
- 未使用 ``-A`` 表示两点之间默认用直线连接，图中黑线效果。
- ``-Ax`` 表示先沿着X轴画，再沿着Y轴画，图中绿线效果。
- ``-Ay`` 表示先沿着Y轴画，再沿着X轴画，图中蓝线效果。   
   
绘制不同颜色的线段
------------------

``-C`` 指定线段颜色，可以使用CPT文件指定，也可以使用 ``-C<color1>,<color2>,...`` 指定。

.. gmt-plot::
   :language: bash
   :caption: 绘制不同颜色线段示例图

   R=0/9/0/9
   J=X9c/9c
   PS=lineColo.ps
   gmt makecpt -Crainbow -T-0.5/2.5/1 > lineC.cpt
   gmt psbasemap -J$R -R$R -B1 -K > $PS
   gmt psxy data1 -J$R -R$R -ClineC.cpt -W2p -O -K >> $PS
   gmt psxy data2 -J$R -R$R -Cblue,red,green -W2p -O >> $PS

此示例中：
- 数据文件 ``data1``，\ ``data2`` 在多段数据的头段中指定了 ``-Z<val>`` 。
- ``makecpt`` 生成CPT文件，\ ``-T-0.5/2.5/1`` 指定了范围为 ``-0.5/2.5``  是为了与 ``<val>`` 相对应。
- ``-ClineC.cpt`` 线段颜色分别由生成的 ``lineC.cpt`` 文件指定。
- ``-Cblue,red,green`` 设置线段颜色分别为 ``blue,red,green`` 。   
   
绘制断层线
----------

``-Sf<gap>[/<size>][+l|+r][+b+c+f+s+t][+o<offset>][+p[<pen>]]`` 绘制断层符号并设置符号间距、大小，断层滑动等参数。

.. gmt-plot::
   :language: bash
   :caption: 断层线

   R=0/9/0/9
   J=X9c/9c
   PS=lineFault.ps
   gmt psbasemap -J$R -R$R -B1 -K > $PS
   gmt psxy data1 -J$R -R$R -Sf1c/0.4c+l+s -W2p,black -O -K >> $PS
   gmt psxy data2 -J$R -R$R -Sf2c/0.8c+r+s+o1 -Cblue,red,green -W2p  -O >> $PS

此示例中：
- ``-Sf2c/0.8c+r+s+o1`` 设置线段上符号的属性，\ ``f2c/0.8c`` 指定符号之间距离为2c、大小为0.8c，
  \ ``+r`` 表示绘制符号在线段右侧，\ ``+s`` 表示绘制断层滑动，
  \ ``+o`` 表示线段上的第一个符号相对于线段起点的偏离距离。
- ``-W2p,black`` 设置断层线属性。 
- ``-Cblue,red,green`` 设置断层线颜色分别为 ``blue,red,green`` 。     
   
