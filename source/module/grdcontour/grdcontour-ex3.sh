#!/usr/bin/env bash
gmt begin alaska_grav3
    # -Wathick,red 将有标注的等值线设置为粗红线
    # -Wcthinnest,blue,- 将无标注的等值线设置为蓝色的细短划线
    gmt grdcontour @AK_gulf_grav.nc -JM16c -C10 -A50 -Baf -B+t"Gravity Anomalies" -Wathick,red -Wcthinnest,blue,-
gmt end show