#!/bin/bash
gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_contour-anno7.ps
gmt grdcontour geoid.nc -J -O -K -B20f10 -BWSne -C10 -A20+d+u" m"+f8p -Gl50/10S/160/10S -S10 -T+l >> GMT_contour-anno7.ps
gmt psxy -R -J -O -SqD15d:+gblack+fwhite+LD+o+u\\260 -Wthick transect.txt >> GMT_contour-anno7.ps
rm gmt.*
