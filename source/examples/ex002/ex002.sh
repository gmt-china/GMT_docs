#!/bin/bash

gmt begin earth-discontinuities png
gmt set MAP_GRID_PEN_PRIMARY 1p
# 绘制地表
gmt basemap -JPa10c/15 -R-10/40/0/6371 -Byg6371 -Bs
# 绘制 410 界面
gmt basemap -Byg6371+5961 -Bs
# 绘制 660 界面
gmt basemap -Byg6371+5711 -Bs
# 绘制 CMB
gmt basemap -Byg6371+3480 -Bs
# 绘制 ICB
gmt basemap -Byg6371+1221 -Bs

# 计算并绘制震相的射线路径
taup_path -mod prem -ph PcP -h 300 -deg 30 -o PcP.raypath
taup_path -mod prem -ph PKiKP -h 300 -deg 30 -o PKiKP.raypath
gmt plot PcP.raypath.gmt -W1p,blue
gmt plot PKiKP.raypath.gmt -W1p,red

# 绘制震源和台站位置
gmt plot -S -Gblack -N << EOF
0 6071 0.4c a
30 6471 0.4c i
EOF

# 添加标注
gmt text -F+f11p+a -N << EOF
-6 6170 20 Surface
-6 3280 20 CMB
-3 1020 20 ICB
16 4100 0 @;blue;PcP@;;
37 1600 0 @;red;PKiKP@;;
EOF
rm *.raypath.gmt
gmt end