#!/bin/bash
gmt begin map_frame_type pdf,png
gmt set FONT_TITLE 18p

gmt subplot begin 1x5 -Fs4c/4c -M0.5c/0.2c

gmt basemap -JM -R0/10/0/10 -Baf -B+t"fancy" -c1,1 --MAP_FRAME_TYPE=fancy

gmt basemap -Baf -B+t"fancy\053" -c1,2 --MAP_FRAME_TYPE=fancy+

gmt basemap -JX -R0/10/0/10 -Bxaf -BWSen+t"plain" -c1,3 --MAP_FRAME_TYPE=plain

gmt basemap -Baf -BWSen -c1,4 --MAP_FRAME_TYPE=inside
gmt text -F+f18p -N << EOF
5 12 inside
EOF

gmt basemap -Baf -BWS+t"graph" -c1,5 --MAP_FRAME_TYPE=graph

gmt subplot end
gmt end
