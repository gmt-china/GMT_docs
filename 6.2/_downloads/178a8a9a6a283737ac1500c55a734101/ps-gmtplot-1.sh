#!/usr/bin/env bash
gmt begin line_join pdf,png
gmt subplot begin 1x3 -Fs5c/5c -B+n
for join in miter round bevel; do
gmt plot -R0/10/0/10 -W20p -L -B0+t"$join" --PS_LINE_JOIN=$join -c << EOF
1 1
1 9
9 9
9 1
EOF
echo 5 11 $join | gmt text -F+f20p -N
done
gmt subplot end
gmt end show