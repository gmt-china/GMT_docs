#!/usr/bin/env sh

gmt begin subslab png
ps=subslab.ps
J=X-4i/-4i
R=0/400/0/400
I=10/10

# 绘制底图
gmt basemap -R$R -JX-4i/-4i -Bxaf+l"X [km]" -Byaf+l"Depth [km]" -BEnSw+t"Mantle Velocity"

# 将向量在 x, y 方向上的投影转换为网格化文件
gmt xyz2grd velo.gmt -R$R -i0,1,2 -I$I -GU.nc
gmt xyz2grd velo.gmt -R$R -I$I -i0,1,3 -GV.nc

# 绘制矢量
# -Q 设置矢量属性
# -G 设置向量内部颜色填充
# -W 设置绘制矢量外边画笔的属性
# -S 设置向量值和图上距离的换算关系 e.g 50i-50个向量单位的距离在图上绘制为1英寸 
gmt grdvector U.nc V.nc -I10 -Q0.1i+e+n0.25i+h0.5 -Gblack -W1p -S50i

# 绘制图例
gmt legend -F+gwhite+p0.2p,black -Dx4i/0i+w1.3i/0.6i+jBR+l1.2 -C0.2i/0.1i << EOF
S 0.1i v0.02i+a40+e 0.1i black 0.1p 0.2i 5 cm/year
S 0.1i - 0.2i - 0.8p,blue,- 0.3i Slab
EOF

# 绘制板块下插边界
gmt plot slab.gmt -W0.8p,blue,-
echo "(a)" | gmt text -F+cTL+f11p,Times-Roman -D-0.56i/1c -N

gmt basemap -Bxaf+l"X [km]" -Byaf+l"Depth [km]"  -BEnSw+t"Main strain distribution" -X5.6i
gmt plot slab.gmt  -W0.8p,blue,-


# 绘制应力张量主应力大小及方向
# -Sx 表示绘制主应力/应变大小与方向, 后面数值表示1单位待绘制物理量在图上的长度
#     本例中表示图上 0.01i 长度表示的应力大小为 1 Mpa
# -A2p+jc  表示矢量属性,设置箭头大小和设置矢量与输入x,y坐标的关系
# 输入文件格式:
#       横坐标, 竖坐标, 应力张量扩张特征值[扩张为正], 压缩特征值, 压缩特征值对应矢量与正北方向夹角 
gmt velo stresstensor.gmt -Sx0.01i -W0.1p,red -A2p+jc
gmt legend -F+gwhite+p0.2p,black -Dx4i/0i+w1i/0.6i+jBR+l1.2 -C0.2i/0.1i << EOF
S 0.1i v2p+e+p0.1p,red 0.1i red 0.1p  0.2i 10 Mpa
S 0.1i - 0.2i - 0.8p,blue,- 0.3i Slab
EOF
echo "(b)" | gmt text -F+cTL+f11p,Times-Roman -D-0.56i/1c -N

rm *.nc
gmt end

