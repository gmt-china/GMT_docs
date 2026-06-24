-JK: Eckert equal area
======================

维基链接：

- https://en.wikipedia.org/wiki/Eckert_IV_projection
- https://en.wikipedia.org/wiki/Eckert_VI_projection

Eckert IV/VI equal area（Eckert IV/VI 等面积投影） 由 Max Eckert-Greiffendorff 于 1906 年提出，是伪圆柱等面积投影。
中心经线以及所有的纬线都是直线，其余经线是等间隔分布的椭圆弧（IV）或正弦曲线（VI）。
比例尺在纬线 40°30'（IV）和 49°16'（VI）是真实的。\
**-JKf**\ （f 代表 four）表示使用 Eckert IV 投影，**-JKs**\ （s 代表 six）表示使用 Eckert VI 投影。
若不指定 **f** 或 **s**，则默认使用 Eckert VI 投影。

该选项的参数为:

**-JK**\ [**f**\|\ **s**][*lon*/]\ *width*
或
**-Jk**\ [**f**\|\ **s**][*lon*/]\ *scale*

- *lon* 为中心经度 [默认为地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上1厘米对应真实地球 *xxxx* 厘米）

Eckert IV 示例：

.. gmtplot::
    :caption: Eckert IV 投影绘制全球图
    :width: 85%

    gmt coast -Rg -JKf12c -Bg -Dc -A10000 -Wthinnest -Givory -Sbisque3 -png GMT_eckert4

Eckert VI 示例:

.. gmtplot::
    :caption: Eckert VI 投影绘制全球图
    :width: 85%

    gmt coast -Rg -JKs12c -Bg -Dc -A10000 -Wthinnest -Givory -Sbisque3 -png GMT_eckert4
