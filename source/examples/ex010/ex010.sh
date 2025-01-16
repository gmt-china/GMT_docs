#!/usr/bin/env bash
gmt begin ex010
    # 自动获取作图范围
    R=$(gmt info data.txt -I2/2 -i7,6 | tr -d '\n')
    
    gmt basemap ${R} -JM15c -Baf
gmt end show