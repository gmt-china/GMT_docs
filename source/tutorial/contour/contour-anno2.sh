#!/usr/bin/env bash
gmt begin contour_annot2
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
    # -Gn1/1i：每条等值线上只放置1个标注，并且要求等值线的长度不小于1英寸
    gmt grdcontour geoid.nc -B20f10 -BWSne -C10 -A20+f8p -Gn1/1i -T+lLH
gmt end show
