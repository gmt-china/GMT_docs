#!/usr/bin/env bash
gmt begin line_cap pdf,png
for cap in butt round square; do
gmt plot -JX15c/2c -R-0.25/16/-0.5/1.5 -Y0.8c -W8p --PS_LINE_CAP=$cap << EOF
0       0
10       0
EOF
echo 10.5 0 $cap | gmt text -F+jML+f12p,8
done
gmt end