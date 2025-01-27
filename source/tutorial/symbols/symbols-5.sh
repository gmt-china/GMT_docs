gmt begin symbols
gmt basemap -R0/10/0/10 -JX10c/10c -Baf
gmt plot -S0.5c -W1p,black -Gred << EOF
2 3 c
5 6 t
8 2 i
EOF
gmt end show