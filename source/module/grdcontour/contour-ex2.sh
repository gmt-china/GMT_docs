#!/usr/bin/env bash
gmt begin alaska_grav2
    gmt grdcontour @AK_gulf_grav.nc -JM16c -C50,150 -A100,+f10p -Baf
gmt end show