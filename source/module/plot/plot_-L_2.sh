#!/usr/bin/env bash
cat << EOF > t.txt
1 1 2 4
2 3 2 3
3 2 3 2
4 4 1 1
EOF
cmd='t.txt -R0/5/-2/8 -JX5c -W2p -Ba1f1 -Glightred'
gmt begin plot_-L_2
gmt plot $cmd -BWStr+t"-L\053d" -L+d
gmt plot $cmd -BWStr+t"-L\053D" -L+D -X6c
gmt plot $cmd -BWStr+t"-L\053b" -L+b -X6c
gmt end
rm t.txt
