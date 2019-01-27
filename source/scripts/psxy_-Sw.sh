#!/bin/bash
R=0/10/0/5
J=x1c
PS=psxy_-Sw.ps
gmt psbasemap -R$R -J$J -Ba1g1 -K > $PS
gmt psxy -R$R -J$J -Sw2c -Glightblue -K -O >> $PS << EOF
2 2 0 45
EOF

gmt psxy -R$R -J$J -SW3c -Glightblue -K -O >> $PS << EOF
6 2 0 45
EOF
gmt psxy -R$R -J$J -T -O >> $PS

rm gmt.*
