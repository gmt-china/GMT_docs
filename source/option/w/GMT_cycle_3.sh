#!/usr/bin/env bash
gmt begin GMT_cycle_3 pdf,png
    gmt histogram @mississippi.txt -R-3/9/0/8 -JX15c/7c -T1 -Gred -W1p -Bxaf -Byaf+l"10@+6@+ m@+3@+/s" \
        -BWSrt+t"Average monthly discharge" -Z0+w -i0,1+s1e-6 -wa
gmt end show
