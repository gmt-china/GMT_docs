# 开始绘图，文件名为map，图片格式为PDF和PNG格式
gmt begin map pdf,png
    # 不再需要 和重定向
    gmt grdgradient -Nt0.2 -A45 data.nc -Gintens.nc
    gmt makecpt -Cgeo -T-8000/2000 > t.cpt
    gmt grdimage -Ct.cpt -Iintens.nc data.nc -JM6i -P
    gmt coast -Rdata.nc -Dh -Baf -W0.75p
    echo "Japan Trench" | gmt text -F+f32p+cTC -Dj0/0.2i -Gwhite
    gmt plot -W2p lines.txt
    gmt colorbar -DjBL+w3i/0.1i+h+o0.3i/0.4i -Ct.cpt -W0.001 -F+gwhite+p0.5p -Bxaf -By+l"km"
# 绘图结束，生成图片文件 map.pdf 和 map.png
gmt end