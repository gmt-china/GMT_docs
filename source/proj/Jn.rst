-Jn：Robinson投影
=================

维基链接：https://en.wikipedia.org/wiki/Robinson_projection

此投影Arthur H. Robinson于1963年提出，是一个修改后的圆柱投影，既不是保角也不是
等面积。中心经线以及所有纬线都是直线，其余经线都是曲线。其使用查找表的方式而
不是解析表达式来使得全球看上去比较正常。比例尺在经线38°是真实的。

该投影的参数为:

**-JN**\ [*lon*/]\ *width*
或
**-Jn**\ [*lon*/]\ *scale*

- *lon* 是中心经线 [默认值为地图区域的中心]
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上1厘米对应真实地球 *xxxx* 厘米）

.. gmtplot::
    :caption: 使用Robinson投影绘制全球地图
    :width: 80%

    gmt coast -Rd -JN12c -Bg -Dc -A10000 -Ggoldenrod -Ssnow2 -png GMT_robinson
