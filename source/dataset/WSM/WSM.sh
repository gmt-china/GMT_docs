#!/usr/bin/env bash

# 官方网站
# https://www.world-stress-map.org/
# 下载数据文件
# https://datapub.gfz.de/download/10.5880.WSM.2025.001-Scbwez/
# 格式说明
# https://doi.org/10.48440/wsm.2025.001
# https://doi.org/10.5880/WSM.2025.001

gmt begin WSM
    # 绘制底图
    gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
    gmt coast -JM10c -R100/130/15/40 -G244/243/239 -S167/194/223 -Baf

    #
    size=0.3c
    rawdata=$(gmt which WSM_Database_2025.csv)
    # 原始数据包含引号包裹的逗号，例如 "Tanzania, United Republic of"，处理分隔符需要 FPAT='([^,]*)|("[^"]*")'
    # 原始数据包含非 ASCII 字符，LC_ALL=C 强制使用 C 语言环境让它把所有字符都当作单字节处理
    # 移除可能存在的双引号，确保输出的是纯净数值或字符
    LC_ALL=C gawk -v FPAT='([^,]*)|("[^"]*")' '
        NR > 1 && $4 != "" && $5 != "" && $6 != "" && $7 != "" {
        gsub(/"/, "", $4); gsub(/"/, "", $5); 
        gsub(/"/, "", $6); gsub(/"/, "", $7);
        if($4 != "" && $5 != "" && $6 != "" && $7 != "") {
            print $5, $4, $6, $7
        }
    }' ${rawdata} > WSM_output.txt
    data=$(gmt which WSM_output.txt)

    # 生成震源机制符号自定义文件
    cat > focal_mec.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 0 0.2 c
EOF
    # 生成钻孔崩落符号自定义文件
    cat > borehole_collapse.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 -0.0866 0.2 t
0 0.0866 0.2 i
EOF
    # 生成应力解除符号自定义文件
    cat > stress_relief.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 -0.05 0.25 -
0.02 0.05 0.25 -
EOF
    # 生成水压致裂符号自定义文件
    cat > hydra_fract.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 0 0.25 t
0 0 0.25 i
EOF
    # 生成断层滑动符号自定义文件
    cat > fault_slip.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 0 0.1 0.2 r
EOF
    # 生成钻孔槽(BS)符号自定义文件
    cat > BS.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 0 0.25 x
0 0 0.25 -
EOF
    # 生成钻孔诱发张裂隙(DIF)符号自定义文件
    cat > DIF.def << 'EOF'
N: 1 a
$1 O
0 0 1 y
0 0 0.25 d
EOF

    # 使用 gawk 命令提取该类型的测点数据并绘制
    gawk '($4 == "FMF" || $4 == "FMS" || $4 == "FMA") {print $1, $2, $3}' $data | gmt plot -Skfocal_mec/$size -W0p,lightgreen -Glightgreen
    gawk '$4 == "BO" {print $1, $2, $3}' $data | gmt plot -Skborehole_collapse/$size -W0p,orange -Gorange
    gawk '$4 == "OC" {print $1, $2, $3}' $data | gmt plot -Skstress_relief/$size -W0p,blue
    gawk '($4 == "HF" || $4 == "HFH" || $4 == "HFP" || $4 == "HFS") {print $1, $2, $3}' $data | gmt plot -Skhydra_fract/$size -W0p,red -Gred
    gawk '($4 == "GFI" || $4 == "GFM") {print $1, $2, $3}' $data | gmt plot -Skfault_slip/$size -W0p,black -Gblack
    gawk '$4 == "BS" {print $1, $2, $3}' $data | gmt plot -SkBS/$size -W0p,pink -Gpink
    gawk '$4 == "DIF" {print $1, $2, $3}' $data | gmt plot -SkDIF/$size -W0p,yellow -Gyellow

    # 符号图例
    echo 135 40 45 | gmt plot -Skfocal_mec/2c -W1p -Gblack -N
    echo 135 36 45 | gmt plot -Skborehole_collapse/2c -W1p -Gblack -N
    echo 135 32 45 | gmt plot -Skstress_relief/2c -W1p -Gblack -N
    echo 135 28 45 | gmt plot -Skhydra_fract/2c -W1p -Gblack -N
    echo 135 24 45 | gmt plot -Skfault_slip/2c -W1p -Gblack -N
    echo 135 20 45 | gmt plot -SkBS/2c -W1p -Gblack -N
    echo 135 16 45 | gmt plot -SkDIF/2c -W1p -Gblack -N

    gmt text -F+f10p+jML -N << 'EOF'
138 40 Earthquake focal mechanisms
138 36 Borehole breakouts
138 32 Overcoring or other strain relief
138 28 Hydraulic fractures
138 24 Geologic fault-slip
138 20 Borehole slotter
138 16 Drilling-induced tensile fractures
EOF

    rm $data
gmt end show
