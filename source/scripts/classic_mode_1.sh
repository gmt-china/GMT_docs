# 生成网格文件和CPT文件
gmt grdgradient -Nt0.2 -A45 data.nc -Gintens.nc
gmt makecpt -Cgeo -T-8000/2000 > t.cpt
# 绘图
gmt grdimage -Ct.cpt -Iintens.nc data.nc -JM6i -P -K > map.ps
gmt pscoast -Rdata.nc -J -Dh -Baf -W0.75p -O -K >> map.ps
echo "Japan Trench" | gmt pstext -F+f32p+cTC -Dj0/0.2i -Gwhite -R -J -O -K >> map.ps
gmt psxy -W2p lines.txt -R -J -O -K >> map.ps
gmt psscale -R -J -DjBL+w3i/0.1i+h+o0.3i/0.4i -Ct.cpt -W0.001 -F+gwhite+p0.5p -Bxaf -By+l"km" -O >> map.ps
# 将PS文件转换为PDF格式
gmt psconvert maps.ps -Tf
