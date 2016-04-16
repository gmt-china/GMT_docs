#!/bin/bash
gmt psbasemap -R10/70/-3/8 -JX8c/5c -Bx10 -By3 -B+t"Linear X-Y Plot" > GMT_tutor1_1.ps
rm gmt.*
