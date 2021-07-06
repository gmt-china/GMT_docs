#!/usr/bin/env bash
gmt begin contour_annot9 pdf,png
gmt set FORMAT_GEO_MAP ddd:mm:ssF FONT_ANNOT_PRIMARY +9p FONT_TITLE 22p
gmt project -E-74/41 -C-17/28 -G10 -Q > great_NY_Canaries.txt
gmt project -E-74/41 -C2.33/48.87 -G100 -Q > great_NY_Paris.txt
km=`echo -17 28 | gmt mapproject -G-74/41/k -fg --FORMAT_FLOAT_OUT=%.0f -o2`
cat << EOF > ttt.cpt
0	lightred	3	lightred
3	lightyellow	6	lightyellow
6	lightgreen	100	lightgreen
EOF
gmt grdgradient @earth_relief_05m -R-85/5/10/55 -Nt1 -A45 -Gtopo5_int.nc
gmt grdimage ttt_atl.nc -Itopo5_int.nc -Cttt.cpt -R-85/5/10/55 -JM5.3i -nc+t1
gmt grdcontour ttt_atl.nc -C0.5 -A1+u" hour"+v+f8p,Bookman-Demi -GL80W/31N/17W/26N,17W/28N/17W/50N -S2
gmt plot -Wfatter,white great_NY_Canaries.txt
gmt coast -B20f5 -BWSne+t"Tsunami travel times from the Canaries" -N1/thick -Glightgray -Wfaint -A500
gmt convert great_NY_*.txt -E | gmt plot -Sa0.15i -Gred -Wthin
gmt plot -Wthick great_NY_Canaries.txt -Sqn1:+f8p,Times-Italic+l"Distance Canaries to New York = $km km"+ap+v

gmt plot -Wthinner great_NY_Paris.txt -SqD1000k:+an+o+gblue+LDk+f7p,Helvetica-Bold,white
cat << EOF | gmt text -Gwhite -Wthin -Dj0.1i/0.1i -F+f8p,Bookman-Demi+j
74W	41N	RT	New York
2.33E	48.87N	CT	Paris
17W	28N	CT	Canaries
EOF
rm topo5_int.nc
gmt end
