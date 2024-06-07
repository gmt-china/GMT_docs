#!/usr/bin/env bash

# 下载数据文件
wget -q https://datapub.gfz-potsdam.de/download/10.5880.WSM.2016.001/wsm2016.csv

gmt begin wsm2016
    # 绘制底图
    gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
    gmt coast -JD105/35/36/42/10c -R70/140/3/60 -G244/243/239 -S167/194/223 -Baf
    
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
    gawk -F, '($6 == "FMF" || $6 == "FMS" || $6 == "FMA") {print $4, $3, $5}' wsm2016.csv | gmt plot -Skfocal_mec/0.1c -W0p,yellow -Gyellow
    gawk -F, '($6 == "BO" || $6 == "BOC" || $6 == "BOT") {print $4, $3, $5}' wsm2016.csv | gmt plot -Skborehole_collapse/0.1c -W0p,orange -Gorange
    gawk -F, '$6 == "OC" {print $4, $3, $5}' wsm2016.csv | gmt plot -Skstress_relief/0.1c -W0p,blue
    gawk -F, '($6 == "HF" || $6 == "HFG" || $6 == "HFM" || $6 == "HFP") {print $4, $3, $5}' wsm2016.csv | gmt plot -Skhydra_fract/0.1c -W0p,red -Gred
    gawk -F, '($6 == "GFI" || $6 == "GFM" || $6 == "GFS") {print $4, $3, $5}' wsm2016.csv | gmt plot -Skfault_slip/0.1c -W0p,green -Ggreen
    gawk -F, '($6 == "BS") {print $4, $3, $5}' wsm2016.csv | gmt plot -SkBS/0.1c -W0p,pink -Gpink
    gawk -F, '($6 == "DIF") {print $4, $3, $5}' wsm2016.csv | gmt plot -SkDIF/0.1c -W0p,black -Gblack

gmt end show