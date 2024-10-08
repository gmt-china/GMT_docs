# -JP: Polar/Cylindrical

Polar（极坐标投影）用于绘制极坐标数据（即角度 $\theta$ 和半径 $r$）。

指定极坐标投影的语法为:

**-Jp***scale*\[**+a**\]\[**+f**\[**e**|**p**|*radius*\]\]\[**+r***offset*\]\[**+t***origin*\]\[**+z**\[**p**|*radius*\]\]\]

**-JP***width*\[**+a**\]\[**+f**\[**e**|**p**|*radius*\]\]\[**+r***offset*\]\[**+t***origin*\]\[**+z**\[**p**|*radius*\]\]\]

- **-Jp***scale* 表示指定比例尺，**-JP***width* 表示指定整张图的宽度

- 默认情况下，角度 $\theta$ 是指相当于东方向逆时针旋转的角度（标准定义）；
  加上 **+a** 则表明输入数据是相对于北方向顺时针旋转的角度（地理学中的方位角）

- **+r***offset* 表示 r 轴的偏移量，即不将 r=0 放在圆心处

- **+t***origin* 设置东方向对应的角度，相当于对整个坐标轴做顺时针旋转；
  若使用了 **+a** 选项，则设置北方向对应的角度，相当于将整个坐标轴逆时针旋转。

- **+f** 表示将径向方向反转

  - 加上 **e** 表示 r 轴为高程角，此时r轴范围应在 0 到 90 之间
  - 加上 **p** 表示在 r 轴反转时设置当前地球半径（由 {term}`PROJ_ELLIPSOID` 决定）
    为 r 轴的最大值
  - 加上 *radius* 设置 r 轴的最大值

- **+z** 表示将 r 轴标记为深度而不是半径，即 *r = radius - z*

  - 加上 **p** 表示将 radius 设置为当前地球半径
  - 加上 *radius* 表示设置 *radius* 的值

下面给出了一些极坐标的示例以展示极坐标的用法：

```{eval-rst}
.. gmtplot:: Jp.sh
   :width: 75%

   极坐标用法示例
```
