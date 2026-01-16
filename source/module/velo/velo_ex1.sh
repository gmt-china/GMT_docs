#!/usr/bin/env bash

gmt begin velo_ex1
gmt velo -R-10/10/-10/10 -W0.6p,red -Egreen -L -Se0.2/0.39/18 -B1g1 -Jx0.4/0.4 -A0.3c+p1p+e+gred << EOF
#Long. Lat. Evel Nvel Esig Nsig CorEN SITE
#(deg) (deg) (mm/yr) (mm/yr)
0. -8. 0.0 0.0 4.0 6.0 0.500 4x6
-8. 5. 3.0 3.0 0.0 0.0 0.500 3x3
0. 0. 4.0 6.0 4.0 6.0 0.500
-5. -5. 6.0 4.0 6.0 4.0 0.500 6x4
5. 0. -6.0 4.0 6.0 4.0 -0.500 -6x4
0. -5. 6.0 -4.0 6.0 4.0 -0.500 6x-4
EOF
gmt end show
