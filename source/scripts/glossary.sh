#!/bin/bash
gmt begin glossary pdf,png

# 绘制纸张范围
gmt basemap -R0/28.7/0/20 -Jx1c -B0 -X0.5c -Y0.5c 
echo 0 0 | gmt plot -Sc0.3c -Gred -N 
echo 0 0 PAPER_ORIGIN | gmt text -F+jBL -D1c/0.5cv1p -N 
gmt plot -W1p,- << EOF
>
2 0
2 2
>
0 2
2 2
EOF

# 绘制图1
gmt basemap -Jx1c -R0/10/0/7 -Bx1+l"XLABEL" -By1+l"YLABEL" -BWSen+t"Figure 1" -X2c -Y2c 
echo 0 0 | gmt plot -Sc0.3c -Gred -N 
echo 0 0 BASEMAP_ORIGIN | gmt text -F+jBL -D1c/0.5cv1p -N 
echo 5 3.5 AXIS | gmt text -N 
gmt plot -W1p,- << EOF
>
0 3.5
4 3.5
>
6 3.5
10 3.5
>
5 0
5 3
>
5 4
5 7
EOF
gmt text -Gwhite -N << EOF
2.5 3.5 W
7.5 3.5 E
5 1.75 S
5 5.75 N
EOF
echo 8 -0.5 | gmt plot -Sc0.7c -W2p,red -N 
echo 8 -0.5 ANNOT | gmt text -D-1c/-1cv1p,red -N 
echo 9 0.0 | gmt plot -Sc0.5c -W2p,red -N 
echo 9 0.0 TICK | gmt text -D1c/-1cv1p,red -N 

# 绘制图2
gmt basemap -Ba2f1g1 -BwsEN+t"Figure 2" -X12c 
echo 0 0 | gmt plot -Sc0.3c -Gred -N 
echo 0 0 BASEMAP_ORIGIN | gmt text -F+jBL -D1c/0.5cv1p -N 

gmt end
