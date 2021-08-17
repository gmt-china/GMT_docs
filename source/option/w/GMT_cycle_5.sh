#!/usr/bin/env bash
gmt begin GMT_cycle_5 pdf,png
    gmt xyz2grd @mississippi.txt -i0,1+s1e-3,1+s1e-3 -wy -R0/1/0/50 -I50+n -r -Gtmp.grd
    gmt grdimage tmp.grd -JX15c/8c -BWSen -Bxaf+l"Normalized year" -Byaf+l"Discharge (10@+3@+ m@+3@+/s)"
    gmt colorbar -DJRM -Baf
gmt end show
