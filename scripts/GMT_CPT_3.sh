#!/bin/bash
PS=GMT_CPT_3.ps

gmt makecpt -Cglobe -T-8000/3000 > t.cpt

gmt psscale -Ct.cpt -Baf -Dx0/0+w4.5i/0.1i+h -W0.001 -K -P > $PS	
gmt psscale -Cglobe -Baf -Dx0/0+w4.5i/0.1i+h -W0.001 -Y0.5i  -O >> $PS

rm gmt.*
rm t.cpt