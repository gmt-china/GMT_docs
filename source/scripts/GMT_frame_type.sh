#!/bin/bash
J=X1.8i
R=0/5/0/5
PS=GMT_frame_type.ps
X_offset=2.5i

gmt gmtset FONT_TITLE 15p

gmt psxy -J$J -R$R -T -K > $PS

gmt set MAP_FRAME_TYPE plain
gmt psbasemap -J$J -R$R -Bx1+l"plain" -By1 -BWSen -K -O >> $PS

gmt set MAP_FRAME_TYPE inside
gmt psbasemap -J$J -R$R -Bx1 -By1 -BWSen -K -O -X$X_offset >> $PS
gmt pstext -J$J -R$R -F+f16p -K -O -N >> $PS << EOF
2.5 -1.2 inside
EOF

gmt set MAP_FRAME_TYPE graph
gmt psbasemap -J$J -R$R -Bx1+l"graph" -By1 -BWS -K -O -X$X_offset >> $PS

J=M1.8i

gmt set MAP_FRAME_TYPE fancy
gmt psbasemap -J$J -R$R -B1 -K -O -X-3.75i -Y2.8i >> $PS
gmt pstext -J$J -R$R -F+f16p -K -O -N >> $PS << EOF
2.5 -1.2 fancy
EOF

gmt set MAP_FRAME_TYPE fancy+
gmt psbasemap -J$J -R$R -B1 -K -O -X2.5i >> $PS
gmt pstext -J$J -R$R -F+f16p -K -O -N >> $PS << EOF
2.5 -1.2 fancy+
EOF
gmt psxy -J$J -R$R -T -O >> $PS

rm gmt.*
