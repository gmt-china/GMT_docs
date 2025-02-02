gmt begin symbols
gmt makecpt -Chot -T0/3/1
gmt plot -R0/10/0/10 -JX10c/10c -Baf -S -W1p,black -C << EOF
2   3   0   0.3 c
5   6   1   0.8 t
8   2   2   0.5 i
EOF
gmt end show