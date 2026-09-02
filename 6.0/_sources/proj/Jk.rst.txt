-Jk：Eckert投影
===============

维基链接：

- https://en.wikipedia.org/wiki/Eckert_IV_projection
- https://en.wikipedia.org/wiki/Eckert_VI_projection

Eckert IV和VI投影由Max Eckert-Greiffendorff于1906年提出，是伪圆柱等面积投影。
中心经线以及所有的纬线都是执行，其余经线是等间隔分布的椭圆弧（IV）或正弦曲线（VI）。
比例尺在纬线40°30'（IV）和49°16'（VI）是真实的。\ **-JKf**\ （f代表four）表示
使用Eckert IV投影，\ **-JKs**\ （s代表six）表示使用Eckert VI投影。
若不指定 **f** 或 **s**\ ，则默认使用Eckert VI投影。

该选项的参数为:

**-JK**\ [**f**\|\ **s**][*lon*/]\ *width*
或
**-Jk**\ [**f**\|\ **s**][*lon*/]\ *scale*

*lon* 为中心经线，默认值为地图区域的中心。

Eckert IV示例：

.. gmtplot::
    :caption: Eckert IV投影绘制全球图
    :width: 85%

    gmt coast -Rg -JKf4.5i -Bg -Dc -A10000 -Wthinnest -Givory -Sbisque3 -png GMT_eckert4

Eckert VI示例:

.. gmtplot::
    :caption: Eckert VI投影绘制全球图
    :width: 85%

    gmt coast -Rg -JKs4.5i -Bg -Dc -A10000 -Wthinnest -Givory -Sbisque3 -png GMT_eckert4
