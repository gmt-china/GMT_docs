#!/usr/bin/env bash
#
# 绘制地球内部主要界面
#

gmt begin earth-discontinuities pdf,png
gmt set MAP_GRID_PEN_PRIMARY 1p
# 绘制地表
gmt basemap -JP10c+a+t15 -R-10/40/0/6371 -Byg6371 -BS
# 绘制 410 界面
gmt basemap -Byg6371+5961 -BS
# 绘制 660 界面
gmt basemap -Byg6371+5711 -BS
# 绘制 CMB
gmt basemap -Byg6371+3480 -BS
# 绘制 ICB
gmt basemap -Byg6371+1221 -BS

# 计算震相的射线路径，用户需安装 TauP，并取消以下注释
# taup_path -mod prem -ph PcP -h 300 -deg 30 -o PcP.raypath
# taup_path -mod prem -ph PKiKP -h 300 -deg 30 -o PKiKP.raypath

# 绘制震相的射线路径
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
gmt end show
