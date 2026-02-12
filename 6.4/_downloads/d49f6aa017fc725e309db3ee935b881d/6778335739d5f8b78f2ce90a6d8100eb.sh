#!/usr/bin/env bash

# 测线起点、长度、方位角
profile_x=2
profile_y=7
profile_length=5
profile_az=150

# 待投影点坐标
x0=6; y0=7

# 投影后坐标
read p q r s << EOF
$(echo $x0 $y0 | gmt project -C$profile_x/$profile_y -A$profile_az -Fpqrs)
EOF

gmt begin project_sketch

p_az=$((270 - $profile_az))
# 绘制原始坐标系
gmt basemap -R0/10/0/10 -Jx1c -Bws --MAP_FRAME_TYPE=graph
# 绘制测线
gmt project -C$profile_x/$profile_y -A$profile_az -G1 -L0/$profile_length | gmt plot -W5p,lightgreen

# 绘制测线坐标系
gmt basemap -R0/7/0/5 -Jx1c -Bws --MAP_FRAME_TYPE=graph -p$p_az/90+v${profile_x}/${profile_y}+w0/0
# P, Q
gmt text -F+f12p,5,black+j -Dj0.2c/0.2c -N -p << EOF
7 0 TL P
0 5 BR Q
EOF
# (x, y)到PQ轴的连线
gmt plot -W1p,black,- -p << EOF
>
$p 0
$p $q
>
0 $q
$p $q
EOF
# PQ轴蓝色指示线及标注
gmt plot -W1p,blue -Sv0.5c+s+et+bt -p -N << EOF
0 -0.25 $p -0.25
-0.25 0 -0.25 $q
EOF
gmt plot -W1p,black -Sqn1:+Lh+f15p,7,blue+n0c/0.5c -p << EOF
> -Lq
0 0
0 $q
EOF
gmt plot -W1p,black -Sqn1:+Lh+f15p,7,blue+n0c/-0.5c -p << EOF
> -Lp
0 0
$p 0
EOF
# 绘制测线的起点和终点
echo 0 0 | gmt plot -Sc0.2c -W1p,darkblue -Gdodgerblue -N -p
echo $profile_length 0 | gmt plot -Sc0.2c -W1p,darkblue -Ggreen -N -p

# 回到原始坐标系
gmt plot -R0/10/0/10 -Jx1c -T

# 添加标注XY
gmt text -F+f12p,5,black+j -Dj0.25c/0.25c -N << EOF
10 0 TL X
0 10 BR Y
EOF
# 绘制待投影点
echo $x0 $y0 | gmt plot -Sc0.3c -W1p,darkblue -Gred
echo $x0 $y0 '(x,y)' | gmt text -F+f15p,7,blue+jML -D0.2c/0c
# 绘制待投影点与测线上的投影点
echo $r $s | gmt plot -W1p,black -Sc0.3c -Gpurple

#
gmt plot -W1p,black,- << EOF
>
$r 0
$r $s
>
0 $s
$r $s
EOF
gmt text -F+f15p,7,blue+j -Dj0.2c/0.2c -N << EOF
$r 0 TC r
0 $s MR s
EOF

gmt end show
