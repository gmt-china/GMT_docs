#!/bin/bash
PS=GMT_basemap_origin.ps
gmt psbasemap -R0/29.7/0/21.0 -Jx1c -Bpg1 -Bsg0.5 -X0i -Y0i --MAP_GRID_PEN_PRIMARY=gray --MAP_GRID_PEN_SECONDARY=thinnest,lightgray,. --MAP_FRAME_TYPE=inside -K > $PS
gmt psbasemap -R0/10/0/10 -JX10c -B1 -B+glightblue -X1i -Y1i -K -O >> $PS
gmt psxy -R -J -O -T >> $PS
rm gmt.*
