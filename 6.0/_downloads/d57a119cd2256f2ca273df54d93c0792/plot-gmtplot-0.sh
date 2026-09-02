#!/bin/bash
p1="30 -50"
p2="200 45"
gmt begin plot_-A pdf,png
gmt basemap -JM15c -R0/220/-60/60 -Bx60 -By30
gmt plot -W2p << EOF
$p1
$p2
EOF
gmt plot -A -W2p,red << EOF
$p1
$p2
EOF
gmt plot -Ap -W2p,blue << EOF
$p1
$p2
EOF
gmt plot -Am -W2p,yellow << EOF
$p1
$p2
EOF
gmt end
