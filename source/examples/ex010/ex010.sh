#!/usr/bin/env bash
gmt begin ex010
    # 假设数据文件放置在${GMT_DATADIR}目录中
    # 将原始数据转换为经度、纬度、标准时间的格式
    gawk '{printf "%.3f %.3f %d-%d-%dT%d:%d:%.3f\n", $8,$7,$1,$2,$3,$4,$5,$6}' ${GMT_DATADIR}/data.txt > tmp1.txt
    # 使用 gawk 结合 date 命令，将 data.txt 文件中第三列的时间格式 YYYY-mm-ddThh:mm:ss 转换为包含浮点秒的 UNIX 时间戳。
    gawk '{
    # 提取第三列时间
    time=$3
    # 分解日期和时间
    split(time, datetime, "T")    # 按 "T" 分割日期和时间
    date=datetime[1]             # 日期部分 YYYY-mm-dd
    time=datetime[2]             # 时间部分 hh:mm:ss
    # 使用GNU date转换为时间戳
    cmd="date -d \"" date " " time "\" +%s.%N"
    cmd | getline timestamp       # 执行命令并获取输出
    close(cmd)                    # 关闭命令管道
    # 输出修改后的内容
    print $1, $2, timestamp
    }' tmp1.txt > tmp2.txt
    # 自动获取发震时刻浮点数时间戳的最大最小值
    start=$(gmt info tmp2.txt -C -o4 | tr -d '\n')
    end=$(gmt info tmp2.txt -C -o5 | tr -d '\n')
    # 最大最小值对应的可读时间
    # ${start%.*}：取整数部分。
    # ${start#*.}：取小数部分。
    t1=$(date -d @"${start%.*}" +"%Y-%m-%dT%H:%M:%S.$(printf "%03d" ${start#*.})")
    t2=$(date -d @"${end%.*}" +"%Y-%m-%dT%H:%M:%S.$(printf "%03d" ${end#*.})")

    # 
    gmt makecpt -Chot -T${start}/${end}/100+n -Z -Di
    gmt plot tmp2.txt -Sc0.2c -W -C -Ra -JM15c -Baf
    gmt colorbar -R${t1}/${t2}/0/1 -Bpxa6O -Bsxa1Y -BS -C
    
    rm tmp1.txt tmp2.txt
gmt end show