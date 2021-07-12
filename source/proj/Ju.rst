-JU: Universal Transverse Mercator (UTM)
========================================

维基链接：https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system

Universal Transverse Mercator （通用横轴 Mercator 投影，UTM)是横轴 Mercator 投影的一个特殊子集。
此处，全球在南北纬 84 度之间被划分为 60 个区域，大多数区域的宽度都是6度。
每一个区域都有各自位移的中心经线。进一步，每个区域都被划分为纬度带。

.. gmtplot:: GMT_utm_zones.sh
    :show-code: false
    :caption: 通用横向 Mercator 区域布局
    :width: 85%

该投影的参数为：

**-JU**\ *zone*/*width*
或
**-Ju**\ *zone*/*scale*

- *zone* 可以取 1-60、A、B、Y、Z，负值表示南半球的区域，也可以加上 C-H 以及 J-N 来指定纬度带。
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

为了让任意指定区域的畸变最小化，公式中乘以了比例因子 0.9996，这个值可以通过修改
:term:`PROJ_SCALE_FACTOR` 以自定义。这是的 UTM 投影是割线投影
而不是切线投影，在赤道处比例尺的畸变只有千分之一。在中心经线附近 10 度范围内的
椭球投影表达式都是精确的。对于更大的区域，则在一般球状公式中使用保角纬度作为代替。
