#!/bin/bash
PS=GMT_-B_afg.ps
gmt psbasemap -R-1/2/0/0.5 -JX6c/1c -Ba1f15mg5m -BS -K -P > $PS
gmt psxy -R -J -O -K -Sv1p+e+a60 -W0.5p -Gblack -Y-0.35i -N << EOF >> $PS
-0.5 0 0 1.0
-0.5 0 180 1.0
0.375 0 0 0.25
0.375 0 180 0.25
1.29166666 0 0 0.08
1.29166666 0 180 0.08
EOF
gmt pstext -R -J -O -F+f9p+jCB << EOF >> $PS
-0.5 0.05 annotation
0.375 0.05 frame
1.29166666 0.05 grid
EOF
rm gmt.*
