#!/bin/bash
gmt begin text_justification pdf,png
gmt text -R0/10/0/2 -Jx2c -B1g1 -BWS -F+j+f20p,blue << EOF
1 1 LT LT
2 1 LM LM
3 1 LB LB
4 1 CT CT
5 1 CM CM
6 1 CB CB
7 1 RT RT
8 1 RM RM
9 1 RB RB
EOF
gmt end