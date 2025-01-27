gmt begin symbols
gmt makecpt -Chot -T0/3/1
gmt plot -R0/10/0/10 -JX10c/10c -Baf -Sc0.5c -W1p,black -C << EOF
2   3   0
5   6   1
8   2   2
EOF
gmt end show
