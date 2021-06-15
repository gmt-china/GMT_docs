#!/bin/bash
gmt begin custom_symbol png,pdf

# 绘制指北针符号，第三列为旋转角度
echo 2 2 0 | gmt plot -Skcompass/2c -W0.6p -R0/10/0/4 -JM10c -B2 
# 绘制城市符号
echo 5 2 | gmt plot -Skcity/1c -Gred -W1p
# 绘制图例
gmt legend -F+p1p -DjBR+o0.2c/0.2c << EOF
S - kcompass 0.3c white 0.5p - compass
S - kcity 0.3c white 0.5p - city
EOF
gmt end show