#!/usr/bin/env bash

gmt begin mt
    # 设置 SECONDARY TICK 长度为 0
    gmt set MAP_TICK_LENGTH_SECONDARY 0p
    # 设置地图上的时间只显示年份和月份
    gmt set FORMAT_DATE_MAP yyyy-mm

    # -BSW 只显示左边和下边坐标
    # -Bsxa1O 设置X轴次级标注的间隔为1个月，注意最后一个字符是大写字母O不是数字0
    # -Bpxa7Rf1d 设置X轴主级标注的间隔为7天，刻度间隔为1天
    # -B+l"Date" 设置X轴标签
    # -Bya1+l 设置Y轴标注间隔为1，并设置Y轴标签，标签使用斜体（2号字体），L 为下标
    gmt basemap -R2017-02-10T00:00:00/2017-05-04T00:00:00/0/5 -JX15c/5c -BSW -Bsxa1O -Bpxa7Rf1d -Bx+l"Date" -Bya1+l@%2%M@-L@-@%%
    
    # -Sb0.005c 中 0.005c 代表每条线的宽度
    gmt plot mt.txt -Sb0.005c -Gblack 
gmt end show