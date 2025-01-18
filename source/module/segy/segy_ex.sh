#!/usr/bin/env bash
gmt begin segy1
    gmt basemap -JX5i/-5i -R0/33/0/3 -Bxaf+ltraces -Byaf+l"t (s)"
    gmt segy XB1-Z.sgy -D0.1 -N -W
gmt end show
