#!/bin/bash
gmt begin 
    gmt figure 3D_earth_relief_1
        gmt set MAP_FRAME_TYPE plain
        # 1. 绘制地形图形。图层位于位于-1000的高度（默认为z轴底部）
        gmt grdview @earth_relief_02m -R101/108/35/42/-1000/20000 -JM10c -JZ10c -N-1000+ggray -Qi -I -Ba -BwsENZ -p60/25    
        gmt colorbar -C -Ba -DJTC+o0/1c -p

        # 2. 绘制断层线图层。-p 设置图层抬高到10000 
        gmt plot CN-faults.gmt -W2p,brown -p60/25/10000 -Ba -BWSen
        gmt basemap -TdjLT+w1.5c+l+o1c -p
        
        # 3. 绘制卫星图片图层。-p 设置图层抬高到20000
        gmt grdimage @earth_day_02m -p60/25/20000 -Ba -BWSen

    gmt figure 3D_earth_relief_2
        gmt set MAP_FRAME_TYPE plain
        # 预处理1. 生成断层的三维采样，输出数据为断层的经度、纬度以及对应的地形高程。
        gmt grdtrack -R101/108/35/42 -G@earth_relief_02m CN-faults.gmt > faults.xyz
        # 预处理2. 进入数据目录（~/.gmt/server/earth/earth_day）用gdal_translate裁剪出绘图区域的day.tif
        # 下载 earth_day_02_p 数据到当前目录
        gmt which -Gl @earth_day_02m_p
        gdal_translate -of GTIFF -projwin 101 42 108 35 earth_day_02m_p.tif day.tif
  
        # 绘图1. -G表示在DEM上贴卫星图片
        gmt grdview @earth_relief_02m -R101/108/35/42/-1000/5000 -JM10c -JZ4c -N-1000+ggray -Gday.tif -Qi -Ba -Bz -BwsENZ -p60/25   
        # 绘图2. 三维断层线
        gmt plot3d faults.xyz -W1p,brown -p
        # 绘图3. 色标和指北针
        gmt colorbar -C -Ba -DJTC+o0/1c -p
        gmt basemap -TdjLT+w1.5c+l+o1c -p60/25/2000
gmt end
rm day.tif faults.xyz
