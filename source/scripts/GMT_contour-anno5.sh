#!/bin/bash
gmt begin GMT_contour-anno5 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+f8p -GXcross.txt -S10 -T+lLH
gmt end
