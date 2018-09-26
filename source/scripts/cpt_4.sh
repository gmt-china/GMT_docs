#!/bin/bash
SIZE=w15c/0.25c

gmt begin cpt_4 pdf,png
gmt makecpt -Chaxby -T-10/10/1 > Icpt.cpt
gmt makecpt -Chaxby -T-10/10/1 -Iz > Icpt_z.cpt
gmt makecpt -Chaxby -T-10/10/1 -Ic > Icpt_c.cpt
gmt makecpt -Chaxby -T-10/10/1 -Icz > Icpt_cz.cpt

gmt plot -R1/10/1/10 -JX20c -T 

gmt colorbar -CIcpt.cpt   -Dn0.5/0.25+jCM+$SIZE+h+e+n -B+l"Master CPT"  
gmt colorbar -CIcpt_c.cpt -Dn0.5/0.4+jCM+$SIZE+h+e+n  -B+l"-Ic"  
gmt colorbar -CIcpt_z.cpt -Dn0.5/0.55+jCM+$SIZE+h+e+n -B+l"-Iz"  
gmt colorbar -CIcpt_cz.cpt -Dn0.5/0.7+jCM+$SIZE+h+e+n -B+l"-Icz" 

rm Icpt*.cpt
gmt end
