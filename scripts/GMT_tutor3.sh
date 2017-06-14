#!/bin/bash
gmt gmtset FONT_ANNOT_PRIMARY 10p
R=-R65/18/117/45r
J=-JB90/0/40/30/6.5i
PS=GMT_tutor3.ps
D=earth_relief_03m.grd

gmt grdcut %D% -R55/120/10/50 -GTibet.grd
gmt grdgradient Tibet.grd -A0 -Nt -Gint.grad
gmt psbasemap $R $J -B10g10  -BwSEN  -K > $PS
gmt grdimage $R $J -Bg10  Tibet.grd -Iint.grad -CTibet.cpt -K -O >> $PS
gmt pscoast $R $J  -N1/0.5p,white  -Ia/0.15p,177/178/183 -I1/0.5p,61/99/172 -C81/174/254 -Lg86/18+c30+w1000+u+f -K -O >> $PS
gmt psscale -Dx-0.3i/1.4i+w2.5i/0.15i+ma -CTibet.cpt  -G1600/9000 -By+lm -Bxa1000f200 -K -O >> $PS
gmt psscale -Dx-0.3i/0+w1.3i/0.15i+ma -CTibet.cpt -G-3500/0 -L -O >> $PS
gmt psconvert $PS -A -P -Tj
gmt psconvert $PS -A -P -Tf

rm gmt.*






