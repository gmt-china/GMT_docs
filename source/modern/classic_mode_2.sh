#!/bin/bash
ps=classic_mode.ps
gmt set FONT_TITLE 30p MAP_ANNOT_OBLIQUE 0
gmt makecpt -Crainbow -T-2/14/2 > g.cpt
gmt grdimage @HI_geoid_02.nc -R160/20/220/30+r -JOc190/25.5/292/69/4.5i -E50 \
            -B10 -Cg.cpt -X1.5i -Y1.25i 
gmt colorbar -Cg.cpt -DJRM+o0.6i/0+e+mc -Bx2+lGEOID -By+lm 
gmt grd2cpt @HI_topo_02.nc -Crelief -Z > t.cpt
gmt grdimage @HI_topo_02.nc -I+a0 -B+t"H@#awaiian@# T@#opo and @#G@#eoid@#" \
            -B10 -E50 -Ct.cpt -Y4.5i --MAP_TITLE_OFFSET=0.5i 
gmt colorbar -Ct.cpt -DJRM+o0.6i/0+mc -I0.3 -Bx2+lTOPO -By+lkm 
gmt text -R0/8.5/0/11 -Jx1i -F+f30p,Helvetica-Bold+jCB -N -Y-4.5i  << END
-0.4 7.5 a)
-0.4 3.0 b)
END
rm -f ?.cpt gmt.conf
