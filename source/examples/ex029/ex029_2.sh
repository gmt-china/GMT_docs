#!/usr/bin/env bash
# 将卫星图片和断层线直接绘制在三维地形上

gmt begin 3D_earth_relief_2
    gmt set MAP_FRAME_TYPE plain
    # 预处理1：生成断层的三维采样，输出数据为断层的经度、纬度以及对应的地形高程
    # 断层数据有第三列深度，所以grdtrack默认会将高程输出到第4列，因此需要使用 -o0,1,3 让第三列输出为高程。
    gmt grdtrack -R101/108/35/42 -G@earth_relief_06m CN-faults.gmt -o0,1,3 > faults.xyz

    # 绘制卫星图片，-G 表示在 DEM 上贴卫星图片
    gmt grdview @earth_relief_06m -R101/108/35/42/-1000/5000 -JM10c -JZ4c -N-1000+ggray -G@earth_day_06m_p -Qi -Ba -Bz -BwsENZ -p60/25   
    # 绘制断层线
    gmt plot3d faults.xyz -W1p,brown -p
    # 绘制指北针
    gmt basemap -TdjLT+w1.5c+l+o1c -p60/25/2000

    rm faults.xyz
gmt end show
