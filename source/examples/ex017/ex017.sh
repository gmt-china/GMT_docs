#!/usr/bin/env sh
#
# 绘制矢量场
#
gmt begin vector-fields
gmt basemap -R0/400/0/400 -JX-10c/-10c -Bxaf+l"X [km]" -Byaf+l"Depth [km]" -BEnSw+t"Mantle Velocity"

# 将速度矢量的 X 分量和 Y 分量分别转换成网格文件
gmt xyz2grd velocity.dat -R0/400/0/400 -I10/10 -i0,1,2 -GU.nc
gmt xyz2grd velocity.dat -R0/400/0/400 -I10/10 -i0,1,3 -GV.nc

# 绘制矢量
# -Q 设置矢量属性
# -G 设置矢量内部颜色填充
# -W 设置绘制矢量外边画笔的属性
# -S 设置矢量值和图上距离的换算关系: 20c表示长度为20的矢量在图上的长度为1 cm
gmt grdvector U.nc V.nc -I10/10 -Q0.2c+e+n0.5c+h0.5 -Gblack -W1p -S20c

# 绘制图例
# 长度为 5 cm/year 的矢量对应的长度为 0.25 cm
gmt legend -F+gwhite+p0.5p,black -DjBR+w2.2c+o0.1c/0.1c << EOF
S 0.2c v0.2c+e+n0.5c+h0.5 0.25c black 1p 0.5c 5 cm/year
EOF

rm U.nc V.nc
gmt end show
