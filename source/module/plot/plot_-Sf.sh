#!/usr/bin/env bash
gmt begin plot_-Sf pdf,png
gmt basemap -R150/200/20/50 -JM15c -B10
gmt plot -Sf2c/0.1i+l+b -Gblack -W << EOF
155 30
160 40
EOF
gmt plot -Sf2c/0.1i+l+c -Gblue -W << EOF
165 30
170 40
EOF
gmt plot -Sf2c/0.1i+l+f -Gred -W << EOF
175 30
180 40
EOF
gmt plot -Sf2c/0.3i+l+s+o1 -Gyellow -W << EOF
185 30
190 40
EOF
gmt plot -Sf1c/0.1i+l+t -Gwhite -W -B10 << EOF
195 30
200 40
EOF
gmt end
