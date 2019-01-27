#!/bin/bash
R=0/4/0.5/1.5
J=X6c/3c
PS=psxy_-Sm.ps

gmt psbasemap -R$R -J$J -Bxa1g1 -Bya0.5g0.5 -BWSen -K > $PS
gmt psxy -R$R -J$J -Sc0.15c -Gblack -K -O >> $PS << EOF
1 1
3 1
EOF
gmt psxy -R$R -J$J -Sm0.2c+b+e+g -Gblack -W0.5p,red -K -O >> $PS << EOF
1 1 1 10 60
EOF
gmt psxy -R$R -J$J -Sm0.2c+b+l -Gblack -W0.5p,blue -K -O >> $PS << EOF
3 1 1 10 150
EOF
gmt psxy -R$R -J$J -T -O >> $PS

rm gmt.*
