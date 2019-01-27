#!/bin/bash
R=150/200/20/50
J=M15c
PS=psxy_-Sf.ps
gmt psbasemap -R$R -J$J -B10 -K > $PS
gmt psxy -R$R -J$J -Sf2c/0.1i+l+b -Gblack -W -K -O >> $PS << EOF
155 30
160 40
EOF
gmt psxy -R$R -J$J -Sf2c/0.1i+l+c -Gblue -W -K -O >> $PS << EOF
165 30
170 40
EOF
gmt psxy -R$R -J$J -Sf2c/0.1i+l+f -Gred -W -K -O >> $PS << EOF
175 30
180 40
EOF
gmt psxy -R$R -J$J -Sf2c/0.3i+l+s+o1 -Gyellow -W -K -O >> $PS << EOF
185 30
190 40
EOF
gmt psxy -R$R -J$J -Sf1c/0.1i+l+t -Gwhite -W -B10 -K -O >> $PS << EOF
195 30
200 40
EOF
gmt psxy -R$R -J$J -T -O >> $PS
rm gmt.*
