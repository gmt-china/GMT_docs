#!/usr/bin/env bash
# 下载示例数据
wget -c https://github.com/CovMat/example-figure-data/raw/refs/heads/main/Marmousi.sgy
gmt begin ex
    #
    gmt basemap -R1/2801/0/1.4
gmt end show
