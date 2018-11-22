#!/bin/bash

gmt begin XY pdf,png

gmt basemap -JX5c/2c -R0/5/0/2 -B1
gmt text -F+f40p << EOF
2.5 1 1
EOF

gmt basemap -B1 -X7c
gmt text -F+f40p << EOF
2.5 1 2
EOF

gmt basemap -B1 -X-7c -Y4c
gmt text -F+f40p << EOF
2.5 1 3
EOF

gmt basemap -B1 -X7c
gmt text -F+f40p << EOF
2.5 1 4
EOF

gmt end
