#!/usr/bin/env bash
gmt begin ex010
    # 获取发震时刻最大最小值
    start=$(gmt info data.txt -C -o0 -i0 | tr -d '\n')
    end=$(gmt info data.txt -C -o1 -i0 | tr -d '\n')
    
    # 根据发震时刻绘制不同颜色的圆点
    gmt makecpt -Chot -T${start}/${end}/100+n -Z -Di
    gmt plot data.txt -Sc0.1c -W -C -Ra -JM15c -Baf -i1,2,0
    gmt colorbar -Bxaf -C
    # 绘制省界，断层
    gmt plot CN-border-La.gmt -W0.5p
    gmt plot CN-faults.gmt -W1p,gray
gmt end show
