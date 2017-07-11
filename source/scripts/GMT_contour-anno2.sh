#!/bin/bash
gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_contour-anno2.ps
gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gn1/1i -S10 -T+lLH >> GMT_contour-anno2.ps
rm gmt.*
