#!/bin/bash
gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_contour-anno1.ps
gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+f8p -Gd1.5i -S10 -T+lLH >> GMT_contour-anno1.ps
rm gmt.*
