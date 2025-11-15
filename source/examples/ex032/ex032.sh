#!/usr/bin/env bash
#
LAKE_FILE="taihu.gmt"          # 太湖湖泊边界的 GMT 格式文件

gmt begin taihu

    gmt subplot begin 1x2 -Fs6i/6i -A -M0.5i -R119/121/30/32 -JM6i

        gmt subplot set 0                 
        gmt grdimage @earth_relief_15s -Cgeo -B+t"Taihu Lake Outline"
        gmt plot "$LAKE_FILE" -W0.4p,red    # 绘制红色湖泊轮廓线

        gmt subplot set 1
        gmt grdimage @earth_relief_15s -Cgeo -B+t"Taihu Lake Fill"
        gmt plot "$LAKE_FILE" -Gdeepskyblue  # 填充湖泊为深蓝色

    gmt subplot end  
gmt end show        
