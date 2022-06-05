#!/usr/bin/env bash
#
# 以地形起伏进行明暗处理绘制其它数据
#
gmt begin relief-shaded-image
	gmt subplot begin 1x2 -Fs10c/10c -M0.5c

	# 未经地形起伏调制的洋壳年龄数据
	gmt subplot set 0
	gmt grdimage @earth_age_06m -R150/250/-40/40 -B+t"Original crustal age"
	gmt coast -W0.5p -Baf
	gmt colorbar -Baf50

	# 使用地形起伏进行明暗处理的洋壳年龄数据
	gmt subplot set 1
	gmt grdimage @earth_age_06m -R150/250/-40/40 -I@earth_relief_06m+d -B+t"Relief-shaded crustal age"
	gmt coast -W0.5p -Baf
	gmt colorbar -Baf50

	gmt subplot end
gmt end show
