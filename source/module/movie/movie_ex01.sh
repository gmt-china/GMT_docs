#!/bin/bash

# 绘制正弦函数动画

# 构建 background 脚本，生成所需数据以及底图
cat > pre.sh <<EOF
gmt math -T0/360/20 T SIND = sin_point
gmt math -T0/360/2 T SIND = sin_curve

gmt begin 
    gmt basemap -R0/360/-1.2/1.6 -JX10c/5c -Bafg -BWSne+glightgreen -X1c -Y1c
gmt end
EOF

# 构建主脚本
cat > main.sh <<EOF
last=\$(echo \${MOVIE_FRAME}*10 | bc)

gmt begin
    gmt plot -W1p,blue -R0/360/-1.2/1.6 -JX10c/5c sin_curve -q0:\$last  -X1c -Y1c
    gmt plot -Sc0.1i -Gdarkred sin_point -q0:\${MOVIE_FRAME}

    echo \${MOVIE_COL0} \${MOVIE_COL1} | gmt plot -Sc0.1i -Gred 
    echo 0 1.6 a = \${MOVIE_COL0} | gmt text -F+f14p,2+jTL -N -Dj0.1i/0.1i

gmt end
EOF

# 调用 movie 模块
gmt movie main.sh -Sbpre.sh -C12cx7cx100 -Tsin_point -Z -Nanim -D5 -Fgif+l