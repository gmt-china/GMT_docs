#!/bin/bash
PS=psmeca_ex1.ps

gmt pscoast -Rg -JQ10i -Bx60 -By30 -A10000 -Wthin -G200 -K > $PS
gmt psmeca -R -J -Sc1/12/0.2 -C0.5pP2p -Egrey -Gred -L1p -W1p -O << EOF >> $PS
-176.96 -29.25 47.8 202 30 93 18 60 88 9.56 26 -160 -10 010176A
EOF
rm gmt.*
