#!/bin/bash
J=M15c
R=0/220/-60/60
PS=psxy_-A.ps
p1="30 -50"
p2="200 45"
gmt psbasemap -J$J -R$R -Bx60 -By30 -K > $PS
gmt psxy -J$J -R$R -W2p -K -O >> $PS << EOF
$p1
$p2
EOF
gmt psxy -J$J -R$R -A -K -O -W2p,red >> $PS << EOF
$p1
$p2
EOF
gmt psxy -J$J -R$R -Ap -K -O -W2p,blue >> $PS << EOF
$p1
$p2
EOF
gmt psxy -J$J -R$R -Am -K -O -W2p,yellow >> $PS << EOF
$p1
$p2
EOF

gmt psxy -J$J -R$R -T -O >> $PS
rm gmt.*
