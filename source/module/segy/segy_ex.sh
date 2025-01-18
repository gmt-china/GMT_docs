#!/usr/bin/env bash
gmt begin segy1
    gmt basemap -JX5i/-5i -R0/32/0/3 -Bxaf+ltraces -Byaf+l"t (s)"
    gmt segy XB1-Z.sgy -D0.5 -N -W
gmt end show
