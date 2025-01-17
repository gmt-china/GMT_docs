#!/usr/bin/env bash
gmt begin meca_ex
    # 从GMT远程服务器下载示例地震目录文件
    gmt which -Gl @GCMT_1976-2017_meca.gmt
    # 
    gmt basemap -R-75.5/-63/-35/-30 -JM10c -Baf
    gmt coast -G244/243/239 -S167/194/223
    gmt makecpt -T0/150/1 -Z
    gmt meca GCMT_1976-2017_meca.gmt -Sc0.2c+f0 -C
gmt end show
