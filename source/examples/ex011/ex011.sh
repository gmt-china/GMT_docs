#!/bin/bash
#!/usr/bin/env bash
#
# 事件相对台站的震中距反方位角分布图
#

# 假定台站位于 105/30 处
stlo=105
stla=30
# 使用-JE投影，其后面的四个参数分别是: 中心经度/中心纬度/最大震中距/图片宽度
J=E$stlo/$stla/90/10c

gmt begin map png,pdf
gmt set FORMAT_GEO_MAP=+D
gmt coast -J$J -Rg -A10000 -Ggrey
# 绘制台站位置（三角形）
echo $stlo $stla | gmt plot -St0.4c -Gblue -Bya180
# 绘制地震震源位置
gmt plot -Sa0.4c -Gyellow -W0.1p << EOF
145 30
160 40
60 40
80 -10
EOF
# 绘制30和60度等震中距线
echo $stlo $stla 6672 | gmt plot -SE- -W1p,red
echo $stlo $stla 13344 | gmt plot -SE- -W1p,red
# 在30, 60, 90度处添加文字
gmt text -D0c/0.3c << EOF
$stlo 0 30\232
$stlo -30 60\232
$stlo -59.9 90\232
EOF
gmt end show
