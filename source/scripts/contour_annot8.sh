#!/bin/bash
gmt begin contour_annot8 pdf,png
gmt convert -i0,1,4 -Em150 transect.txt | gawk  '{print $1,$2,int($3)}' > fix2.txt
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+u" m"+f8p -Gl50/10S/160/10S -S10 -T+l
gmt plot -Sqffix2.txt:+g+an+p+Lf+u" m"+f8p -Wthick transect.txt
gmt end