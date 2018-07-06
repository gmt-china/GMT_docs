#!/bin/bash
gmt begin contour_annot1 pdf,png
gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+f8p -Gd1.5i -S10 -T+lLH
gmt end
