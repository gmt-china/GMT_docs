#!/usr/bin/env bash
gmt begin ex010
    # 获取发震时刻最大最小值
    # 以 -Tzmin/zmax/dz 的形式报告第一列，每四周一个间隔dz
    T_cpt=$(gmt info data.txt -T4w+c0)
    echo ${T_cpt}
    
    # 根据发震时刻绘制不同颜色的圆点
    gmt makecpt -Chot ${T_cpt} -Z -Di
    gmt plot data.txt -Sc0.1c -W -C -Ra -JM15c -Baf -i1,2,0
    gmt colorbar -Bxaf -C
    # 绘制省界，断层
    gmt plot CN-border-La.gmt -W0.5p
    gmt plot CN-faults.gmt -W1p,gray
gmt end show
