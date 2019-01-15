MAP参数
=======

.. _MAP_DEFAULT_PEN:

**MAP_DEFAULT_PEN**
    设置所有与 ``-W`` 选项相关的画笔属性的默认值 [default,pen]

    在参数值的前面加上 ``+`` 可以覆盖其他PEN相关参数中的颜色。

.. _MAP_FRAME_AXES:

**MAP_FRAME_AXES**
    要绘制/标注的轴 [WSEN]

    默认值为WSEN，绘制并标注四条边，可以通过 ``-B`` 选项控制实际绘制的边。
    详情见 :doc:`/option/B` 选项。

.. _MAP_FRAME_TYPE:

**MAP_FRAME_TYPE**
    底图边框类型 [fancy]

    可选值包括 ``inside|plain|graph|fancy|fancy+`` 。
    一般情况下，\ ``fancy`` 边框类型仅适用于投影后的X、Y方向平行于经度纬度方向的
    情况，比如rectangular投影、polar投影。
    对于某些投影，只能使用plain底图，即便 ``MAP_BASEMAP_TYPE`` 被设置为fancy。

    下图给出了不同的底图边框类型的效果：

    .. gmt-plot:: /scripts/GMT_frame_type.sh
        :show-code: false
        :caption: GMT底图边框类型

.. _MAP_FRAME_PEN:

**MAP_FRAME_PEN**
    绘制底图类型为plain时边框的画笔属性 [``thicker,black``]

.. _MAP_FRAME_WIDTH:

**MAP_FRAME_WIDTH**
    设置底图类型为fancy时的边框宽度 [``5p``]

.. _MAP_ORIGIN_X:

**MAP_ORIGIN_X**
    新绘图在纸张上的原点的X坐标 [1i]

.. _MAP_ORIGIN_Y:

**MAP_ORIGIN_Y**
    设置新绘图在纸张上的原点的Y坐标 [1i]

.. _MAP_LOGO:

**MAP_LOGO**
    是否在左下角绘制GMT时间戳 [false]

    可以取 ``true|false``\ ，等效于在命令行中使用 ``-U`` 选项。

.. _MAP_LOGO_POS:

**MAP_LOGO_POS**
    GMT时间戳相对于当前绘图原点的对齐方式与位置 [``BL/-54p/-54p``]

.. _MAP_TITLE_OFFSET:

**MAP_TITLE_OFFSET**
    图标题的底部与轴标注（或轴标签）的顶部之间的距离 [14p]

.. _MAP_HEADING_OFFSET:

**MAP_HEADING_OFFSET**
    子图标题的顶部与图总标题的底部之间的距离 [18p]

.. _MAP_SCALE_HEIGHT:

**MAP_SCALE_HEIGHT**
    地图比例尺的高度 [5p]

.. _MAP_TICK_PEN:

**MAP_TICK_PEN**
    同时设置 ``MAP_TICK_PEN_PRIMARY`` 和 ``MAP_TICK_PEN_SECONDARY`` 的值

.. _MAP_TICK_PEN_PRIMARY:

**MAP_TICK_PEN_PRIMARY**
    一级刻度的画笔属性 [thinner,black]

.. _MAP_TICK_PEN_SECONDARY:

**MAP_TICK_PEN_SECONDARY**
    二级刻度的画笔属性 [thinner,black]

.. _MAP_TICK_LENGTH:

**MAP_TICK_LENGTH**
    同时设置 ``MAP_TICK_LENGTH_PRIMARY`` 和 ``MAP_TICK_LENGTH_SECONDARY`` 的值

.. _MAP_TICK_LENGTH_PRIMARY:

**MAP_TICK_LENGTH_PRIMARY**
    一级刻度的主刻度和次刻度的长度 [5p/2.5p]

    若只给定一个长度值，则次刻度的长度假定为主刻度的一半

.. _MAP_TICK_LENGTH_SECONDARY:

**MAP_TICK_LENGTH_SECONDARY**
    二级刻度的主刻度和次刻度的长度 [15p/3.75p]

    若只给定一个长度值，则次刻度的长度假定为主刻度的25%

