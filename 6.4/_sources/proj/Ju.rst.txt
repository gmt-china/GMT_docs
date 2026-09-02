-JU: Universal Transverse Mercator (UTM)
========================================

维基链接：https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system

Universal Transverse Mercator （通用横轴 Mercator 投影，UTM）是横轴 Mercator 投影的一个特殊子集。
此投影将全球的南纬 80 到北纬 84 度之间被划分为多个区域，大多数区域的宽度（即经度间隔）
都是 6 度，以 1-60 表示经度区间编号；大多数区域的高度（即纬度间隔）为 8 度，在最北的纬度区间
（北纬 74 度以北）则被延伸至北纬 84 度，以覆盖所有陆地区域，纬度区域编号为 C-X，但其中不包含 I
和 O，以避免与数字 0 和 1 混淆。在南纬 80 度以南以及北纬 84 度以北，则为划分为单独的 4 个区块，
这四个区域不包含经纬度编号，直接使用 A、B、Y、Z 分别代表四个区域；详细分区见下图。

.. gmtplot:: GMT_utm_zones.sh
    :show-code: false
    :caption: 通用横向 Mercator 区域布局
    :width: 85%

该投影的参数为：

**-JU**\ *zone*/*width*
或
**-Ju**\ *zone*/*scale*

- *zone* 可以取 1-60[C-X]、A、B、Y、Z，编号含义见上文描述，其中纬度编号是可选的，如果
  不指定，则可以在经度编号数字前分别加 ``-`` 或 ``+`` 以表示南半球和北半球，但无法进一步
  精确到某个区块
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

为了让任意指定区域的畸变最小化，公式中乘以了比例因子 0.9996，这个值可以通过修改
:term:`PROJ_SCALE_FACTOR` 以自定义。这是的 UTM 投影是割线投影
而不是切线投影，在赤道处比例尺的畸变只有千分之一。在中心经线附近 10 度范围内的
椭球投影表达式都是精确的。对于更大的区域，则在一般球状公式中使用保角纬度作为代替。
