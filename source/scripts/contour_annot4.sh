#!/bin/bash
gmt begin contour_annot4 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+d+f8p -GLZ-/Z+ -S10 -T+lLH 
gmt end
