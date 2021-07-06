#!/usr/bin/env bash
gmt begin layers png,pdf

# 绘制地形起伏底图
gmt basemap -JH180/15c -Rg -B0
gmt grdimage @earth_relief_10m -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"
gmt end show
