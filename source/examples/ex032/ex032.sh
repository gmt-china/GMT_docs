#!/usr/bin/env bash
#
#带岛屿的湖泊填充示例
#
DEM_FILE="taihu_highres.nc"    # 高精度数字高程模型（DEM）文件
LAKE_FILE="taihu.gmt"          # 太湖湖泊边界的 GMT 格式文件

# 下载高精度 DEM（3 秒分辨率）
gmt grdcut @earth_relief_03s -R119/121/30/32 -G"$DEM_FILE"

# 绘制子图（左图：轮廓，右图：填充）
gmt begin taihu png

    gmt subplot begin 1x2 -Fs6i/6i -A -M0.5i -R119/121/30/32 -JX6i/6i

        # 左图：绘制湖泊轮廓
        gmt subplot set 0                 
        gmt grdimage "$DEM_FILE" -Cgeo 
        gmt plot "$LAKE_FILE" -W0.4p,red    # 绘制红色湖泊轮廓线

        # 右图：绘制湖泊填充
        gmt subplot set 1
        gmt grdimage "$DEM_FILE" -Cgeo
        gmt plot "$LAKE_FILE" -Gdeepskyblue  # 填充湖泊为深蓝色

    gmt subplot end  
gmt end show        
