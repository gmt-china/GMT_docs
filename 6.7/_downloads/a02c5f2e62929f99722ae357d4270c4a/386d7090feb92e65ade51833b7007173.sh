#!/usr/bin/env bash
gmt begin text_examples
gmt basemap -JX15c/1c -R0/5/0/1 -B+n
for font in 30p 30p,8 30p,8,red 30p,Courier-Bold,blue 30p,5,blue=1p,black,solid 30p,5,-=1p,black,solid; do
	gmt text -F+j+f -Y1c <<- EOF
	1 0.5 LM $font TEXT
	2.2 0.5 LM 15p,8,black $font
	EOF
done
gmt end show
