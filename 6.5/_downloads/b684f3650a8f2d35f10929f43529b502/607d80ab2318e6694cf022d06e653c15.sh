#!/usr/bin/env bash
gmt begin grdedit_-E
    gmt set MAP_FRAME_TYPE plain FONT_TITLE 18p MAP_TITLE_OFFSET 2p
    gmt subplot begin 1x4 -Fs6c/3c+p1p+w1p -Y15c -B+n
        gmt grdimage @earth_relief_30m -Jx? -B+t"Original" -Cgeo -c
        for mode in a h v; do
            gmt grdedit @earth_relief_30m -E${mode} -Grelief_${mode}.nc
            gmt grdimage relief_${mode}.nc -Rrelief_${mode}.nc -Jx? -B+t"-E${mode}" -Cgeo -c
            rm relief_${mode}.nc
        done
    gmt subplot end
    gmt subplot begin 1x4 -Fs3c/6c -Y-h-4c -X8c
        for mode in l r t; do
            gmt grdedit @earth_relief_30m -E${mode} -Grelief_${mode}.nc
            gmt grdimage relief_${mode}.nc -Rrelief_${mode}.nc -Jx? -B+t"-E${mode}" -Cgeo -c
            rm relief_${mode}.nc
        done
    gmt subplot end
gmt end show
