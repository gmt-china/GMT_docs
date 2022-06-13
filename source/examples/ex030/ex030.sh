#!/usr/bin/env bash
#
# 绘制三维有限断层模型

gmt begin 3d_faultslip
    gmt set MAP_FRAME_TYPE plain #设置边框类型
    gmt set MAP_GRID_PEN 0p,gray,- #设置网格线
    
    gmt basemap -R97.3/99.5/34.3/35/-25/0 -JX15c/10c -JZ5c -Bxa0.25fg -Bya0.25fg -Bza10fg+l"Depth (km)" -BwSEnZ -p160/20
    # 为滑移位错量制作 CPT。滑移位错量最小值为 0， 最大值为 5.5
    gmt makecpt -Cwhite,lightblue,yellow,red -T0/5.5/0.2 -Z
    # 绘制有限断层模型
    gmt plot3d slip_3dgrid.gmt -C -L -W0p,gray -p
    
    # 绘制 colorbar
    gmt set FONT_ANNOT_PRIMARY 7p FONT_LABEL 8p
    gmt set MAP_ANNOT_OFFSET_PRIMARY 2p MAP_FRAME_PEN thinner MAP_TICK_LENGTH 2p
    gmt colorbar -C -DjBL+w2.5c/0.3c+h+o1.3c/2c+ml -Ba1 -Bx+l"slip(cm)"
gmt end show