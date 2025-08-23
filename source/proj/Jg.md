# -JG: Azimuthal orthographic/General perspective

Azimuthal orthographic（正射方位投影）是一种从无穷远距离处的透视投影，因而常用于绘制从外太空看地球。
与 Lambert 等面积投影以及立体投影类似，一次只能看到一个半球。
该投影既不是等面积也不是保角，在半球边界处有较大畸变。
从投影中心出发的任意方向是真实的。

该投影的参数为：

**-JG***lon*/*lat*\[/*distance*\]/*width*
或
**-Jg***lon*/*lat*\[/*distance*\]/*scale*

- *lon*/*lat* 是投影中心位置
- *distance* 是边界离投影中心的度数 \[\<=90，默认值为 90\]
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上 1 厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*（表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*）

```{eval-rst}
.. gmtplot::
    :caption: 使用正射投影绘制半球
    :width: 60%

    gmt coast -Rg -JG-75/41/12c -Bg -Dc -A5000 -Gpink -Sthistle -png GMT_orthographic
```

**-Jg** 加上更多的参数时还可以用于绘制 General perspective（透视投影），以在二维平面内模拟从太空看三维的地球。
该投影与正射投影类似，都是从空间进行透视投影。
不同之处在于，正射投影的透视点在无穷远处，而透视投影可以指定透视点的位置，
因此整体效果类似于从飞行器拍摄地球。

该投影的参数为：

**-Jg**\|**G***lon0/lat0*/*scale*\|*width*[**+a***azimuth*][**+t***tilt*][**+v***vwidth/vheight*][**+w***twist*][**+z***altitude*[**r**\|**R**]\|**g**]

- *lon*/*lat* 投影中心的经纬度
- **-Jg** 对应 *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上 1 厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*（表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*）
- **-JG** 对应 *width* 地图宽度
- **+a** 设置 *azimuth* 观察者的方位角（相对于北向顺时针旋转的角度），默认值为 0 度
- **+t** 设置 *tilt* 倾角（单位为度），即相对于投影平面向上的角度，默认值为 0 度。
  若值为负数则视角以地平线为中心
- **+v** 限制了视角的角度为 *vwidth* 和 *vheight* ，单位为度。
- **+w** 设置 *twist* 扭转角度，即投影图像视轴的顺时针旋转，默认值为 0 度。180° 的扭转（如下图）模仿了飞行器倒挂飞行的情形。
- **+z** 设置 *altitude* 观察者所处的海拔，单位为 km，默认值为无限大。
  附加 **R** 表示所给的值为以地球半径为单位，观察者与地心的距离。
  附加 **r** 表示所给的值为 km 为单位的观察者与地心的距离。
  附加 **g** 表示地球同步轨道的高度。

:::{note}
由于透视投影类似从空间的飞行器中观察地球，*azimuth*，*tilt* 以及 *twist* 可以从飞行器姿态的角度理解，
分别对应航偏角、俯仰角以及翻滚角。*twist* 为 180° 时，可以看作“头朝下”观察地球。
:::

```{eval-rst}
.. gmtplot::
    :caption: 透视投影
    :width: 75%

    gmt coast -Rg -JG4/52/12c+z230+a90+t60+w180+v60 -Bx2g2 -By1g1 -Ia -Di -Glightbrown \ 
              -Wthinnest -Slightblue --MAP_ANNOT_MIN_SPACING=0.6c -view GMT_perspective
```
