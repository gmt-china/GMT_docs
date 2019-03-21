gmt begin B-axes png,pdf
gmt set FONT_TITLE 20p MAP_FRAME_PEN 3p
gmt basemap -R0/4/0/4 -JX8c -BWSEN+t"2D Basemap"
gmt text -F+f15p,9 -Glightblue@30 -N << EOF
0 2 W,w,l
4 2 E,e,r
2 4 N,n,t
2 0 S,s,b
EOF

gmt basemap -R0/4/0/4/0/4 -JX5c -JZ5c -Bwsenz1234+b+t"3D Basemap" -X12c -p130/30
gmt text -F+f15p,9 -JZ -Glightblue@30 -Z -N -p << EOF
0 2 0 W,w,l
4 2 0 E,e,r
2 4 0 N,n,t
2 0 0 S,s,b
0 0 2 Z,z,u,1
4 0 2 2
4 4 2 3
0 4 2 4
0 2 4 +b
EOF
gmt end
