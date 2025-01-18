#!/usr/bin/env bash
gmt begin segy1
    gmt segy XB1-Z.sgy -JX5i/-5i -R0/30/0/10 -Baf -D -N -W
gmt end show
