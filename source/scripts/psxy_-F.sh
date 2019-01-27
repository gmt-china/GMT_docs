#!/bin/bash
ps=psxy_-F.ps

# 此处定义了函数plotpts，用于绘制图中绿色和蓝色的圆圈，并加上文字
function plotpts
{
    # Plots the two data tables and places given text
	gmt psxy -R -J -O -K -Sc0.2c -Ggreen -Wfaint t1.txt
	gmt psxy -R -J -O -K -Sc0.2c -Gblue -Wfaint t2.txt
	echo $* | gmt pstext -R -J -O -K -F+cTL+jTL+f12p -Dj0.05i
}
# 生成测试用的第一个数据文件
cat << EOF > t1.txt
10	10
48	15
28	20
>
40	40
30	5
5	15
EOF
# 生成测试用的第二个数据文件
cat << EOF > t2.txt
7	20
29	11
8	4
EOF
scl=0.06i
# -Fcs: 默认的连接方式
gmt psxy -R0/50/0/45 -Jx${scl} -P -Ba10 -BWSne -W1p t[12].txt -K > $ps
plotpts TWO DATA TABLES >> $ps

# -Fra
gmt psxy -R -J -Ba10 -BwSnE -W1p t[12].txt -Fra -O -K -X3.25i >> $ps
plotpts DATASET ORIGIN >> $ps

# -Frf
gmt psxy -R -J -W1p -Ba10 -BWSne t[12].txt -Frf -O -K -X-3.25i -Y3.15i >> $ps
plotpts TABLE ORIGIN >> $ps

# -Frs
gmt psxy -R -J -Ba10 -BwSnE -W1p t[12].txt -Frs -O -K -X3.25i >> $ps
plotpts SEGMENT ORIGIN >> $ps

# -Fr10/35
gmt psxy -R -J -Ba10 -BWSne -W1p t[12].txt -Fr10/35 -O -K -X-3.25i -Y3.15i >> $ps
plotpts FIXED ORIGIN >> $ps
echo 10 35 | gmt psxy -R -J -O -K -Sa0.4c -Gred -Wfaint >> $ps

# -Fna
gmt psxy -R -J -Ba10 -BwSnE -W1p t[12].txt -Fna -O -K -X3.25i >> $ps
plotpts NETWORK >> $ps

gmt psxy -R -J -O -T >> $ps
rm gmt.* t[12].txt
