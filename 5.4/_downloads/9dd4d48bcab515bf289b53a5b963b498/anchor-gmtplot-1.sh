PS=anchor-2.ps
gmt psbasemap -Rg -JH10c -B0 -P -K > $PS
gmt pstext -J -R -F+f15p,1,red+j -Dj0.5c/0.5c+v2p -N -K -O >> $PS << EOF
0 6 TL TL
5 6 TC TC
10 6 TR TR
0 3 ML ML
5 3 BL MC
10 3 MR MR
0 0 BL BL
5 0 BC BC
10 0 BR BR
EOF

gmt psxy -R0/10/0/6 -JX10c/5c -Sc0.3c -Gred -N -O >> $PS << EOF
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