#!/bin/bash

#变量命名
J=H110/24c
R=g
PS=GMT_tutor2_4.ps
# 文件头
gmt psxy -J$J -R$R -T -K > $PS
# 底图
gmt psbasemap -Bg30 -J -R -K -O >> $PS
# 海岸线
gmt pscoast -J -R -Glightgreen -SCADETBLUE1 -A1000 -Dc -Bg30 -K -O >> $PS
# 台站三角形
gmt psxy -J -R -St0.2c -W0.5p,black,solid -Gblack -K -O >> $PS << EOF
104.39 29.90
13.14 52.50
19.99 -34.52
-77.15 38.89
-52.47 -31.62
150.36 -33.79
76.22 -69.22
EOF
# 震中
gmt psxy -J -R -Sa0.5c -W0.5p,black,solid -Gyellow -K -O >> $PS << EOF
130.72 32.78
EOF
# 射线路径
gmt psxy -R -J -O -K -W1p,red >> $PS << EOF
>
130.72 32.78
104.39 29.90 
>
130.72 32.78
13.14 52.50
>
130.72 32.78
19.99 -34.52
>
130.72 32.78
-77.15 38.89
>
130.72 32.78
-52.47 -31.62
>
130.72 32.78
150.36 -33.79
>
130.72 32.78
76.22 -69.22
EOF
# 地名
gmt pstext -J -R -F+f12p,1,black+jTL -D-1.5c/-0.15c -K -O >> $PS << EOF
-77.15 38.89 Washington
76.22 -69.22 Zhongshanzhan
EOF
gmt pstext -J -R -F+f12p,1,black+jTL -D-1c/-0.15c -K -O >> $PS << EOF
104.39 29.90 Zigong
13.14 52.50 Berlin
19.99 -34.52 Bredasdorp
EOF
gmt pstext -J -R -F+f12p,1,black+jTL -D-0.6c/-0.15c -K -O >> $PS << EOF
150.36 -33.79 Sydney
EOF
gmt pstext -J -R -F+f12p,1,black+jTL -D-0.6c/-0.15c -K -O >> $PS << EOF
-52.47 -31.62 Pelotas
EOF
# 文件尾
gmt psxy -J -R -T -O >> $PS
# 删除临时文件
rm gmt.*

