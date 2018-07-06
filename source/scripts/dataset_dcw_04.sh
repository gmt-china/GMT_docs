#!/bin/bash
gmt begin dataset_dcw_04 pdf,png
for code in 11 12 13 14 15 21 22 23 31 32 33 34 35 36 37 41 42 43 44 45 46 50 51 52 53 54 61 62 63 64 65 71 91 92;
do
    gmt coast -JM20c -R70/140/15/55 -Baf -ECN.$code+p1p,blue+gred
done
gmt end
