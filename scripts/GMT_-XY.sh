#!/bin/bash
PS=GMT_-XY.ps
J=X5c/5c
R=0/5/0/5

gmt psbasemap -J$J -R$R -B1 -K > $PS
gmt pstext -J$J -R$R -F+f40p -K -O >> $PS << EOF
2.5 2.5 1
EOF
gmt psbasemap -J$J -R$R -B1 -K -O -X7c >> $PS
gmt pstext -J$J -R$R -F+f40p -K -O >> $PS << EOF
2.5 2.5 2
EOF
gmt psbasemap -J$J -R$R -B1 -K -O -X-7c -Y7c >> $PS
gmt pstext -J$J -R$R -F+f40p -K -O >> $PS << EOF
2.5 2.5 3
EOF
gmt psbasemap -J$J -R$R -B1 -K -O -X7c >> $PS
gmt pstext -J$J -R$R -F+f40p -O >> $PS << EOF
2.5 2.5 4
EOF
rm gmt.*
