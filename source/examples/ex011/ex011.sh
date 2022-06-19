#!/usr/bin/env bash
#
# 地震台站为中心的地震分布图
#

# 假定台站位于 105E，30N 处
stlo=105
stla=30
# 使用 -JE 投影（四个参数: 中心经度/中心纬度/最大震中距/图片宽度）
J=E$stlo/$stla/90/10c

gmt begin map
gmt set FORMAT_GEO_MAP=+D
gmt coast -J$J -Rg -A10000 -Ggrey

# 绘制台站位置（三角形）
echo $stlo $stla | gmt plot -St0.4c -Gblack -Bya180
# 绘制地震位置（五角星）
gmt plot -Sa0.25c -Gred << EOF
145 30
160 40
60 40
80 -10
EOF

# 绘制等震中距线：30度（直径 60 度）、60 度（直径 120 度）
echo $stlo $stla 60d | gmt plot -SE- -W1p,red
echo $stlo $stla 120d | gmt plot -SE- -W1p,red
# 添加文字：30、60、90 度处
gmt text -D0c/0.3c << EOF
$stlo 0 30\232
$stlo -30 60\232
$stlo -59.9 90\232
EOF

gmt end show
