#!/bin/bash
PS=GMT_line_cap.ps
R=-0.25/16/-0.5/1.5
J=X15c/2c
line=lines.txt

cat << EOF > $line
0       0
10       0
EOF

gmt psxy -R$R -J$J -B1 -P -K -T > $PS

for cap in butt round square
do
    gmt psxy $line -R -J -K -O -Y0.8c -W8p --PS_LINE_CAP=$cap >> $PS
    echo 10.5 0 $cap | gmt pstext -R -J -F+jML+f12p,8 -K -O >> $PS
done
gmt psxy -R -J -O -T >> $PS

rm lines.txt gmt.history
