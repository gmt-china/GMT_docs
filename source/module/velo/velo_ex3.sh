#!/usr/bin/env bash

gmt begin velo_ex3
    gmt velo -JX10c/10c -R0/10/0/10 -Sx2c -W1p -Baf << EOF
5 5 0.5 0.3 45
EOF
gmt end show