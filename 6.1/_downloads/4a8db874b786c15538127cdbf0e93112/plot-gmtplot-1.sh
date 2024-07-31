#!/bin/bash
gmt begin plot_symbols pdf,png
gmt plot -JX20c/2c -R0.5/13.5/0/4 -B1 -BS -S0.5c << EOF
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
gmt text -F+f15p,9 << EOF
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
gmt end
