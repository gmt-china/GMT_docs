ps=GMT_line_arrow.ps
gmt math -T10/30/1 T 20 SUB 10 DIV 2 POW 41.5 ADD = line.txt

gmt psxy line.txt -R8/32/40/44 -JM5i -P -Wfaint,red -K -Bxaf -Bya2f1 -BWSne --MAP_FRAME_TYPE=plain > $ps
gmt psxy line.txt -R -J -W2p+o1c/500k+vb0.2i+gred+pfaint+bc+ve0.3i+gblue -O -K --MAP_VECTOR_SHAPE=0.5 >> $ps
gmt psxy -R -J -O -T >> $ps
rm gmt.* line.txt