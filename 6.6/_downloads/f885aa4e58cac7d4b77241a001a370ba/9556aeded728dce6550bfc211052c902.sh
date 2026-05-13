gmt begin anchor-3
gmt colorbar -D0c/0c+w10c/1.5c+h -B0 -Cpolar
gmt basemap -R0/10/0/6 -JX10c/1.5c -B0
gmt text -F+f15p,1,red+c+j -Dj0.5c/0.5c+v2p -N << EOF
TL BR TL
TC BC TC
TR BL TR
ML MR ML
MC MR MC
MR ML MR
BL TR BL
BC TC BC
BR TL BR
EOF

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
gmt end show