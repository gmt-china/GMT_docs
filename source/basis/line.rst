线条属性
========

对于线条而言，其基本的画笔属性由三个：线宽、颜色和线型，在 :doc:`/basis/pen`
中已经做过介绍。除此之外，某些模块还可以为线条设置额外的属性，
这些额外的属性可以通过在画笔属性后加上子选项来是实现。

线条的额外属性包括：端点偏移量、线条平滑和端点箭头。

端点偏移量
----------

在给定若干个数据点绘制线条时，一般都是从起点（第一个点）一直画到终点（最后一个点）。
可以使用 ``+o`` 子选项为线段两端指定偏移量，使得绘制线段时的起点和终点与输入数据中
指定的起点和终点间存在一定的偏移量。该子选项的语法是::

    +o<offset>[<u>]

- 若只给了一个 ``<offset>``\ ，则表示起点和终点共用同一个偏移量
- 也可以用 ``<offset>/<offset>`` 分别为起点和终点指定不同的偏移量
- 对于每个偏移量，都可以使用长度单位 ``c|i|p`` 或距离单位

下面的示例展示了 ``+o`` 子选项的用法。
图中，细线和粗线使用了相同的输入数据，其中细线没有使用 ``+o``\ ，
此时线段的起点和终点与数据指定的点重合；
粗线在绘制线条时使用了 ``-W2p+o1c/500k`` 选项，
即在起点处偏移1厘米，在终点处偏移500千米。

.. gmtplot::
    :show-code: false
    :caption: 线段起点偏移示意图

    ps=GMT_line_offset.ps
    gmt math -T10/30/1 T 20 SUB 10 DIV 2 POW 41.5 ADD = line.txt

    gmt psbasemap -R8/32/40/44 -JM5i -P -Bxaf -Bya2f1 -BWSne --MAP_FRAME_TYPE=plain -K > $ps
    gmt psxy line.txt -R -J -Wfaint,red -K -O >> $ps
    gmt psxy line.txt -R -J -W2p+o1c/500k -O -K >> $ps
    gmt pstext -R -J -O -K -F+f10p+jCM+a << EOF >> $ps
    11.0 42.6 -11.5 1 cm
    27.1 42.3 +9.5 500 km
    EOF
    gmt psxy -R -J -O -T >> $ps
    rm line.txt gmt.*

线条平滑
--------

通常情况下，在绘制线条时，两点之间是用直线连接的（地图上两点之间默认用大圆弧连接）。
使用 ``+s`` 子选项会使用 Bezier splines 在两点之间做样条插值以得到更光滑的曲线。

下图中，左图使用了 ``-W2p`` 选项，右边使用了 ``-W2p+s``\ 。

.. gmtplot::
    :show-code: false
    :caption: 线条自动样条插值示意图

    ps=GMT_bezier.ps
    cat << EOF > line.txt
    0       0
    1	1
    2	0.5
    4	2
    2	1.5
    EOF

    gmt psxy line.txt -R-0.25/4.25/-0.2/2.2 -JX3i/1.25i -P -W2p -K > $ps
    gmt psxy line.txt -R -J -O -K -Sc0.1i -Gred -Wfaint >> $ps
    gmt psxy line.txt -R -J -O -W2p+s -K -X3i >> $ps
    gmt psxy line.txt -R -J -O -Sc0.1i -Gred -Wfaint >> $ps
    rm gmt.* line.txt

端点箭头
--------

默认情况下，在绘制线段时，线段的两个端点并没有什么特别的。使用 ``+v`` 子选项，
可以在线段的一端或两段绘制端点箭头。该子选项的语法为::

    +v[b|e]<vspecs>

- 默认会在线段两端都加上箭头，\ ``b|e`` 表示只绘制开头或结尾的箭头
- ``<vspecs>`` 用于指定端点箭头的属性，详见 :doc:`vector`

下图中细线是通常绘制的线段，粗线使用的选项是 ``-W2p+o1c/500k+vb0.2i+gred+pfaint+bc+ve0.3i+gblue``\ 。

.. gmtplot::
    :show-code: false
    :caption: 线条端点箭头示意图

    ps=GMT_line_arrow.ps
    gmt math -T10/30/1 T 20 SUB 10 DIV 2 POW 41.5 ADD = line.txt

    gmt psxy line.txt -R8/32/40/44 -JM5i -P -Wfaint,red -K -Bxaf -Bya2f1 -BWSne --MAP_FRAME_TYPE=plain > $ps
    gmt psxy line.txt -R -J -W2p+o1c/500k+vb0.2i+gred+pfaint+bc+ve0.3i+gblue -O -K --MAP_VECTOR_SHAPE=0.5 >> $ps
    gmt psxy -R -J -O -T >> $ps
    rm gmt.* line.txt

其它属性
--------

除了上面提到的属性之外，GMT中还有一些参数可以影响线段的外观。这些参数包括：

- :ref:`PS_LINE_CAP <PS_LINE_CAP>`\ ：控制线段顶端的绘制方式
- :ref:`PS_LINE_JOIN <PS_LINE_JOIN>`\ ：控制线段拐点/交点的绘制方式
- :ref:`PS_MITER_LIMIT <PS_MITER_LIMIT>`\ ：控制线段拐点在 ``miter`` 模式下的阈值
