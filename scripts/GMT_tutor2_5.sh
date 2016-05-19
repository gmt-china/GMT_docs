#!/bin/bash
J=H110/24c
R=g
PS=GMT_tutor2_5.ps

gmt pscoast -J$J -R$R -Bg30 -Glightgreen -Slightblue -A1000 -Dc -K > $PS

# 绘制大圆路径
gmt psxy -R -J -W1p,red -K -O >> $PS << EOF
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

# 绘制震中位置
gmt psxy -J -R -Sa0.5c -W0.5p,black,solid -Gyellow -K -O >> $PS << EOF
130.72 32.78
EOF

# 绘制台站位置
gmt psxy -J -R -St0.2c -W0.5p,black,solid -Gblack -K -O >> $PS << EOF
104.39 29.90
13.14 52.50
19.99 -34.52
-77.15 38.89
-52.47 -31.62
150.36 -33.79
76.22 -69.22
EOF

# 添加文本
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

gmt psxy -J -R -T -O >> $PS
rm gmt.*

