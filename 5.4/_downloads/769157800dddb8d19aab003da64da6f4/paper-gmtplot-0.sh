#!/bin/bash
gmt psxy -R0/2.5/0/1.7 -Jx1i -P -K -Glightyellow -Wthinner << EOF > GMT_-P.ps
>
0	0
1	0
1	1.3
0	1.3
>
1.25	0
1.25	1
2.55	1
2.55	0
EOF
gmt pstext -R -J -O -K -N -F+f+a+j << EOF >> GMT_-P.ps
0.5	0.65	10p,Helvetica-Bold	0	CM	Portrait
1.95	0.65	10p,Helvetica-Bold	0	CM	Landscape
0.8	0.15	9p,Helvetica-Oblique	0	BL	x
0.15	1.1	9p,Helvetica-Oblique	0	BL	y
2.1	0.15	9p,Helvetica-Oblique	0	BL	x
1.45	0.75	9p,Helvetica-Oblique	0	BL	y
EOF
gmt psxy -R -J -O -Sv0.04i+e -W0.5p -Gblack << EOF >> GMT_-P.ps
0.1	0.1	0	1.4
0.1	0.1	90	2
1.35	0.1	0	2.0
1.35	0.1	90	1.4
EOF
