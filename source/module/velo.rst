.. index:: ! velo

velo
====

:官方文档: :doc:`gmt:supplements/meca/velo`
:简介: 在地图上绘制速度矢量、十字线、楔形图

-S选项
------

``-S`` 选项决定了要绘制的符号的类型，以及输入数据的格式。

``-Se<velscale>/<confidence>/<fontsize>``
    绘制速度椭圆。速度用矢量表示，速度的不确定度用椭圆表示。输入数据中每列的含义为：

    #. 台站经度
    #. 台站纬度
    #. 速度矢量的东向分量
    #. 速度矢量的北向分量
    #. 东向分量的不确定度（1-sigma）
    #. 北向分量的不确定度（1-sigma）
    #. 东向分量和北向分量的correlation
    #. 台站名（可选）

    说明：

    #. ``<velscale>`` 控制了速度矢量的缩放比例，其对应了速度值为1的箭头的长度，默认单位由参数 ``PROJ_LENGTH_UNIT`` 决定，也可以自己添加长度单位 ``i|c|p``
    #. ``<confidence>`` 设置了椭圆的2D置信区间的极限，比如0.95代表95%置信区间
    #. ``<fontsize>`` 是文本（台站名）的大小
    #. 椭圆的填充色由 ``-G`` 选项控制
    #. 椭圆的轮廓以及矢量的画笔属性由 ``-W`` 选项控

``-Sr<velscale>/<confidence>/<fontsize>``
    绘制速度椭圆，与 ``-Se`` 类似，区别在于输入文件不同：

    #. 经度
    #. 纬度
    #. 速度矢量的东向分量
    #. 速度矢量的北向分量
    #. 椭圆的半长轴
    #. 椭圆的半短轴
    #. 椭圆的长轴相对于水平方向逆时针旋转的角度
    #. 台站名（可选）

``-Sn<barscale>``
    绘制各向异性矢量， ``<barscale>`` 是各向异性矢量的缩放比例。输入数据中每列的含义为：

    #. 经度
    #. 纬度
    #. 各向异性矢量的东向分量
    #. 各向异性矢量的北向分量

``-Sw<wedge_scale>/<wedge_mag>``
    绘制旋转饼图。输入数据中每列的含义为：

    #. 经度
    #. 纬度
    #. 旋转的角度（以radians为单位）
    #. 旋转的不确定度（以radians为单位）

    ``<wedge_scale>`` 设置了饼图的大小。所有的数值在绘图之前会先乘以 ``<wedge_mag>`` 。饼图的填充色由 ``-G`` 选项控制， 不确定度的颜色由 ``-E`` 控制。

``-Sx<cross_scale>``
    绘制应变十字线。 ``<cross_scale>`` 控制十字线的大小。输入文件中每列的含义为：

    #. 经度
    #. 纬度
    #. eps1：应变张量的扩张本征值，扩张为正
    #. eps2： 应变张量的压缩本征值，扩张为正
    #. eps2的方位角（北方向顺时针旋转的角度）

选项
----

``-A<params>``
    修改矢量的属性，见 :doc:`/basis/vector` 一节

``-D<sigma_scale>``
    控制 ``-Se`` 和 ``-Sr`` 中速度不确定度以及 ``-Sw`` 中旋转不确定度的缩放。该参数可以与 ``<confidence>`` 一起控制不确定度的绘制

``-F<fill>``
    控制边框和标注的颜色

``-E<fill>``
    控制 ``-Sw`` 中饼图不确定度的填充

``-G<fill>``
    控制颜色？

``-L``
    绘制线段。使用该选择，则椭圆和断层面会根据 ``-W`` 选项绘制轮廓

``-N``
    不跳过区域范围外的符号

``-W<pen>``
    设置速度箭头、椭圆轮廓以及断层边界的颜色

示例
----

.. literalinclude:: /scripts/psvelo_ex1.sh
   :language: bash

.. figure:: /images/psvelo_ex1.*
   :width: 100%
   :align: center

   psvelo示例图1

.. literalinclude:: /scripts/psvelo_ex2.sh
   :language: bash

.. figure:: /images/psvelo_ex2.*
   :width: 100%
   :align: center

   psvelo示例图2

下面的示例展示了如何绘制应变十字线::

    gmt psvelo -JX10c/10c -R0/10/0/10 -Sx10 -W1p > test.ps << EOF
    5 5 0.5 0.3 45
    EOF
