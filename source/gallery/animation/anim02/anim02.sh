#!/usr/bin/env bash

# 绘制静态背景图层的脚本并生成绘图过程中需要使用的数据
cat << EOF > pre.sh
gmt math -T0/360/5 -I T 5 SUB = longitudes.txt
gmt makecpt -Cdem2 -T0/6000 > movie_dem.cpt
gmt grdgradient @earth_relief_20m -Nt1.25 -A45 -Gintens.nc
EOF

# 生成绘图主脚本
cat << EOF > main.sh
gmt begin
	# Let HSV minimum value go to zero
	gmt set COLOR_HSV_MIN_V 0
	# Fake simulation of sun illumination from east combined with relief slopes
	gmt grdmath intens.nc X \${MOVIE_COL1} SUB DUP -180 LE 360 MUL ADD 90 DIV ERF ADD 0.25 SUB = s.nc
	# Plot age grid first using age cpt
	gmt grdimage @age.3.20.nc -Is.nc -C@crustal_age.cpt -JG\${MOVIE_COL0}/0/6i -X0 -Y0
	# Clip to expose land areas only
	gmt coast -Gc
	# Overlay relief over land only using dem cpt
	gmt grdimage @earth_relief_20m -Is.nc -Cmovie_dem.cpt
	# Undo clipping and overlay gridlines
	gmt coast -Q -B30g30
gmt end
EOF

# 制作动画
gmt movie main.sh -Sbpre.sh -C6ix6ix100 -Tlongitudes.txt -Nanim02 -H2 -Z -A+l
gmt movie main.sh -Sbpre.sh -C6ix6ix100 -Tlongitudes.txt -Nanim02 -H2 -Z -M10,png -Fnone

rm -rf main.sh pre.sh
