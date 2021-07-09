#!/usr/bin/env bash
cat << EOF > t.txt
1 1
2 3
3 2
4 4
EOF
gmt begin plot_-L pdf,png
gmt basemap -R0/5/0/5 -JX3i -B0
gmt plot t.txt -Gred -W2p -L+xl
gmt plot t.txt -Gred -W2p -L+xr -X3.25i
gmt plot t.txt -Gred -W2p -L+x4.5 -X3.25i
gmt plot t.txt -Gred -W2p -L+yt -X-6.5i -Y3.25i
gmt plot t.txt -Gred -W2p -L+yb -X3.25i
gmt plot t.txt -Gred -W2p -L+y4 -X3.25i
gmt end
rm t.txt
