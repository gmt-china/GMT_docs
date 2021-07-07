#!/usr/bin/env bash
gmt begin contour_annot6 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+f8p -Gl50/10S/160/10S -S10 -T+l
gmt plot -SqD1000k:+g+LD+an+p -Wthick transect.txt
gmt end
