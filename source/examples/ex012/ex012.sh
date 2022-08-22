#!/usr/bin/env bash

gmt begin mt
    # 设置 SECONDARY TICK 长度为 0
    gmt set MAP_TICK_LENGTH_SECONDARY 0p
    # 设置地图上的时间只显示年份和月份
    gmt set FORMAT_DATE_MAP yyyy-mm

    # -Sb0.005c 中 0.005c 代表每条线的宽度
    # -BSW 只显示左边和下边坐标
    # -Bsxa1O 设置X轴次级标注的间隔为1个月，注意最后一个字符是大写字母O不是数字0
    # -Bpxa7Rf1d 设置X轴主级标注的间隔为7天，刻度间隔为1天
    # -B+l"Date" 设置X轴标签
    # -Bya1 设置Y轴标注间隔为1
    # -B+l@%2%M@-L@-@%% 设置Y轴标签，使用2号字体并将L设置为下标
    gmt plot mt.txt -R2017-02-10T00:00:00/2017-05-04T00:00:00/0/5 -JX15c/5c -Sb0.005c -Gblack \
        -BSW -Bsxa1O -Bpxa7Rf1d -Bx+l"Date" -Bya1 -By+l@%2%M@-L@-@%%
gmt end show