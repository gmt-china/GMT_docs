#!/bin/bash
gmt begin cpt_3 pdf,png
gmt makecpt -Cglobe -T-8000/3000 > t.cpt

gmt colorbar -Ct.cpt -Baf -Dx0/0+w4.5i/0.1i+h 
gmt colorbar -Cglobe -Baf -Dx0/0+w4.5i/0.1i+h -Y0.5i

rm t.cpt
gmt end