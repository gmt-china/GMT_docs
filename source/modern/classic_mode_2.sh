#!/bin/bash
ps=classic_mode_2.ps
topo=topo.cpt
geoid=geoid.cpt

gmt set FONT_TITLE 30p MAP_ANNOT_OBLIQUE 0
gmt set MAP_ANNOT_OBLIQUE 0 PS_MEDIA letter
gmt makecpt -Crainbow -T-2/14/2 > $geoid
gmt grdimage @HI_geoid_02.nc -R160/20/220/30+r -JOc190/25.5/292/69/4.5i -E50 -B10 -C$geoid -X1.5i -Y1.25i -P -K > $ps
gmt psscale -J -R -C$geoid -DJRM+o0.6i/0+e+mc -Bx2+lGEOID -By+lm -K -O >> $ps
gmt grd2cpt @HI_topo_02.nc -Crelief -Z > $topo
gmt grdimage -J -R @HI_topo_02.nc -I+a0 -B+t"H@#awaiian@# T@#opo and @#G@#eoid@#" -B10 -E50 -Ctopo -Y3i --MAP_TITLE_OFFSET=0.5i -K -O >> $ps
gmt psscale -J -R -C$topo -DJRM+o0.6i/0+mc -I0.3 -Bx2+lTOPO -By+lkm -K -O >> $ps
gmt pstext -R0/8.5/0/11 -Jx1i -F+f30p,Helvetica-Bold+jCB -N -Y-4.5i -O >> $ps << EOF
-0.4 7.5 a)
-0.4 3.0 b)
EOF
gmt psconvert $ps -Tf -A
gmt psconvert $ps -Tg -A
rm $ps *.cpt gmt.*
