#!/bin/bash

# 此处定义了函数plotpts，用于绘制图中绿色和蓝色的圆圈，并加上文字
function plotpts
{
    # Plots the two data tables and places given text
    gmt plot -Sc0.2c -Ggreen -Wfaint t1.txt
    gmt plot -Sc0.2c -Gblue -Wfaint t2.txt
    echo $* | gmt text -F+cTL+jTL+f12p -Dj0.05i
}
# 生成测试用的第一个数据文件
cat << EOF > t1.txt
10 10
48 15
28 20
>
40 40
30  5
5  15
EOF
# 生成测试用的第二个数据文件
cat << EOF > t2.txt
7  20
29 11
8   4
EOF
# -Fcs: 默认的连接方式
gmt begin plot_-F pdf,png
gmt basemap -R0/50/0/45 -Jx0.06i -Ba10 -BWSne
gmt plot -W1p t[12].txt
plotpts TWO DATA TABLES

# -Fra
gmt plot -W1p t[12].txt -Fra -X3.25i
plotpts DATASET ORIGIN

# -Frf
gmt plot -W1p t[12].txt -Frf -X-3.25i -Y3.15i
plotpts TABLE ORIGIN

# -Frs
gmt plot -W1p t[12].txt -Frs -X3.25i
plotpts SEGMENT ORIGIN

# -Fr10/35
gmt plot -W1p t[12].txt -Fr10/35 -X-3.25i -Y3.15i
plotpts FIXED ORIGIN
echo 10 35 | gmt plot -Sa0.4c -Gred -Wfaint

# -Fna
gmt plot -W1p t[12].txt -Fna -X3.25i
plotpts NETWORK

gmt end
rm t[12].txt
