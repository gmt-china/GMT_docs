#!/bin/bash
PS=GMT_line_join.ps
R=0/25/0/10
J=x0.75c/0.75c

gmt psxy -J$J -R$R -K -T > $PS
gmt pstext -J$J -R$R -F+f20p -K -O >> $PS << EOF
5.5  1.5 miter
12 1.5 round
19 1.5 bevel
EOF
gmt psxy -J$J -R$R -W20p -L --PS_LINE_JOIN=miter -K -O >> $PS << EOF
3 3
3 8
8 8
8 3
EOF
gmt psxy -J$J -R$R -W20p -L --PS_LINE_JOIN=round -X5c -K -O >> $PS << EOF
3 3
3 8
8 8
8 3
EOF
gmt psxy -J$J -R$R -W20p -L --PS_LINE_JOIN=bevel -X5c -K -O >> $PS << EOF
3 3
3 8
8 8
8 3
EOF
gmt psxy -J$J -R$R -O -T >> $PS
rm gmt.*
