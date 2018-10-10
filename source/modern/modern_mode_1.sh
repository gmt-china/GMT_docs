grd=@earth_relief_15m.grd
nc=intens.nc
cpt=janpan.cpt
# 生成网格文件和CPT文件
gmt grdgradient $grd -Nt0.2 -A45 -G$nc
gmt makecpt -Cgeo -T-8000/4000 > $cpt
# 绘图
gmt begin modern_mode_1 pdf,png
# 不再需要考虑 -K -O 和重定向
gmt grdimage $grd -JM6i -R125/150/30/46 -C$cpt -I$nc
gmt coast -Dh -B+t'Japan' -Baf -W0.75p
gmt colorbar -DjBR+w3i/0.1i+h+o0.3i/0.4i -C$cpt -W0.001 -F+gwhite+p0.5p -Bxaf -By+l"km"
# 绘图结束，生成图片文件 modern_mode_1.pdf 和 modern_mode_1.png
rm *.cpt *.nc
gmt end
