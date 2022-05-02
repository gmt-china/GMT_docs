#!/usr/bin/env bash
gmt begin plot_-Sm
gmt basemap -R0/4/0.5/1.5 -JX6c/3c -Bxa1g1 -Bya0.5g0.5 -BWSen
gmt plot -Sc0.15c -Gblack << EOF
1 1
3 1
EOF
gmt plot -Sm0.2c+b+e+g -Gblack -W0.5p,red << EOF
1 1 1 10 60
EOF
gmt plot -Sm0.2c+b+l -Gblack -W0.5p,blue << EOF
3 1 1 10 150
EOF
gmt end show
