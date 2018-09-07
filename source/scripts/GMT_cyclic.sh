#!/bin/bash
gmt begin GMT_cyclic pdf,png
gmt makecpt -T0/100 -Cjet -Ww > t.cpt
gmt basemap -R0/20/0/1 -JM5i -BWse -Baf 
gmt colorbar -Ct.cpt -Baf -DJBC 
rm t.cpt
gmt end
