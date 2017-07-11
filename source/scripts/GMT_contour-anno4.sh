#!/bin/bash
gmt pscoast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -K -P > GMT_contour-anno4.ps
gmt grdcontour geoid.nc -J -O -B20f10 -BWSne -C10 -A20+d+f8p -GLZ-/Z+ -S10 -T+lLH >> GMT_contour-anno4.ps
rm gmt.*
