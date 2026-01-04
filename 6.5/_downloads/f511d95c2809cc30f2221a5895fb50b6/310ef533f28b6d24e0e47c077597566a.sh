#!/usr/bin/env bash
gmt begin B_afg
gmt basemap -R-1/2/0/0.5 -JX6c/1c -Ba1f15mg5m -BS
gmt plot -Sv1p+e+a60 -W0.5p -Gblack -Y-0.35i -N << EOF
-0.5 0 0 1.0
-0.5 0 180 1.0
0.375 0 0 0.25
0.375 0 180 0.25
1.29166666 0 0 0.08
1.29166666 0 180 0.08
EOF
gmt text -F+f9p+jCB << EOF
-0.5 0.05 annotation
0.375 0.05 frame
1.29166666 0.05 grid
EOF
gmt end show
