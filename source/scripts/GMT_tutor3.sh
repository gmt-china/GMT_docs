#!/bin/bash
gmt begin tutor3 pdf,png
gmt set FONT_ANNOT_PRIMARY 10p

# 绘制地形
gmt grdimage @earth_relief_03m.grd -JB90/0/40/30/6.5i -R65/18/117/45+r -B10g10 -BwSEN -CTibet.cpt -I+d

# 利用coast绘制水系、比例尺
gmt coast -N1/0.5p,white -Ia/0.15p,177/178/183 -I1/0.5p,61/99/172 -C81/174/254 -Lg86/18+c30+w1000+u+f

# 绘制两个色标
gmt colorbar -Dx-0.3i/1.4i+w2.5i/0.15i+ma -CTibet.cpt -G1600/9000 -By+lm -Bxa1000f200
gmt colorbar -Dx-0.3i/0+w1.3i/0.15i+ma -CTibet.cpt -G-3500/0 -L

gmt end
