#!/bin/bash

#变量命名
J=H110/24c
R=g
PS=GMT_tutor2_2.ps
# 文件头
gmt psxy -J$J -R$R -T -K > $PS
# 底图
gmt psbasemap -Bg30 -J -R -K -O >> $PS
# 海岸线
gmt pscoast -J -R -Glightgreen -Sblue -A1000 -Dc -Bg30 -K -O >> $PS
# 台站三角形
gmt psxy -J -R -St0.2c -W0.5p,black,solid -Gblack -: -K -O >> $PS << EOF
29.90  104.39
52.50  13.14
-34.52 19.99
38.89  -77.15
-31.62 -52.47
-33.79 150.36
-69.22 76.22
EOF
# 震中
gmt psxy -J -R -Sa0.5c -W0.5p,black,solid -Gyellow -: -K -O >> $PS << EOF
32.78 130.72
EOF
# 文件尾
gmt psxy -J -R -T -O >> $PS
# 删除临时文件
rm gmt.*
