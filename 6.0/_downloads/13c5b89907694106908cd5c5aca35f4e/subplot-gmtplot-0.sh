#!/usr/bin/env bash
nrow=2
ncol=3
gmt begin subplot png,pdf
gmt subplot begin ${nrow}x${ncol} -Fs5c/3c+d -Blrtb
    for index in $(seq 0 $((nrow*ncol-1))); do
    i=$((index/ncol))
    j=$((index%ncol))
    echo 0.5 0.5 '@;red;'$i,$j'@;;' '(@;blue;'$index'@;;)' | gmt text -R0/1/0/1 -F+f20p -c
    done
gmt subplot end
gmt end show