#!/bin/bash

J=Q104/15c
R=102.5/105.5/30.5/32.5
PS=beachball_3.ps
CPT=meca.cpt

# 生成CPT文件，为每个深度段设置不同的颜色
cat << EOF > $CPT
 0   0-1-1   20   0-1-1
20  60-1-1   40  60-1-1
40 120-1-1   60 120-1-1
60 240-1-1  100 240-1-1
EOF

gmt psbasemap -J$J -R$R -Ba -BWSEN -P -K > $PS
gmt psmeca -J -R -CP5p -Sa1.3c -Z$CPT -K -O >> $PS << EOF
# 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
104.33 31.91 39.8  32 64   85 7.0      0     0 A
104.11 31.52 27.1  22 53   57 6.0      0     0 B
103.67 31.13  6.4  86 32  -65 8.0      0     0 C
103.90 31.34 43.6 194 84  179 4.9 104.18 30.84 D
103.72 31.44 67.3  73 84 -162 4.9 103.12 31.64 E
104.12 31.78 12.7 186 68  107 4.7 103.83 32.26 F
104.23 31.61 62.0  86 63  -51 4.7 104.96 31.69 G
EOF

gmt psscale -J -R -C$CPT -DjBL+w5c/0.5c+ml+o0.8c/0.4c -Bx+lDepth -By+lkm -L -S -O >> $PS
