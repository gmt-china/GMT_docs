#!/bin/bash
gmt makecpt -T0/100 -Cjet -Ww > t.cpt
gmt psbasemap -R0/20/0/1 -JM5i -BWse -Baf -K > cpt_cyclic.ps
gmt psscale -R -J -Ct.cpt -Baf -DJBC -O >> cpt_cyclic.ps
rm t.cpt gmt.*
