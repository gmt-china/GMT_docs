#!/bin/bash

ls `gmt --show-sharedir`/cpt/* | xargs -n1 basename | sort -r > tt.lis

n=`cat tt.lis | wc -l`
let n2=n/2
# dy is line spacing and y0 is total box height
dy=0.75
y0=`echo "$n2 * $dy * 0.5" | bc`

gmt begin GMT_CPT_1 pdf,png
gmt set MAP_FRAME_PEN thinner FONT_ANNOT_PRIMARY 8p MAP_TICK_LENGTH_PRIMARY 0.1i MAP_ANNOT_OFFSET_PRIMARY 0.04i
gmt basemap -R0/6.1/0/$y0 -Jx1i -B0

let i=1+n2
y=0.475
y2=0.35
while [ $i -le $n ]
do
	j=`expr $i + 1`
	left=`sed -n ${j}p tt.lis`
	right=`sed -n ${i}p tt.lis`
	gmt makecpt -C$left > tt.left.cpt
	gmt makecpt -C$left -T-1/1/0.25 > tt.left2.cpt
	gmt makecpt -C$right > tt.right.cpt
	gmt makecpt -C$right -T-1/1/0.25 > tt.right2.cpt
	gmt colorbar -D1.55i/${y}i+w2.70i/0.125i+h+jTC -Ctt.left.cpt -B0 
	gmt colorbar -D4.50i/${y}i+w2.70i/0.125i+h+jTC -Ctt.right.cpt -B0 
	gmt colorbar -D1.55i/${y2}i+w2.70i/0.125i+h+jTC -Ctt.left2.cpt -Bf0.25 
	gmt colorbar -D4.50i/${y2}i+w2.70i/0.125i+h+jTC -Ctt.right2.cpt -Bf0.25
	gmt text -D0/0.05i -F+f9p,Helvetica-Bold+jBC << END
	1.55 $y ${left}
	4.50 $y ${right}
END
	i=`expr $i + 2`
	y=`gmt math -Q $y $dy ADD =`
	y2=`gmt math -Q $y2 $dy ADD =`
done

rm  tt.*
gmt end
