#!/bin/bash
line=lines.txt

cat << EOF > $line
0       0
10       0
EOF

gmt begin GMT_line_cap pdf,png
gmt plot -JX15c/2c -R-0.25/16/-0.5/1.5 -T 

for cap in butt round square
do
    gmt plot $line -Y0.8c -W8p --PS_LINE_CAP=$cap 
    echo 10.5 0 $cap | gmt text -F+jML+f12p,8 
done
rm lines.txt
gmt end

