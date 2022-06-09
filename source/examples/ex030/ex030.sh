#!/usr/bin/env bash
#
# 绘制断层与滑动分布
#
gmt begin inv png   
gmt set MAP_FRAME_TYPE = plain #设置图框类别
gmt set MAP_FRAME_PEN = 1p  #设置图框画笔
gmt set MAP_GRID_PEN = 4p,-  #设置网格画笔

####绘制二维断层滑动分布####
R=0/18.8/0/20  #设置范围
J=X5i/-4i  #设置投影
inv2dxy=slip_fault2d.xy #设置断层模型的二维输入数据
vector=slip.gmtvec #设置断层模型的滑动矢量数据

#生成cpt文件 
gmt makecpt -Cwhite,lightblue,yellow,red -T0/0.26/0.01 -Z
#绘制二维图框
gmt basemap -R$R -J$J -Baf -BSWne -Bx+l"Length along strike/km" -By+l"Width along dip/km" --MAP_TICK_LENGTH=-3p --FONT=13p 
#绘制二维断层滑动分布
gmt plot $inv2dxy  -C -L 
#绘制二维断层滑动矢量
gmt velo $vector -A0.2c+e+p0.7p -Gblack -Se0.12/0.015/0 
#标注断层走向
echo  16  1.5  SW to NE | gmt text -F+f13p,0,black 
#标注滑动矢量图例
echo  1 18 4 0  0 0 0 | gmt velo -A0.3c+e+p1p -Gblack -Se0.2/0.015/0 
echo  3.5 18 25cm | gmt text -F+f15p,0,black 
#绘制色标
gmt colorbar -C -DjTR+w3c/0.3c+o-13.5c/10c+h -W100 -Bxa10+l'Fault slip' -By+lcm --FONT=15p --MAP_TICK_LENGTH=-2p

####绘制三维断层滑动分布####
gmt set FORMAT_GEO_MAP ddd.x  #设置度数显示格式
gmt set MAP_GRID_PEN = 1.5p,black,-  #设置图框画笔

R=87.5/87.9/34.2/34.5/-20/6  #设置范围
J=m24c  #设置投影
Jz=Z4c #设置Z轴投影
p=20/50/-20 #设置三维绘制视角
inv3d=slip_fault3d.xyz  #设置断层模型的三维输入数据

#绘制图框，-X5.5i指在二维滑动分布图右边偏移5.5i绘制三维滑动分布
gmt basemap -p$p -R$R -J$J -J$Jz -BwsENZ4 -Bxa0.2g0.05+l"Longitude/km" -Bya0.1g0.05 -Bza10g10f0+l"Depth/km" -X5.5i --FONT=13p,0 --MAP_TICK_LENGTH=0p
#绘制三维滑动分布
gmt plot3d -W0.1p,gray -L $inv3d -C -p

gmt end show
