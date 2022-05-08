#!/usr/bin/env bash
gmt begin GMT_cycle_1
    gmt plot @mississippi.txt -JX15cT/7c -W0.25p,red -Bxaf -Byaf+l"10@+3@+ m@+3@+/s" \
        -BWSrt+t"Mississippi river daily discharge" -i0,1+s1e-3
gmt end show
