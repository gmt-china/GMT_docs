-Ju：通用横向Mercator(UTM)投影
==============================

维基链接：https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system

通用横向Mercator(UTM)投影是横向Mercator投影的一个特殊子集。此处，全球在南北纬84度
之间被划分为60个区域，大多数区域的宽度都是6度。每一个区域都有各自位移的中心经线。
进一步，每个区域都被划分为纬度带。

.. gmtplot:: /scripts/GMT_utm_zones.sh
    :show-code: false
    :caption: 通用横向Mercator区域布局
    :width: 85%

该投影的参数为：

**-JU**\ *zone*/*width*
或
**-Ju**\ *zone*/*scale*

其中 *zone* 可以取1-60、A、B、Y、Z，负值表示南半球的区域，也可以加上C-H
以及J-N来指定纬度带。

为了让任意指定区域的畸变最小化，公式中乘以了比例因子0.9996，这个值可以通过修改
:term:`PROJ_SCALE_FACTOR` 以自定义。这是的UTM投影是割线投影
而不是切线投影，在赤道处比例尺的畸变只有千分之一。在中心经线附近10度范围内的
椭球投影表达式都是精确的。对于更大的区域，则在一般球状公式中使用保角纬度作为代替。
