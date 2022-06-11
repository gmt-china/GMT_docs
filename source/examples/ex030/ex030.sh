#!/usr/bin/env bash
#
# 绘制三维有限断层模型

gmt begin 3d_faultslip
    gmt set MAP_FRAME_TYPE plain #设置边框类型
    gmt set MAP_GRID_PEN 0p,gray,- #设置网格线
    
    gmt basemap -R97.3/99.5/34.3/35/-25/0 -JX15c/10c -JZ5c -Bxa0.25f0.125g0.125 -Bya0.25f0.125g0.125 -Bza10f5g5 -Bz+l"Depth(km)" -BwSEnZ -p160/20
    gmt makecpt -Cwhite,lightblue,yellow,red -T0/5.5/0.2 -Z
    gmt plot3d slip_3dgrid.gmtline -C -L -p -W0p,gray #绘制断层
    
    gmt set FONT_ANNOT_PRIMARY 7p
    gmt set MAP_ANNOT_OFFSET_PRIMARY 2p
    gmt set FONT_LABEL 8p
    gmt set MAP_FRAME_PEN thinner
    gmt set MAP_TICK_LENGTH 2p
    
    gmt colorbar -C -DjBL+w2.5c/0.3c+h+o1.3c/2c+ml -Ba1 -Bx+l"slip(cm)"
gmt end show