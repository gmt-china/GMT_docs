gmt begin symbols
gmt basemap -R1/15/0/2 -Jx1c -B+n
gmt plot -S -W1p << EOF
1 1 0.5c -
2 1 0.5c +
3 1 0.5c a
4 1 0.5c c
5 1 0.5c d
6 1 45 0.5c 0.3c e
7 1 0.5c g
8 1 0.5c h
9 1 0.5c i
10 1 0.5c n
11 1 0.75 0.5 r
12 1 0.5c s
13 1 0.5c t
14 1 0.5c x
15 1 0.5c y
EOF
gmt text -F+f10p,9 -D0c/-0.7c -N << EOF
1 1 -S-
2 1 -S+
3 1 -Sa
4 1 -Sc
5 1 -Sd
6 1 -Se
7 1 -Sg
8 1 -Sh
9 1 -Si
10 1 -Sn
11 1 -Sr
12 1 -Ss
13 1 -St
14 1 -Sx
15 1 -Sy
EOF
gmt end show
