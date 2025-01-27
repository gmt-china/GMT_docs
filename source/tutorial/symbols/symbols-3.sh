gmt begin symbols
gmt plot -R0/10/0/10 -JX10c/10c -Baf -Sc -W1p,black -Gred << EOF
2 3 0.3
5 6 0.8
8 2 0.5
EOF
gmt end show
