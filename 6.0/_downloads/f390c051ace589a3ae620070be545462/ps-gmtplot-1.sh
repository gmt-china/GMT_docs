#!/bin/bash
gmt begin line_join pdf,png
gmt text -Jx0.75c/0.75c -R0/25/0/10 -F+f20p  << EOF
5.5  1.5 miter
12 1.5 round
19 1.5 bevel
EOF
gmt plot -W20p -L --PS_LINE_JOIN=miter  << EOF
3 3
3 8
8 8
8 3
EOF
gmt plot -W20p -L --PS_LINE_JOIN=round -X5c  << EOF
3 3
3 8
8 8
8 3
EOF
gmt plot -W20p -L --PS_LINE_JOIN=bevel -X5c  << EOF
3 3
3 8
8 8
8 3
EOF
gmt end
