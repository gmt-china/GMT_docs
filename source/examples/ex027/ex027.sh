#!/bin/bash

# 绘制三江并流区域三维地形及地形剖面图
gmt begin 3D_View png,pdf
    # 生成三维地形图
    gmt grdview @earth_relief_05m -R98/100/27/29/800/6000 -JM9c -JZ2c -Qi -Cgeo -p150/40 -N800+g150/150/150 -Bx0.5 -By0.5 -Bz3000+l"Elevation (m)" -BSEwnZ -X3 -Y14c
    # 在三维地形图上绘制红色测线
    gmt grdtrack -G@earth_relief_05m -E98/28/100/28+i1k | gmt plot3d -JZ2c -W2p,red -p150/40
    # 生成色标尺
    gmt colorbar -Dx7/-1/15/0.3h -Bxf200a400 -By+l"meter" -I
    # 绘制地形剖面
    gmt basemap -R0/200/1500/5000 -JX15c/6c -Bne -Y-9c
    gmt basemap -BWS -Bxa20f10+l"Distance along the @;red;line profile@;; (km)" -Bya1000f500g1000+l"Elevation (m)"
    gmt project -C98/28 -E100/28 -G0.1 -Q | gmt grdtrack -G@earth_relief_05m > gmt.xy
    gmt plot gmt.xy -i2,3 -Wthick,darkred -Ggray -L+y1500

    rm gmt.xy
gmt end show