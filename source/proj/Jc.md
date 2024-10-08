# -JC: Cassini cylindrical

维基链接：<https://en.wikipedia.org/wiki/Cassini_projection>

Cassini cylindrical（Cassini 圆柱投影）由 César-François Cassini de Thury 于 1745 年在调查法国时提出。
其偶尔也被称为 Cassini-Soldner 投影，因为后者提供了更加精确的数学分析得到了椭球下的公式。

此投影既不保角也不等面积，而是介于二者之间的一种投影方式。沿着中心经线的畸变最小，
适合绘制南北方向区域范围较大的地图。其中，中心经线、距离中心经线 90 度的两条经线以及
赤道是直线，其余经线和纬线都是复杂的曲线。

该投影方式的参数为：

**-JC***lon*/*lat*/*width*
或
**-Jc***lon*/*lat*/*scale*

- *lon*/*lat* 为中心的经纬度
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

```{eval-rst}
.. gmtplot::
    :caption: Cassini 投影绘制 Sardinia 岛
    :width: 50%

    gmt coast -R7:30/38:30/10:30/41:30+r -JC8.75/40/6c -Bafg -LjBR+c40+w100+f+o0.4c/0.5c -Dh \
        -Gspringgreen -Sazure -Wthinnest -Ia/thinner --FONT_LABEL=10p -png GMT_cassini
```
