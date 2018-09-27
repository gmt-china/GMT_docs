#!/bin/bash
cat << EOF > fix.txt
80      -8.5
55      -7.5
102     0
130     10.5
EOF
gmt begin contour_annot3 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+f8p -Gffix.txt/0.1i -S10 -T+lLH 
gmt end