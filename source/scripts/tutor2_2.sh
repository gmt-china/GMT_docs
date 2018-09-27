#!/bin/bash
gmt begin tutor2_2 pdf,png
gmt coast -JH110/24c -Rg -Bg30 -Glightgreen -Slightblue -A1000 -Dc 

# 绘制震中位置
gmt plot -Sa0.5c -W0.5p,black,solid -Gyellow  << EOF
130.72 32.78
EOF

# 绘制台站位置
gmt plot -St0.2c -W0.5p,black,solid -Gblack  << EOF
104.39 29.90
13.14 52.50
19.99 -34.52
-77.15 38.89
-52.47 -31.62
150.36 -33.79
76.22 -69.22
EOF

gmt end