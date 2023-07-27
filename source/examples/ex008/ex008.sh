#!/usr/bin/env bash

cat > testline1.txt << EOF
>
7.8 50.4
7.8 50.6
8.1 50.6
8.1 50.4
7.8 50.4
EOF

cat > testline2.txt << EOF
>
8   50
9.5 50.5
EOF

cat > testline3.txt << EOF
>
9   49.6
9   50
9.8 50
9.8 49.8
9.4 49.8
9.4 49.6
EOF

gmt spatial testline1.txt -Sb0.05 > testline1_buffer.txt
gmt spatial testline2.txt -Sb0.05 > testline2_buffer.txt
gmt spatial testline3.txt -Sb0.05 > testline3_buffer.txt

gmt begin buffer png
  gmt basemap -R7.5/10/49.5/51 -JX15c -B
    
  gmt plot testline1.txt -W1p,green
  gmt plot testline1_buffer.txt -W1p,red

  gmt plot testline2.txt -W1p,green
  gmt plot testline2_buffer.txt -W1p,red

  gmt plot testline3.txt -W1p,green
  gmt plot testline3_buffer.txt -W1p,red
gmt end show
