# -JY: Cylindrical equal area

维基链接：<https://en.wikipedia.org/wiki/Cylindrical_equal-area_projection>

Cylindrical equal area（圆柱等面积投影）选择不同的标准纬线，则对应不同的圆柱投影。
所有的这些圆柱投影都是等面积且不保角的。所有经线和纬线都是直线。在高纬度处畸变很大。

该投影的参数为：

**-JY***lon*/*lat*/*width*
或
**-Jy***lon*/*lat*/*scale*

- *lon* 是中心经线
- *lat* 是标准纬线。
- *width* 地图宽度
- *scale* 地图比例尺，即每度在图上的长度或 1:*xxxx* （图上 1 厘米对应真实地球 *xxxx* 厘米）

标准纬线可以取任意值，下面列出了一些比较流行的标准纬线的选择：

:::{table}
:align: center

|                 |                     |
| --------------- | ------------------- |
| Balthasart      | 50°                 |
| Gall            | 45°                 |
| Hobo-Dyer       | 37°30' (= 37.5°)    |
| Trystan Edwards | 37°24' (= 37.4°)    |
| Caster          | 37°04' (= 37.0666°) |
| Behrman         | 30°                 |
| Lambert         | 0°                  |
:::

```{eval-rst}
.. gmtplot::
    :caption: 使用 Behrman 圆柱等面积投影绘制地图
    :width: 85%

    gmt coast -R-145/215/-90/90 -JY35/30/12c -B45g45 -Dc -A10000 -Sdodgerblue -Wthinnest -png GMT_general_cyl
```
