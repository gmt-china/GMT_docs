#!/usr/bin/env bash
gmt begin map_frame_type
gmt set FONT_TITLE 18p
gmt subplot begin 2x3 -Fs4c/4c -M0.5c/0.8c
gmt basemap -JM? -R0/10/0/10 -Baf -B+t"fancy" -c --MAP_FRAME_TYPE=fancy
gmt basemap -JM? -R0/10/0/10 -Baf -B+t"fancy+" -c --MAP_FRAME_TYPE=fancy+
gmt basemap -JX? -R0/10/0/10 -Baf -BWSen+t"plain" -c --MAP_FRAME_TYPE=plain
gmt basemap -JX? -R0/10/0/10 -Baf -BWSen+t"inside" -c --MAP_FRAME_TYPE=inside
gmt basemap -JX? -R0/10/0/10 -Baf -BWS+t"graph" -c --MAP_FRAME_TYPE=graph
gmt basemap -JX? -R-5/5/-5/5 -Baf -BWS+t"graph-origin" -c --MAP_FRAME_TYPE=graph-origin
gmt subplot end
gmt end show
