#!/usr/bin/env bash
set -x
gmt begin ex010
    # 将原始数据转换为经度、纬度、标准时间的格式
    gawk '{printf "%.3f %.3f %d-%d-%dT%d:%d:%.3f", $8,$7,$1,$2,$3,$4,$5,$6}' data.txt > tmp1.txt
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
    duration=$(echo "$end - $start" | bc)
    
    # 自动获取作图范围
    R=$(gmt info data.txt -I2/2 -i7,6 | tr -d '\n')
    gmt basemap ${R} -JM15c -Baf
    gmt plot tmp2.txt -Sc0.3c -W
    
    rm tmp1.txt tmp2.txt
gmt end show