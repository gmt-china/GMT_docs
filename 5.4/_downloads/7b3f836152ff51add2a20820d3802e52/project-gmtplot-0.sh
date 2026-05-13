#!/bin/bash

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

PS=project_sketch.ps
p_az=$((270 - $profile_az))

# 绘制原始坐标系
gmt psbasemap -R0/10/0/10 -Jx1c -Bws -B0 --MAP_FRAME_TYPE=graph -K > $PS
# 绘制测线
gmt project -C$profile_x/$profile_y -A$profile_az -G1 -L0/$profile_length | gmt psxy -W5p,green -J -R -K -O >> $PS

# 绘制测线坐标系
gmt psbasemap -R0/7/0/5 -Jx1c -Bws -B0 --MAP_FRAME_TYPE=graph -p$p_az/90+v${profile_x}/${profile_y}+w0/0 -K -O >> $PS
# P, Q
gmt pstext -J -R -F+f12p,5,black+j -Dj0.2c/0.2c -N -p -K -O >> $PS << EOF
7 0 TL P
0 5 BR Q
EOF
# (x, y)到PQ轴的连线
gmt psxy -J -R -W1p,black,- -p -K -O >> $PS << EOF
>
$p 0
$p $q
>
0 $q
$p $q
EOF
# PQ轴蓝色指示线及标注
gmt psxy -J -R -W1p,blue -Sv0.5c+s+et+bt -p -N -K -O >> $PS << EOF
0 -0.25 $p -0.25
-0.25 0 -0.25 $q
EOF
gmt psxy -J -R -W1p,black -Sqn1:+Lh+f15p,7,blue+n0c/0.5c -p -K -O >> $PS << EOF
> -Lq
0 0
0 $q
EOF
gmt psxy -J -R -W1p,black -Sqn1:+Lh+f15p,7,blue+n0c/-0.5c -p -K -O >> $PS << EOF
> -Lp
0 0
$p 0
EOF
echo 0 0 | gmt psxy -J -R -Sc0.2c -W1p,darkblue -Gdodgerblue -N -p -K -O >> $PS
echo $profile_length 0 | gmt psxy -J -R -Sc0.2c -W1p,darkblue -Ggreen -N -p -K -O >> $PS

# 回到原始坐标系
gmt psxy -R0/10/0/10 -Jx1c -T -K -O >> $PS

# 添加标注XY
gmt pstext -J -R -F+f12p,5,black+j -Dj0.25c/0.25c -N -K -O >> $PS << EOF
10 0 TL X
0 10 BR Y
EOF
# 绘制待投影点
echo $x0 $y0 | gmt psxy -J -R -Sc0.3c -W1p,darkblue -Gred -K -O >> $PS
echo $x0 $y0 '(x,y)' | gmt pstext -J -R -F+f15p,7,blue+jML -D0.2c/0c -K -O >> $PS
# 绘制待投影点与测线上的投影点
echo $r $s | gmt psxy -J -R -W1p,black -Sc0.3c -Gpurple -K -O >> $PS

#
gmt psxy -J -R -W1p,black,- -K -O >> $PS << EOF
>
$r 0
$r $s
>
0 $s
$r $s
EOF
gmt pstext -J -R -F+f15p,7,blue+j -Dj0.2c/0.2c -N -O >> $PS << EOF
$r 0 TC r
0 $s MR s
EOF
rm gmt.*
