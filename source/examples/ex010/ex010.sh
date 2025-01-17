#!/usr/bin/env bash
gmt begin ex010
    # 假设数据文件放置在${GMT_DATADIR}目录中
    # 将原始数据转换为经度、纬度、标准时间的格式
    gawk '{printf "%.3f %.3f %d-%d-%dT%d:%d:%.3f\n", $8,$7,$1,$2,$3,$4,$5,$6}' ${GMT_DATADIR}/data.txt > tmp1.txt
    # 获取发震时刻最大最小值
    start=$(gmt info tmp1.txt -C -o4 | tr -d '\n')
    end=$(gmt info tmp1.txt -C -o5 | tr -d '\n')
    
    # 根据发震时刻绘制不同颜色的圆点
    gmt makecpt -Chot -T${start}/${end}/100+n -Z -Di
    gmt plot tmp1.txt -Sc0.2c -W -C -Ra -JM15c -Baf
    gmt colorbar -Bpxa6O -Bsxa1Y -C
    # 绘制省界，断层
    gmt plot CN-border-La.gmt -W0.5p
    gmt plot CN-faults.gmt -W1p,gray
    
    rm tmp1.txt 
gmt end show