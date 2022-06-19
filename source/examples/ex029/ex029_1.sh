#!/usr/bin/env bash
# 将三维地形、卫星图片以及断层线绘制在不同高度

gmt begin 3D_earth_relief_1
    gmt set MAP_FRAME_TYPE plain
    # 1. 绘制地形图形，图层默认位于 z 轴底部（此例中即 -1000 的高度）
    gmt grdview @earth_relief_06m -R101/108/35/42/-1000/20000 -JM10c -JZ10c -N-1000+ggray -Qi -I -Ba -BwsENZ -p60/25    
    gmt colorbar -C -Ba -DJTC+o0/1c -p

    # 2. 绘制断层线图层，-p 设置图层抬高到10000 
    gmt plot CN-faults.gmt -W2p,brown -p60/25/10000 -Ba -BWSen
    gmt basemap -TdjLT+w1.5c+l+o1c -p
    
    # 3. 绘制卫星图片图层，-p 设置图层抬高到20000
    gmt grdimage @earth_day_06m -p60/25/20000 -Ba -BWSen
gmt end show
