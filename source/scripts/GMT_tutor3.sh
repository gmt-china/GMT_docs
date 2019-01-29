#!/bin/bash
D=@earth_relief_03m.grd

gmt begin tutor3 pdf,png
gmt set FONT_ANNOT_PRIMARY 10p

# 裁剪区域地形数据
gmt grdcut $D -R55/120/10/50 -GTibet.grd

# 计算区域地形梯度
gmt grdgradient Tibet.grd -A0 -Nt -Gint.grad

# 利用basemap确定格网标注等参数
gmt basemap -JB90/0/40/30/6.5i -R65/18/117/45+r -B10g10 -BwSEN

# 绘制地形
gmt grdimage -Bg10 Tibet.grd -Iint.grad -CTibet.cpt

# 利用coast绘制水系、比例尺
gmt coast -N1/0.5p,white -Ia/0.15p,177/178/183 -I1/0.5p,61/99/172 -C81/174/254 -Lg86/18+c30+w1000+u+f

# 绘制两个色标
gmt colorbar -Dx-0.3i/1.4i+w2.5i/0.15i+ma -CTibet.cpt -G1600/9000 -By+lm -Bxa1000f200
gmt colorbar -Dx-0.3i/0+w1.3i/0.15i+ma -CTibet.cpt -G-3500/0 -L

rm Tibet.grd int.grad
gmt end
