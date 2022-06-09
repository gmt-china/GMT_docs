#!/usr/bin/env bash
#
# 绘制 GPS 速度场
#

gmt begin gps
# 绘制底图
gmt set FORMAT_GEO_MAP=ddd:mm:ssF
gmt basemap -R70/135/15/55 -JM18c -Bf5a10 -BWesN
gmt makecpt -Cglobe -T-10000/10000/200 -Z -D
gmt grdimage @earth_relief_06m -I+d
gmt colorbar -DjCB+w18c/0.3c+o0/-2.5c+h -BWSEN -Bxa2000f400+l"Elevation/m" -G-8000/8000

# 绘制国界
gmt plot CN-border-L1.gmt -W1p,-

# 绘制 GPS 速度场
# -Se 后面两个参数表示：
#    速度值为 1 的矢量的长度（0.05c）/置信度（0.95）
#    +f 设置文本的大小，0 表示不显示标注
# -A 控制矢量的属性，0.15c 是矢量头的大小，+e 表示在矢量尾端绘制箭头，+p0.75p,blue 设置矢量箭头轮廓的属性
# -W 控制矢量线及误差椭圆的轮廓的宽度,颜色,线型
# -G 矢量头的填充色
gmt velo gps_campagin.txt -Se0.05c/0.95+f0 -A0.15c+e+p0.5p,blue -W0.5p,blue -Gblue
gmt velo gps_continuous.txt -Se0.05c/0.95+f0 -A0.15c+e+p0.5p,red -W0.5p,red -Gred

# 添加图例
# 此处在底图右下角，设置了一个宽 3.5c 高 2c 的底图
# 底图范围为 0/1/0/1，矢量箭头和文字的位置需对应该小图中的位置
gmt inset begin -R0/1/0/1 -JX3.5c/2c -DjBR -F+gwhite
echo 0.05 0.75 '20\2611 mm/yr' | gmt text -F+f7p+jML
echo 0.05 0.50 20 0 1 1 0 | gmt velo -Se0.05c/0.95+f0 -A0.15c+e+p0.5p,blue -Gblue -W0.5p,blue
echo 0.05 0.25 20 0 1 1 0 | gmt velo -Se0.05c/0.95+f0 -A0.15c+e+p0.5p,red -Gred -W0.5p,red
gmt text -F+f6p+jML -M << EOF
> 0.4 0.50 0.25 2c c
Continuous Station
1998-2014
> 0.4 0.25 0.25 2c c
Campaign Stations
2009-2014
EOF
gmt inset end
gmt end show
