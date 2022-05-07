#!/usr/bin/env bash
gmt begin legend_ex2
gmt basemap -R-0.2/4.2/0/7 -JX16c/8c -Bxa1+l"Number of iterations" -Bya1+l"Normalized RMS" -BWSrt

# legend1
cat > 1.txt << EOF
0 6.680
1 1.18
2 0.861
3 0.533
4 0.374
EOF
gmt plot 1.txt -Ss0.4c -W1p,DEEPSKYBLUE
gmt plot 1.txt -W1p,DEEPSKYBLUE

# legend2
cat > 2.txt << EOF
0 6.458
1 2.423
2 0.789
3 0.523
4 0.304
EOF
gmt plot 2.txt -Sc0.4c -W1p,BROWN1
gmt plot 2.txt -W1p,BROWN1

# legend3
cat > 3.txt << EOF
0 6.627
1 3.223
2 0.650
3 0.507
4 0.289
EOF
gmt plot 3.txt -Sa0.4c -W1p,PURPLE
gmt plot 3.txt -W1p,PURPLE

# 设置图例文件
# 设置不同的符号
# symbol space legend type length (-) thickness,color space LegendName
echo S 0.2c s 0.3c - 0.8p,DEEPSKYBLUE 0.8c Line1  >> legends.txt
echo S 0.2c c 0.3c - 0.8p,BROWN1 0.8c Line2 >> legends.txt
echo S 0.2c a 0.3c - 0.8p,PURPLE  0.8c Line3 >> legends.txt
# 上移3行
echo G -3l >> legends.txt
# 设置不同的线段
echo S 0.2c - 0.6c - 0.8p,DEEPSKYBLUE 0.8c >> legends.txt
echo S 0.2c - 0.6c - 0.8p,BROWN1 0.8c >> legends.txt
echo S 0.2c - 0.6c - 0.8p,PURPLE  0.8c>> legends.txt
gmt legend legends.txt -DjTR+l1.2+o0.2c/0.2c -F+p1p

rm legends.txt 1.txt 2.txt 3.txt
gmt end show
