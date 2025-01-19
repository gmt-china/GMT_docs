#!/usr/bin/env bash
# 下载示例数据
wget -c https://github.com/CovMat/example-figure-data/raw/refs/heads/main/Marmousi.sgy
gmt begin ex
    #
    gmt segy2grd Marmousi.sgy -Gtmp.grd -R0/2800/0/1400 -I1/1
    #
    gmt grd2cpt -Cpolar tmp.grd -Z -Di
    gmt basemap -R1/2801/0/1.4 -JX10c/-10c -Bxaf+ltraces -Byaf+l"t (s)"
    gmt grdimage tmp.grd -C
    
    rm tmp.grd
gmt end show
