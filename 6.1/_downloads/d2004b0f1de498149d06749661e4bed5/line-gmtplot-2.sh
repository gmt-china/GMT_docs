gmt begin line_arrow pdf,png
gmt math -T10/30/1 T 20 SUB 10 DIV 2 POW 41.5 ADD = line.txt

gmt plot line.txt -R8/32/40/44 -JM5i -Wfaint,red -Bxaf -Bya2f1 -BWSne --MAP_FRAME_TYPE=plain
gmt plot line.txt -W2p+o1c/500k+vb0.2i+gred+pfaint+bc+ve0.3i+gblue --MAP_VECTOR_SHAPE=0.5
rm line.txt
gmt end