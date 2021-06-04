#!/bin/bash

# 三个图层分离绘图
gmt begin 3D_earth_relief_1 pdf,png
    gmt set MAP_FRAME_TYPE plain
    # 1. 绘制地形图形。图层位于位于-1000的高度（默认为z轴底部）
    gmt grdview @earth_relief_02m -R101/108/35/42/-1000/20000 -JM10c -JZ10c -N-1000+ggray -Qi -I -Ba -BwsENZ -p60/25    
    gmt colorbar -C -Ba -DJTC+o0/1c -p

    # 2. 绘制断层线图层。-p 设置图层抬高到10000 
    gmt plot CN-faults.gmt -W2p,brown -p60/25/10000 -Ba -BWSen
    gmt basemap -TdjLT+w1.5c+l+o1c -p
    
    # 3. 绘制卫星图片图层。-p 设置图层抬高到20000
    gmt grdimage @earth_day_02m -p60/25/20000 -Ba -BWSen
gmt end show
