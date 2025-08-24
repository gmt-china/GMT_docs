#!/usr/bin/env bash

# 生成多段数据文件，定义三条折线
cat << EOF > cross.txt
>
58 -11
63 -6
68 -2
72 -1
78 3
>
150 3
158 13
>
95 -8
102 -7
110 -8
120 -2
123 0
EOF

gmt begin contour_annot5
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
    # -GXcross.txt：从 cross.txt 读取折线数据，在折线与等值线的交点处标注
    gmt grdcontour @App_O_geoid.nc -B20f10 -BWSne -C10 -A20+f8p -GXcross.txt -S10 -T+lLH
gmt end show
