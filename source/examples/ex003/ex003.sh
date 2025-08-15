#!/usr/bin/env bash
#
# 以地形起伏进行明暗处理绘制其它数据
#
gmt begin relief-shaded-image
    gmt subplot begin 1x2 -Fs10c/10c -Baf -M0.5c

        # 未经地形起伏调制的洋壳年龄数据
        gmt subplot set 0
        # 根据用户实际需求先绘制下方图层，代码略
        # ...
        # -Q 选项可以让没有洋壳年龄数据的区域透明，显示出下方的图层
        gmt grdimage @earth_age_06m -R150/250/-40/40 -B+t"Original crustal age" -Q
        gmt coast -W0.5p

        # 使用地形起伏进行明暗处理的洋壳年龄数据
        gmt subplot set 1
        # 根据用户实际需求先绘制下方图层，代码略
        # ...
        # -Q 选项可以让没有洋壳年龄数据的区域透明，显示出下方的图层
        gmt grdimage @earth_age_06m -R150/250/-40/40 -I@earth_relief_06m+d -B+t"Relief-shaded crustal age" -Q
        gmt coast -W0.5p

    gmt subplot end

    gmt colorbar -Baf50+l"crustal age (Myr)" -C@earth_age.cpt
gmt end show
