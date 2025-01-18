#!/usr/bin/env bash
gmt begin segy1
    gmt segy XB1-Z.sgy -JX5i/-5i -R0/40/0/3 -Baf -D1 -C3 -N -W
gmt end show
