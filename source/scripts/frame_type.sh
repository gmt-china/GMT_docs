#!/bin/bash
J=X1.8i
R=0/5/0/5
X_offset=2.5i

gmt begin frame_type pdf,png
gmt set FONT_TITLE 15p

gmt set MAP_FRAME_TYPE plain
gmt basemap -J$J -R$R -Bx1+l"plain" -By1 -BWSen 

gmt set MAP_FRAME_TYPE inside
gmt basemap -J$J -R$R -Bx1 -By1 -BWSen -X$X_offset 
gmt text -J$J -R$R -F+f16p -N  << EOF
2.5 -1.2 inside
EOF

gmt set MAP_FRAME_TYPE graph
gmt basemap -J$J -R$R -Bx1+l"graph" -By1 -BWS -X$X_offset 

J=M1.8i

gmt set MAP_FRAME_TYPE fancy
gmt basemap -J$J -R$R -B1 -X-3.75i -Y2.8i 
gmt text -J$J -R$R -F+f16p -N  << EOF
2.5 -1.2 fancy
EOF

gmt set MAP_FRAME_TYPE fancy+
gmt basemap -J$J -R$R -B1 -X2.5i 
gmt text -J$J -R$R -F+f16p -N  << EOF
2.5 -1.2 fancy+
EOF
gmt end