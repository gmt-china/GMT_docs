#!/usr/bin/env sh
ps=subslab.ps
J=X-4i/-4i
R=0/400/0/400
I=10/10

# 绘制底图
gmt psbasemap -R$R -J$J -Bxaf+l"X [km]" -Byaf+l"Depth [km]" -K -BEnSw+t"Mantle Velocity" > $ps

# 将向量在 x, y 方向上的投影转换为网格化文件
gmt xyz2grd   ./velo.gmt -R$R -i0,1,2 -I$I -GU.nc   
gmt xyz2grd   ./velo.gmt -R$R -I$I -i0,1,3 -GV.nc

# 绘制矢量
# -Q 设置矢量属性
# -G 设置向量内部颜色填充
# -W 设置绘制矢量外边画笔的属性
# -S 设置向量值和图上距离的换算关系 e.g 50i-50个向量单位的距离在图上绘制为1英寸 
gmt grdvector U.nc V.nc -R  -I10 -J -O -K -Q0.1i+e+n0.25i+h0.5 -Gblack -W1p -S50i -V >> $ps

# 绘制图例
gmt pslegend -R -J -F+gwhite+p0.2p,black -Dx4i/0i+w1.3i/0.6i+jBR+l1.2 -C0.2i/0.1i -B -O -K -V << EOF >> $ps
S 0.1i v0.02i+a40+e 0.1i black 0.1p 0.2i 5 cm/year
S 0.1i - 0.2i - 0.8p,blue,- 0.3i Slab
EOF

# 绘制板块下插边界
gmt psxy ./slab.gmt -B -J -W0.8p,blue,- -R -O -K >> $ps
echo "(a)" | gmt pstext -B -J -R -F+cTL+f11p,Times-Roman -D-0.56i/1c -K -O -N >> $ps

gmt psbasemap -R$R -J$J -Bxaf+l"X [km]" -Byaf+l"Depth [km]" -V -K -O -BEnSw+t"Main strain distribution" -X5.6i >> $ps
gmt psxy ./slab.gmt -B -J -W0.8p,blue,- -R -O -K -V>> $ps


# 绘制应力张量主应力大小及方向
# -Sx 表示绘制主应力/应变大小与方向, 后面数值表示1单位待绘制物理量在图上的长度
#     本例中表示图上 0.01i 长度表示的应力大小为 1 Mpa
# -A2p+jc  表示矢量属性,设置箭头大小和设置矢量与输入x,y坐标的关系
# 输入文件格式:
#       横坐标, 竖坐标, 应力张量扩张特征值[扩张为正], 压缩特征值, 压缩特征值对应矢量与正北方向夹角 
gmt psvelo ./psveloStress.gmt -J -R -Sx0.01i -B -W0.1p,red -A2p+jc -K -O -V >> $ps
gmt pslegend -R -J -F+gwhite+p0.2p,black -Dx4i/0i+w1i/0.6i+jBR+l1.2 -C0.2i/0.1i -B -O -K -V << EOF >> $ps
S 0.1i v2p+e+p0.1p,red 0.1i red 0.1p  0.2i 10 Mpa
S 0.1i - 0.2i - 0.8p,blue,- 0.3i Slab
EOF
echo "(b)" | gmt pstext -B -J -R -F+cTL+f11p,Times-Roman -D-0.56i/1c -O -N >> $ps

rm gmt.conf gmt.history *.nc

