#!/bin/bash
gmt begin GMT_contour-anno7 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+u" m"+f8p -Gl50/10S/160/10S -S10 -T+l
gmt plot -SqD15d:+gblack+fwhite+LD+o+u\\260 -Wthick transect.txt
gmt end