.. _MAP_LINE_STEP:

**MAP_LINE_STEP**
    绘制线段时所使用的最大步长 [0.75p]

    地理投影下，两点之间会用大圆路径连接，因而GMT需要先计算大圆路径上的其他
    中间点的坐标，并将这些点用直线连起来。若该步长太大，会导致大圆路径看上去很不光滑。

.. _MAP_GRID_PEN:

**MAP_GRID_PEN**
    同时设置 ``MAP_GRID_PEN_PRIMARY`` 和 ``MAP_GRID_PEN_SECONDARY`` 的值

.. _MAP_GRID_PEN_PRIMARY:

**MAP_GRID_PEN_PRIMARY**
    一级网格线的线条属性 [default,black]

.. _MAP_GRID_PEN_SECONDARY:

**MAP_GRID_PEN_SECONDARY**
    二级网格线的线条属性 [thinner,black]

.. _MAP_GRID_CROSS_SIZE:

**MAP_GRID_CROSS_SIZE**
    同时设置 ``MAP_GRID_CROSS_SIZE_PRIMARY`` 和 ``MAP_GRID_CROSS_SIZE_SECONDARY`` 的值

.. _MAP_GRID_CROSS_SIZE_PRIMARY:

**MAP_GRID_CROSS_SIZE_PRIMARY**
    一级网格交叉线的大小，0表示绘制连续的网格线 [0p]

.. _MAP_GRID_CROSS_SIZE_SECONDARY:

**MAP_GRID_CROSS_SIZE_SECONDARY**
    二级网格交叉线的大小，0表示绘制连续的网格线 [0p]

.. _MAP_ANNOT_OFFSET:

**MAP_ANNOT_OFFSET**
    同时设置 ``MAP_ANNOT_OFFSET_PRIMARY`` 和 ``MAP_ANNOT_OFFSET_SECONDARY`` 的值

.. _MAP_ANNOT_OFFSET_PRIMARY:

**MAP_ANNOT_OFFSET_PRIMARY**
    一级标注的开始位置与刻度尾端间的距离 [5p]

.. _MAP_ANNOT_OFFSET_SECONDARY:

**MAP_ANNOT_OFFSET_SECONDARY**
    二级标注的底部与secondary标注的顶部之间的距离 [5p]

.. _MAP_LABEL_OFFSET:

**MAP_LABEL_OFFSET**
    轴标注底部与轴标签顶部间的距离 [8p]

.. _MAP_VECTOR_SHAPE:

**MAP_VECTOR_SHAPE**
    矢量箭头的形状 [0]

    取值范围为-2到2。0表示矢量头为三角形，1表示箭头形状，2表示打开的V字。
    其他的中间值代表了两种形状的中间值。

.. _MAP_DEGREE_SYMBOL:

**MAP_DEGREE_SYMBOL**
    在地图上绘制“度”时所使用的符号 [ring]

    可以取 ``ring|degree|colon|none``

.. _MAP_ANNOT_MIN_ANGLE:

**MAP_ANNOT_MIN_ANGLE**
    对于某些倾斜投影方式而言，如果标注的基线与地图的边界之间的夹角小于该值，
    则不绘制标注。合理的取值范围为 ``[0,90]`` [20]

.. _MAP_ANNOT_MIN_SPACING:

**MAP_ANNOT_MIN_SPACING**
    在某些倾斜投影中，相邻两个标注之间的最小距离，若标注的距离小于该值，则不绘制 [0p]

.. _MAP_ANNOT_ORTHO:

**MAP_ANNOT_ORTHO**
    控制哪些轴的标注垂直于轴 [we]

    该参数可以将 ``wesnz`` 做任意组合

.. _MAP_ANNOT_OBLIQUE:

**MAP_ANNOT_OBLIQUE**
    见官方文档

.. _MAP_POLAR_CAP:

**MAP_POLAR_CAP**
    控制网格线在两极附近的显示，见官方文档
