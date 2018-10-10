ps=classic_mode_1.ps
grd=@earth_relief_15m.grd
nc=intens.nc
cpt=janpan.cpt
# 生成网格文件和CPT文件
gmt grdgradient -Nt0.2 -A45 $grd -G$nc
gmt makecpt -Cgeo -T-8000/4000 > $cpt
# 绘图
gmt grdimage $grd -JM6i -R125/150/30/46 -C$cpt -I$nc -P -K > $ps
gmt pscoast -J -R -Dh -B+t'Japan' -Baf -W0.75p -K -O >> $ps
gmt psscale -J -R -DjBR+w3i/0.1i+h+o0.3i/0.4i -C$cpt -W0.001 -F+gwhite+p0.5p -Bxaf -By+l"km" -O >> $ps
# 将PS文件转换为PDF格式
gmt psconvert $ps -Tf -A
gmt psconvert $ps -Tg -A
rm $nc $ps *.cpt gmt.*
