#!/bin/bash
gmt begin custom_symbol png,pdf

# 绘制指北针符号，第三列为旋转角度
echo 3 8 0| gmt plot -Skcompass/0.4i -W0.6p -R0/10/0/10 -JM4i -B2 
echo 5 8 45| gmt plot -Skcompass/0.5i -Gblue
echo 7 8 90| gmt plot -Skcompass/0.6i -Gred -W1p
# 绘制城市符号
echo 3 5 | gmt plot -Skcity/0.2i -W0.6p
echo 5 5 | gmt plot -Skcity/0.3i -Gblue
echo 7 5 | gmt plot -Skcity/0.4i -Gred -W1p
# 绘制三角形和五角星符号
echo 2 2 | gmt plot -Sa0.5i -Wblack -Gred
echo 4 2 | gmt plot -St0.5i -Wblack -Ggreen
# 绘制图例
gmt legend -F+p1p -DjBR+o0.2c/0.2c << EOF
S - kcompass 0.12i white 0.5p - compass
S - kcity 0.12i white 0.5p - city
S - a 0.12i red 0.5p - capital
S - t 0.12i green 0.5p - station
EOF
gmt end show