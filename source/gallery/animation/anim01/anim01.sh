#!/usr/bin/env bash

# 绘制静态背景图层的脚本
cat << EOF > pre.sh
gmt math -T0/360/20 T SIND = sin_point.txt
gmt math -T0/360/2 T SIND = sin_curve.txt
gmt begin
    gmt basemap -R0/360/-1.2/1.6 -JX3.5i/1.65i -X0.35i -Y0.25i \
    -BWSne+glightgreen -Bxa90g90f30+u'\232' -Bya0.5f0.1g1 --FONT_ANNOT_PRIMARY=9p
gmt end
EOF

# 绘制动态元素图层的脚本
cat << EOF > main.sh
gmt begin
#   Plot smooth blue curve and dark red dots at all angle steps so far
    last=\`gmt math -Q \${MOVIE_FRAME} 10 MUL =\`
    gmt convert sin_curve.txt -Z0:\${last} | gmt plot -W1p,blue -R0/360/-1.2/1.6 -JX3.5i/1.65i -X0.35i -Y0.25i
    gmt convert sin_point.txt -Z0:\${MOVIE_FRAME} | gmt plot -Sc0.1i -Gdarkred
#   Plot bright red dot at current angle and annotate
    gmt plot -Sc0.1i -Gred <<< "\${MOVIE_COL1} \${MOVIE_COL2}"
    printf "0 1.6 a = %3.3d" \${MOVIE_COL1} | gmt text -F+f14p,Helvetica-Bold+jTL -N -Dj0.1i/0.05i
gmt end
EOF

# movie 模块调用了 pre.sh 和 main.sh 脚本以生成动画
# 生成动画
gmt movie main.sh -Sbpre.sh -C4ix2ix125 -Tsin_point.txt -Z -Nanim01 -D5 -A+l
# 将动画中的一帧保存为静态图片
gmt movie main.sh -Sbpre.sh -C4ix2ix125 -Tsin_point.txt -Z -Nanim01 -D5 -M10,png -Fnone
