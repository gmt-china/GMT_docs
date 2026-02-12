ps=GMT_line_offset.ps
gmt math -T10/30/1 T 20 SUB 10 DIV 2 POW 41.5 ADD = line.txt

gmt psbasemap -R8/32/40/44 -JM5i -P -Bxaf -Bya2f1 -BWSne --MAP_FRAME_TYPE=plain -K > $ps
gmt psxy line.txt -R -J -Wfaint,red -K -O >> $ps
gmt psxy line.txt -R -J -W2p+o1c/500k -O -K >> $ps
gmt pstext -R -J -O -K -F+f10p+jCM+a << EOF >> $ps
11.0 42.6 -11.5 1 cm
27.1 42.3 +9.5 500 km
EOF
gmt psxy -R -J -O -T >> $ps
rm line.txt gmt.*