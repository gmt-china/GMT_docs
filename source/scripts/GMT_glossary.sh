#!/bin/bash
PS=GMT_glossary.ps
J=x1c
R=0/28.7/0/20

# 绘制纸张范围
gmt psbasemap -R$R -J$J -B0 -X0.5c -Y0.5c -K > $PS
echo 0 0 | gmt psxy -J$J -R$R -Sc0.3c -Gred -N -K -O >> $PS
echo 0 0 PAPER_ORIGIN | gmt pstext -J$J -R$R -F+jBL -D1c/0.5cv1p -N -K -O >> $PS
gmt psxy -J$J -R$R -W1p,- -K -O >> $PS << EOF
>
2 0
2 2
>
0 2
2 2
EOF

# 绘制图1
R=0/10/0/7
gmt psbasemap -J$J -R$R -Bx1+l"XLABEL" -By1+l"YLABEL" -BWSen+t"Figure 1" -X2c -Y2c -K -O >> $PS
echo 0 0 | gmt psxy -J$J -R$R -Sc0.3c -Gred -N -K -O >> $PS
echo 0 0 BASEMAP_ORIGIN | gmt pstext -J$J -R$R -F+jBL -D1c/0.5cv1p -N -K -O >> $PS
echo 5 3.5 AXIS | gmt pstext -J$J -R$R -N -K -O >> $PS
gmt psxy -J$J -R$R -W1p,- -K -O >> $PS << EOF
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
gmt pstext -J$J -R$R -Gwhite -N -O -K >> $PS << EOF
2.5 3.5 W
7.5 3.5 E
5 1.75 S
5 5.75 N
EOF
echo 8 -0.5 | gmt psxy -J$J -R$R -Sc0.7c -W2p,red -N -K -O >> $PS
echo 8 -0.5 ANNOT | gmt pstext -J$J -R$R -D-1c/-1cv1p,red -N -K -O >> $PS
echo 9 0.0 | gmt psxy -J$J -R$R -Sc0.5c -W2p,red -N -K -O >> $PS
echo 9 0.0 TICK | gmt pstext -J$J -R$R -D1c/-1cv1p,red -N -K -O >> $PS

# 绘制图2
gmt psbasemap -J$J -R$R -Ba2f1g1 -BwsEN+t"Figure 2" -X12c -K -O >> $PS
echo 0 0 | gmt psxy -J$J -R$R -Sc0.3c -Gred -N -K -O >> $PS
echo 0 0 BASEMAP_ORIGIN | gmt pstext -J$J -R$R -F+jBL -D1c/0.5cv1p -N -K -O >> $PS

gmt psxy -J -R -T -O >> $PS
rm gmt.*
