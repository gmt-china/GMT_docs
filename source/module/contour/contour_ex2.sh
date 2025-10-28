#!/usr/bin/env bash
gmt begin contour_ex2
    gmt contour @Table_5_11.txt -A750,800 -W0.5p -Baf
gmt end show