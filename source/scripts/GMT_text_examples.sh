#!/bin/bash
PS=GMT_text_examples.ps
R=0/5/0/1
J=X15c/1c

gmt psxy -R$R -J$J -P -K -T > $PS

for font in 30p 30p,8 30p,8,red 30p,5,blue=1p,black,solid 30p,5,-=1p,black,solid
do
gmt pstext -R -J -F+j+f -K -O -Y1c >> $PS << EOF
1 0.5 LM $font TEXT
2.2 0.5 LM 15p,8,black $font
EOF
done
gmt psxy -R -J -O -T >> $PS

rm gmt.history
