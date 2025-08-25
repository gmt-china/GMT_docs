#!/usr/bin/env bash
gmt begin alaska_grav2
    gmt grdcontour @AK_gulf_grav.nc -JM16c -C20,60 -A40,+f10p -Baf
gmt end show