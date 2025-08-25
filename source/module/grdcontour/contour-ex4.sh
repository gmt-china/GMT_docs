#!/usr/bin/env bash
gmt begin alaska_grav4
    # -Ln -Wathick,blue -Wcthinnest,blue,- 将负值等值线设置为蓝色
    gmt grdcontour @AK_gulf_grav.nc -JM16c -C10 -A50 -Baf -B+t"Gravity Anomalies" -Ln -Wathick,blue -Wcthinnest,blue,-
    # -Lp -Wathick,red -Wcthinnest,red,- 正值等值线设置为红色
    gmt grdcontour @AK_gulf_grav.nc -C10 -A50 -Lp -Wathick,red -Wcthinnest,red,-
    # 0等值线设置为黑色（默认）
    gmt grdcontour @AK_gulf_grav.nc -A0,
gmt end show