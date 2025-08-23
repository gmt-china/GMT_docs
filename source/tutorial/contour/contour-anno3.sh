#!/usr/bin/env bash

# 生成文本文件 fix.txt，指定一系列坐标
cat << EOF > fix.txt
80      -8.5
55      -7.5
102     0
130     10.5
EOF

gmt begin contour_annot3
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
    # -Gffix.txt/0.1i：现实中不可能完美指定一个位于等值线上的坐标，因此需要一个额外参数 0.1i
    # 模块会自动计算出等值线上离给定坐标距离最小并且距离小于 0.1i 的位置，进行标注
    gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+f8p -Gffix.txt/0.1i -T+lLH
gmt end show
