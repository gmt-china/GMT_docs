.. index:: ! gmtlogo

gmtlogo
=======

:官方文档: :doc:`gmt:gmtlogo`
:说明: 在图上绘制GMT的图形logo

该模块将GMT的图形logo绘制在图上。默认情况下，GMT的图形logo默认宽2英寸，高1英寸，
将放在当前的绘图原点处。

必选选项
--------

无

可选选项
--------

``-D[g|j|J|n|x]<refpoint>[+w<width>][+j<justify>][+o<dx>[/<dy>]]``
    设置logo在图中的位置

    - ``[g|j|J|n|x]<refpoint>`` 设置底图上的参考点，见 :doc:`/basis/embellishment` 一节
    - ``+j<justify>`` 设置logo上的锚点，见 :doc:`/basis/embellishment` 一节
    - ``+o<dx>[/<dy>]`` 设置参考点的额外偏移量，见 :doc:`/basis/embellishment` 一节
    - ``+w<width>`` 设置logo的宽度

``-F[+c<clearances>][+g<fill>][+i[[<gap>/]<pen>]][+p[<pen>]][+r[<radius>]][+s[<dx>/<dy>/][<fill>]]``
    在 logo 后加一个背景面板，见 :doc:`/basis/embellishment` 一节

    - ``+p<pen>`` 面板边框的画笔属性（默认画笔属性由参数 ``MAP_FRAME_PEN`` 决定）
    - ``+g<fill>`` 面板填充色（默认不填充颜色）
    - ``+c<clearances>`` 设置 logo 与面板边框之间空白区域的大小
    - ``+i<gap>/<pen>`` 为背景面板加上额外的内边框（默认的 ``<gap>`` 值为 ``2p``，
      内边框的画笔属性为 ``MAP_DEFAULTS_PEN`` ）
    - ``+r<radius>`` 面板使用圆角矩形边框（默认圆角半径为 ``6p`` ）
    - ``+s<dx>/<dy>/<fill>`` 为面板增加背景阴影区（默认值为 ``4p/-4p/gray50`` ）

示例
----

单独绘制一个2英寸宽的GMT logo::

    gmt logo -P -Dx0/0+w2i > logo.ps

将GMT logo作为一个图层放在当前底图的左上角::

    gmt logo -R -J -DjTR+o0.1i/0.1i+w3i -F+glightblue+s -K -O >> bigmap.ps
