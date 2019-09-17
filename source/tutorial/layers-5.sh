#!/bin/bash
gmt begin layers png,pdf
gmt basemap -JH180/15c -Rg -B0
gmt grdimage @earth_relief_10m -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"

# 绘制大圆路径
gmt plot -W1p,red << EOF
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
gmt plot -Sa0.5c -W0.5p,black,solid -Gyellow << EOF
130.72 32.78
EOF

# 绘制台站位置
gmt plot -St0.2c -W0.5p,black,solid -Gblack << EOF
104.39 29.90
13.14 52.50
19.99 -34.52
-77.15 38.89
-52.47 -31.62
150.36 -33.79
76.22 -69.22
EOF

# 添加文本
gmt text -F+f9p,1,black+j -Dj0.1c/0.1c << EOF
-77.15  38.89 ML Washington
76.22  -69.22 ML Zhongshanzhan
104.39  29.90 MR Zigong
13.14   52.50 TC Berlin
19.99  -34.52 ML Bredasdorp
150.36 -33.79 ML Sydney
-52.47 -31.62 ML Pelotas
EOF

gmt end show
