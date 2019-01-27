#!/bin/bash
ps=psxy_-L.ps
cat << EOF > t.txt
1 1
2 3
3 2
4 4
EOF
gmt psxy -R0/5/0/5 -JX3i -K -B0 t.txt -Gred -W2p -L+xl > $ps
gmt psxy -R -J -O -K -B0 t.txt -Gred -W2p -L+xr -X3.25i >> $ps
gmt psxy -R -J -O -K -B0 t.txt -Gred -W2p -L+x4.5 -X3.25i >> $ps
gmt psxy -R -J -O -K -B0 t.txt -Gred -W2p -L+yt -X-6.5i -Y3.25i >> $ps
gmt psxy -R -J -O -K -B0 t.txt -Gred -W2p -L+yb -X3.25i >> $ps
gmt psxy -R -J -O -K -B0 t.txt -Gred -W2p -L+y4 -X3.25i >> $ps
gmt psxy -R -J -O -T >> $ps
rm gmt.* t.txt
