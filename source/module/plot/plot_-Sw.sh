#!/usr/bin/env bash
gmt begin plot_-Sw
gmt basemap -R0/10/0/5 -Jx1c -Ba1g1
gmt plot -Sw2c -Glightblue << EOF
2 2 0 45
EOF
gmt plot -SW3c -Glightblue << EOF
6 2 0 45
EOF
gmt end
