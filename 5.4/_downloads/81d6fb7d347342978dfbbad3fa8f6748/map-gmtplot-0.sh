#!/bin/bash
PS=map_frame_type.ps
gmt set FONT_TITLE 18p
gmt psbasemap -JM4c -R0/10/0/10 -Baf -B+t"fancy" --MAP_FRAME_TYPE=fancy -K > $PS
gmt psbasemap -J -R -Baf -B+t'fancy+' --MAP_FRAME_TYPE=fancy+ -K -O -X6.5c >> $PS
gmt psbasemap -JX4c -R0/10/0/10 -Bxaf -BWSen+t"plain" --MAP_FRAME_TYPE=plain -K -O -X5.5c >> $PS
gmt psbasemap -J -R -Baf -BWSen --MAP_FRAME_TYPE=inside -K -O -X5c >> $PS
gmt pstext -J -R -F+f18p -N -K -O >> $PS << EOF
5 12 inside
EOF
gmt psbasemap -J -R -Baf -BWS+t"graph" --MAP_FRAME_TYPE=graph -O -X5.5c >> $PS
rm gmt.*
