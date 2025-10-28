#!/usr/bin/env bash
gmt begin contour_ex1
    gmt contour @Table_5_11.txt -Wthin -C25 -A50 -Baf
gmt end show