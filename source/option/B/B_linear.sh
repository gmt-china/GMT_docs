#!/usr/bin/env bash
gmt begin B_linear pdf,png
gmt basemap -R0/12/0/0.95 -JX3i/0.3i -Ba4f2g1+lFrequency+u" %" -BS
gmt plot -Sv2p+e+a60 -W0.5p -Gblack -Y0.1i -N << EOF
2 0 0 0.5i
2 0 180 0.5i
7 0 0 0.25i
7 0 180 0.25i
9.5 0 0 0.125i
9.5 0 180 0.125i
EOF
gmt text -Gwhite -C0.01i/0.01i -F+f9p+jCB << EOF
2 0.2 annotation
7 0.2 frame
9.5 0.2 grid
EOF
gmt end
