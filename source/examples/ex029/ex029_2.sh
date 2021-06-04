#!/bin/bash

# 将卫星图片与断层线贴在地形起伏上绘图
gmt begin 3D_earth_relief_2 pdf,png
    gmt set MAP_FRAME_TYPE plain
    # 预处理1. 生成断层的三维采样，输出数据为断层的经度、纬度以及对应的地形高程。
    gmt grdtrack -R101/108/35/42 -G@earth_relief_02m CN-faults.gmt > faults.xyz
    # 预处理2. 截取区域卫星图片
    # 下载 2弧分的卫星图片数据 earth_day_02m_p 到当前目录
    gmt which -Gl @earth_day_02m_p
    # 使用 gdal_translate 截取区域的卫星图片
    # -projwin 选项后的四个参数指定了区域范围。四个值分别是：
    #   左上角经度 左上角纬度 右下角经度 右下角纬度
    # gdal_translate 的详细用法见 https://gdal.org/programs/gdal_translate.html
    gdal_translate -of GTIFF -projwin 101 42 108 35 earth_day_02m_p.tif day.tif

    # 图层1. -G表示在DEM上贴卫星图片
    gmt grdview @earth_relief_02m -R101/108/35/42/-1000/5000 -JM10c -JZ4c -N-1000+ggray -Gday.tif -Qi -Ba -Bz -BwsENZ -p60/25   
    # 图层2. 三维断层线
    gmt plot3d faults.xyz -W1p,brown -p
    # 图层3. 色标和指北针
    gmt colorbar -C -Ba -DJTC+o0/1c -p
    gmt basemap -TdjLT+w1.5c+l+o1c -p60/25/2000

    rm day.tif faults.xyz
gmt end show
