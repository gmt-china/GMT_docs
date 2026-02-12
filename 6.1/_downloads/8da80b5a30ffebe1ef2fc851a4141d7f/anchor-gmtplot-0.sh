gmt begin anchor-1 png,pdf
gmt set MAP_TICK_LENGTH_PRIMARY 20p MAP_TICK_PEN_PRIMARY 1p
gmt basemap -R0/10/0/6 -JX10c/6c -BENlb -Bxf5 -Byf3
gmt plot -Sc0.3c -Gred -N << EOF
0 0
0 3
0 6
5 0
5 3
5 6
10 0
10 3
10 6
EOF
gmt text -F+f15p+j -Dj0.5c/0.5c -N << EOF
10 6 ML @%1%T@%%op
10 3 ML @%1%M@%%iddle
10 0 ML @%1%B@%%ottom
0  6 BC @%1%L@%%eft
5  6 BC @%1%C@%%enter
10 6 BC @%1%R@%%ight
EOF
gmt text -F+f15p,1,red+c+j -Dj0.5c/0.5c+v2p << EOF
TL TL TL
TC TC TC
TR TR TR
ML ML ML
MC BL MC
MR MR MR
BL BL BL
BC BC BC
BR BR BR
EOF
gmt end