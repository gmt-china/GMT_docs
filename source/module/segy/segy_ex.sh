#!/usr/bin/env bash
gmt begin segy1
    gmt segy XB1-Z.sgy -JX5i/-5i -R0/100/0/10 -D1 -C3 -N -So -W -Fblack
gmt end show
