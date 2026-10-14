#!/bin/bash

gmt begin XY pdf,png

gmt basemap -JX5c/2c -R0/5/0/2 -B1
echo 1 | gmt text -F+f40p+cMC

gmt basemap -B1 -X7c
echo 2 | gmt text -F+f40p+cMC

gmt basemap -B1 -X-7c -Y4c
echo 3 | gmt text -F+f40p+cMC

gmt basemap -B1 -X7c
echo 4 | gmt text -F+f40p+cMC

gmt end
