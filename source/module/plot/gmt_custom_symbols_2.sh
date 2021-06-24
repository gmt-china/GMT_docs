#!/usr/bin/env bash
#
# 绘制自定义符号
#
gmt begin custom_symbol png,pdf
gmt basemap -R0/10/-2/4 -JX10c/2c -B2
# 绘制城市符号
echo 1 1 | gmt plot -Skcity/1 -W0.6p
# 绘制指北针符号,第三个参数为顺时针旋转角度
echo 2 1 0 | gmt plot -Skcompass/1 -W0.6p 
# 绘制应力解除符号,第三个参数为顺时针旋转角度
echo 3 1 45 | gmt plot -Skstress_relief/1 -W1p
# 绘制水压致裂符号,第三个参数为顺时针旋转角度
echo 4 1 135 | gmt plot -Skhydra_fract/1 -W1p 
# 绘制钻孔崩落符号,第三个参数为顺时针旋转角度
echo 5 1 45 | gmt plot -Skborehole_collapse/1 -W1p 
# 绘制断层滑动符号,第三个参数为顺时针旋转角度
echo 6 1 0  | gmt plot -Skfault_slip/1 -W1p 
# 绘制震源机制符号,第三个参数为顺时针旋转角度
echo 7 1 135 | gmt plot -Skfocal_mec/1 -W1p 
# 绘制钻孔槽符号,第三个参数为顺时针旋转角度
echo 8 1 45 | gmt plot -SkBS/1 -W1p 
# 绘制钻孔诱发张裂隙符号,第三个参数为顺时针旋转角度
echo 9 1 135 | gmt plot -SkDIF/1 -W1p 
gmt end show
