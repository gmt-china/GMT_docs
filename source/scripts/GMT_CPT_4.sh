#!/bin/bash
J=X20c
R=1/10/1/10
PS=GMT_CPT_4.ps
SIZE=w15c/0.25c

gmt makecpt -Chaxby -T-10/10/1 > Icpt.cpt
gmt makecpt -Chaxby -T-10/10/1 -Iz > Icpt_z.cpt
gmt makecpt -Chaxby -T-10/10/1 -Ic > Icpt_c.cpt
gmt makecpt -Chaxby -T-10/10/1 -Icz > Icpt_cz.cpt

gmt psxy -R$R -J$J -K -T > $PS

gmt psscale -R -J -CIcpt.cpt   -Dn0.5/0.25+jCM+$SIZE+h+e+n -B+l"Master CPT"  -K -O >> $PS
gmt psscale -R -J -CIcpt_c.cpt -Dn0.5/0.4+jCM+$SIZE+h+e+n  -B+l"-Ic"  -K -O >> $PS
gmt psscale -R -J -CIcpt_z.cpt -Dn0.5/0.55+jCM+$SIZE+h+e+n -B+l"-Iz"  -K -O >> $PS
gmt psscale -R -J -CIcpt_cz.cpt -Dn0.5/0.7+jCM+$SIZE+h+e+n -B+l"-Icz" -K -O >> $PS

gmt psxy -R -J -O -T >> $PS

rm gmt.*
rm Icpt*.cpt