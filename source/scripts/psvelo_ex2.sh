#!/bin/bash
ps=psvelo_ex2.ps

gmt psvelo -R-10/10/-10/10 -Wthin,red \
	-Se0.2c/0.39/12 -B1g1 -BWeSn -Jx0.2i -Ggreen -Eblue -L -N \
	-A1c+p3p+e -K << EOF > $ps
# Long.   Lat.   Evel   Nvel   Esig   Nsig  CorEN SITE
# (deg)  (deg)    (mm/yr)        (mm/yr)
   -8.    0.     5.0    0.0     4.0    6.0  0.500  4x6
   -5.    0.     0.0    5.0     4.0    6.0  0.500  4x6
   -5.    5.    -5.0    0.0     4.0    6.0  0.500  4x6
   -8.    5.     0.0   -5.0     0.0    0.0  0.500  4x6
   -1.    5.     3.0    3.0     1.0    1.0  0.100  3x3
EOF

gmt psvelo -Se0.2c/0.39/14 -R -J -A0.25c+p0.25p+e -O << EOF >> $ps
# Long.   Lat.   Evel   Nvel   Esig   Nsig  CorEN SITE
# (deg)  (deg)    (mm/yr)        (mm/yr)
   0.    -8.     0.0    0.0     4.0    6.0  0.100  4x6
  -8.     5.     3.0    3.0     0.0    0.0  0.200  3x3
   0.     0.     4.0    6.0     4.0    6.0  0.300
  -5.    -5.     6.0    4.0     6.0    4.0  0.400  6x4
   5.     0.    -6.0    4.0     6.0    4.0 -0.300  -6x4
   0.    -5.     6.0   -4.0     6.0    4.0 -0.500  6x-4
EOF
rm gmt.*
