#!/usr/bin/env bash

gmt begin boundaries
    gmt basemap -JN15c -Rg -Ba60
    gmt coast -G244/243/239 -S167/194/223

    # 提取数据头段中不同类型的边界数据并绘图
    gmt gmtconvert boundaries.gmt -S"type=spreading center" | gmt plot -W0.5p,orange -l"spreading center"
    gmt gmtconvert boundaries.gmt -S"type=extension zone" | gmt plot -W0.5p,red -l"extension zone"
    gmt gmtconvert boundaries.gmt -S"type=subduction zone" | gmt plot -W0.5p,black -l"subduction zone"
    gmt gmtconvert boundaries.gmt -S"type=collision zone" | gmt plot -W0.5p,darkgreen -l"collision zone"
    gmt gmtconvert boundaries.gmt -S"type=dextral transform" | gmt plot -W0.5p,blue -l"dextral transform"
    gmt gmtconvert boundaries.gmt -S"type=sinistral transform" | gmt plot -W0.5p,pink -l"sinistral transform"
    gmt gmtconvert boundaries.gmt -S"type=inferred" | gmt plot -W0.5p,gray -l"inferred"

    # 设置图例属性
    gmt legend -DJMR+o0.1c -F+p1p+gwhite
gmt end show