#!/usr/bin/env bash
gmt begin GMT_cycle_2 pdf,png
    gmt plot @mississippi.txt -R0/1/0/50 -JX15c/7c -W0.25p,red -Bxaf -Byaf+l"10@+3@+ m@+3@+/s" \
        -BWSrt+t"Mississippi river annual discharge" -i0,1+s1e-3 -wy
gmt end show
