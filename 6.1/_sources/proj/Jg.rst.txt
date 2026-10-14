-Jg：正交投影
=============

正交方位投影是一种从无穷远距离处的透视投影，因而常用于绘制从外太空看地球。
与Lambert等面积投影以及立体投影类似，一次只能看到一个半球。
该投影既不是等面积也不是保角，在半球边界处有较大得畸变。
从投影中心出发的任意方向是真实的。

该投影的参数为：

**-JG**\ *lon*/*lat*\ [/*distance*]/*width*
或
**-Jg**\ *lon*/*lat*\ [/*distance*]/*scale*

- *lon*/*lat* 是投影中心位置
- *distance* 是边界离投影中心的度数 [<=90，默认值为90]
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*\ ）

.. gmtplot::
    :caption: 使用正交投影绘制半球
    :width: 60%

    gmt coast -Rg -JG-75/41/12c -Bg -Dc -A5000 -Gpink -Sthistle -png GMT_orthographic

**-Jg** 加上更多的参数时还可以用于绘制透视投影，以在二维平面内模拟从太空看三维的地球。
具体的参数为：

**-JG**\ *lon*/*lat*/*altitude*/*azimuth*/*tilt*/*twist*/*Width*/*Height*/*width*
或
**-Jg**\ *lon*/*lat*/*altitude*/*azimuth*/*tilt*/*twist*/*Width*/*Height*/*scale*

- *lon*/*lat* 投影中心的经纬度
- *altitude* 是观察者所处的海拔，单位为km，默认值为230 km。若该值小于10，则假定是观察者相对于
  地心的距离，若距离后加了 **r**\ ，则表示观察者与地心的距离（单位为km）。
- *azimuth* 观察者的方位角（相对于北向顺时针旋转的角度）。默认值为90度，即从东向观测
- *tilt* 倾角（单位为度）。即相对于天顶的角度，默认值为60度。
  若值为0则表示在天顶直接向下看，值为60则表示在天顶处沿着水平方向30度角的方向观察
- *twist* 扭转角度，默认值为180度。
  This is the boresight rotation (clockwise) of the image.
  The twist of 180° in the example mimics the fact that the Space Shuttle flies upside down.
- *Width*/*Height* 是视角的角度，单位为度，默认值为60。
  该值取决于你是否是使用裸眼观看（裸眼的角度一般是60度宽），或使用其它设备（如望远镜）
- *width* 地图宽度
- *scale* 地图比例尺，可以取 1:*xxxx* 格式（图上1厘米对应真实地球 *xxxx* 厘米），
  也可以是 *radius*/*latitude*\ （表示从投影中心到纬线 *latitude* 在图上的距离为 *radius*\ ）

.. gmtplot::
    :caption: 透视投影
    :width: 75%

    gmt coast -Rg -JG4/52/230/90/60/180/60/60/12c -Bx2g2 -By1g1 -Ia -Di -Glightbrown \
        -Wthinnest -Slightblue --MAP_ANNOT_MIN_SPACING=0.6c -png GMT_perspective
