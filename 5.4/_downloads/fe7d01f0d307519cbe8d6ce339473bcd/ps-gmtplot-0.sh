#!/bin/bash
PS=ps_line_cap.ps
gmt psxy -JX15c/2c -R-0.25/16/-0.5/1.5 -W8p --PS_LINE_CAP=butt -K > $PS << EOF
0       0
10      0
EOF
echo 10.5 0 butt | gmt pstext -J -R -F+jML+f12p,8 -K -O >> $PS

gmt psxy -JX15c/2c -R-0.25/16/-0.5/1.5 -W8p --PS_LINE_CAP=round -Y0.8c -K -O >> $PS << EOF
0       0
10      0
EOF
echo 10.5 0 round | gmt pstext -J -R -F+jML+f12p,8 -K -O >> $PS

gmt psxy -JX15c/2c -R-0.25/16/-0.5/1.5 -W8p --PS_LINE_CAP=square -Y0.8c -K -O >> $PS << EOF
0       0
10      0
EOF
echo 10.5 0 square | gmt pstext -J -R -F+jML+f12p,8 -K -O >> $PS
gmt psxy -J -R -T -O >> $PS
rm gmt.*
