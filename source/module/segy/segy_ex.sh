#!/usr/bin/env bash
gmt begin segy1
    gmt segy XB1-Z.sgy -JX5i/-5i -R0/2/0/3 -Baf -D1 -C3 -So -N -W
gmt end show
