#!/bin/bash
gmt begin GMT_tutor1_1 pdf,png
gmt basemap -R10/70/-3/8 -JX8c/5c -Bx10 -By3 -B+t"Linear X-Y Plot" 
gmt end
