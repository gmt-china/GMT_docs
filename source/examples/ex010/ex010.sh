#!/usr/bin/env bash

R=70/135/15/55
eqfile=eq.dat

gmt begin topo pdf,png
gmt set FORMAT_GEO_MAP=ddd:mm:ssF
gmt grdimage @earth_relief_02m -R70/135/15/55 -JM15c -Ba10f5 -BWesN -I+d

#绘制colorbar
gmt colorbar -DjCB+w15c/0.5c+o0/-2c+h -Bxa2000f400+l"Elevation/m"

#分震级绘制地震
gawk '$3>=5.0 && $3<6.0 {print $1,$2,$3*0.04}' $eqfile | gmt plot -Sc -Gblue
M5=`gawk '$3>=5.0 && $3<6.0' $eqfile | wc -l | cut -d" " -f1`
gawk '$3>=6.0 && $3<7.0 {print $1,$2,$3*0.04}' $eqfile | gmt plot -Sc -Gred
M6=`gawk '$3>=6.0 && $3<7.0' $eqfile | wc -l | cut -d" " -f1`
gawk '$3>=7.0 && $3<8.0 {print $1,$2,$3*0.04}' $eqfile | gmt plot -Sa -Ggreen
M7=`gawk '$3>=7.0 && $3<8.0' $eqfile | wc -l | cut -d" " -f1`
gawk '$3>=8.0 {print $1,$2,$3*0.06}' $eqfile | gmt plot -Sa -Gpurple -W0.4p,black
M8=`gawk '$3>=8.0' $eqfile | wc -l | cut -d" " -f1`

#绘制图例
gmt legend -DjBR+w2.5c+l1.2+o0 -F+g229+p0.25p <<EOF
G 0.02c
H 8 4 MAGNITUDE
C blue
S 0.4c c 0.20 blue 0.25p,blue 1c 5~5.9
C red
S 0.4c c 0.24 red 0.25p,red 1c 6~6.9
C green
S 0.4c a 0.42 green 0.25p,black 1c 7~7.9
C purple
S 0.4c a 0.48 purple 0.25p,black 1c 8~8.9
EOF
gmt end
