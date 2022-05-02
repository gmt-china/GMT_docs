#!/usr/bin/env bash
cat << EOF > t.txt
1 1
2 3
3 2
4 4
EOF
cmd='t.txt -R0/5/0/5 -JX5c -W2p -Ba1f1 -Glightred'
gmt begin plot_-L_3
gmt plot $cmd -BWStr+t"-L\053xl" -L+xl
gmt plot $cmd -BWStr+t"-L\053xr" -L+xr -X6c
gmt plot $cmd -BWStr+t"-L\053x4.5" -L+x4.5 -X6c
gmt plot $cmd -BWStr+t"-L\053yt" -L+yt -X-12c -Y-6.5c
gmt plot $cmd -BWStr+t"-L\053yb" -L+yb -X6c
gmt plot $cmd -BWStr+t"-L\053y4" -L+y4 -X6c
gmt end
rm t.txt
