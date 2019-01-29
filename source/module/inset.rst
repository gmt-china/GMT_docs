.. index:: ! inset

inset
=====

:官方文档: :doc:`gmt:inset`
:简介: 管理和设置插图模式

``inset`` 模块用于创建插图模式，即在纸张上规划出一小片区域，并限制接下来的绘制
操作均只在该小区域内操作。

``inset`` 模块包含两个命令：

- ``inset begin`` 用于设置插图模式，其定义了插图区域的位置和大小
- ``inset end`` 用于结束插图模式，此时所有的操作都会回到原始的完全图中

``inset begin``
---------------

语法
~~~~

::

    gmt inset begin
        -D<inset-box>
        [-F<box>]
        [-M<margins>]

必须选项
~~~~~~~~

``-D[unit]xmin/xmax/ymin/ymax[r]``
    类似 :doc:`/option/R` 选项，使用该选项会在大区域地图中框出该选项所指定的小区域。

``-D[g|j|J|n|x]<refpoint>+w<width>[/<height>][+j<justify>][+o<dx>[/<dy>]]``
    确定一个插图区域，接下来的所有绘图操作仅在该小区域内操作。

    - ``g|j|J|n|x<refpoint>`` 用于指定插图区域的参考点，通常用 ``j`` 比较方便，
      例如 ``jTL`` 表示插图区域位于左上角，\ ``jBR`` 表示插图区域位于右下角。
      详情见 :doc:`/basis/embellishments/` 一节
    - ``+w<width>/<height>`` 指定了插图区域的宽度和高度
    - ``+j<justify`` 控制插图区域的锚点，见 :doc:`/basis/anchors` 一节
    - ``+o<dx>/<dy>`` 见 :doc:`/basis/embellishments/` 一节

``-F[+c<clearances>][+g<fill>][+i[[<gap>/]<pen>]][+p[<pen>]][+r[<radius>]][+s[[<dx>/<dy>/][<shade>]]]``
    设置插图区域的背景色、轮廓等熟悉，见 :doc:`/basis/embellishments/` 一节

``-M<margins>``
    插图内部的额外空白区域。其可以取三种形式：

    #. 一个值，表示四个边的空白相同
    #. 两个用斜杠分隔的值，分别设置水平和垂直方向的空白
    #. 四个用斜杠分隔的值，分别设置左右下上四条边的空白

``inset end``
-------------

``inset end`` 用于结束插图模式。

示例
----

::

    gmt begin inset png
	    gmt psbasemap -R0/40/20/60 -JM6.5i -Bafg -B+glightgreen
    	gmt inset begin -DjTR+w2.5i+o0.2i -F+gpink+p0.5p -M0.1i
	    	gmt psbasemap -Rg -JA20/20/2.3i -Bafg
    		echo INSET | gmt pstext -F+f12p+cTR
        gmt inset end
	    echo MAP | gmt pstext -F+f18p+cBL -Dj0.2i
    gmt end
