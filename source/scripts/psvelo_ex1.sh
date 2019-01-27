#!/bin/bash
ps=psvelo_ex1.ps

# 左边三个符号
gmt psvelo << EOF -Xc -JM15c -R241/242/34/35 -B0.5 -BWeSn+tpsvelo \
    -Sw3c/1.e7 -W1p -G60 -E210 -D2 -P -K > $ps
# lon     lat    spin(rad/yr) spin_sigma (rad/yr)
241.2 34.2  5.65E-08 1.17E-08
241.2 34.5 -4.85E-08 1.85E-08
241.2 34.7  4.46E-09 3.07E-08
EOF

# 右边三个符号
gmt psvelo -J -R -Sw3c/1.e7 -W1p -D2 -O -K << EOF >> $ps
# lon     lat    spin(rad/yr) spin_sigma (rad/yr)
241.7 34.2  5.65E-08 1.17E-08
241.7 34.5 -4.85E-08 1.85E-08
241.7 34.7  4.46E-09 3.07E-08
EOF
gmt pscoast -O -R -J -W1p -Di >> $ps
rm gmt.*
