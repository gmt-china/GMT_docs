#!/bin/bash
PS=simple_symbols.ps
gmt psxy -JX20c/2c -R0.5/13.5/0/4 -S0.5c -W1p -K > $PS << EOF
 1 3 -
 2 3 +
 3 3 a
 4 3 c
 5 3 d
 6 3 g
 7 3 h
 8 3 i
 9 3 n
10 3 s
11 3 t
12 3 x
13 3 y
EOF
gmt pstext -J$J -R$R -F+f15p,9 -O >> $PS << EOF
 1 1 -S-
 2 1 -S+
 3 1 -Sa
 4 1 -Sc
 5 1 -Sd
 6 1 -Sg
 7 1 -Sh
 8 1 -Si
 9 1 -Sn
10 1 -Ss
11 1 -St
12 1 -Sx
13 1 -Sy
EOF

rm gmt.*
