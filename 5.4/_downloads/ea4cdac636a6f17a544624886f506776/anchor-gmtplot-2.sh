PS=anchor-3.ps
gmt psbasemap -R0/10/0/6 -JX10c/1.5c -B0 -K > $PS
gmt psscale -J -R -D0c/0c+w10c/1.5c+h -B0 -Cpolar -K -O >> $PS
gmt pstext -J -R -F+f15p,1,red+j -Dj0.5c/0.5c+v2p -N -K -O >> $PS << EOF
0 6 BR TL
5 6 BC TC
10 6 BL TR
0 3 MR ML
5 3 MR MC
10 3 ML MR
0 0 TR BL
5 0 TC BC
10 0 TL BR
EOF

gmt psxy -J -R -Sc0.3c -Gred -N -O >> $PS << EOF
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