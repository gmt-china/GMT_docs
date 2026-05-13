PS=map_annot_ortho.ps
axes=ws
gmt psbasemap -R0/5/0/5 -JX4c -Baf -B+t"$axes" --MAP_ANNOT_ORTHO=$axes -K > $PS
for axes in sn wesn z; do
    gmt psbasemap -J -R -Baf -B+t"$axes" --MAP_ANNOT_ORTHO=$axes -K -O -X6c >> $PS
done
gmt psxy -R -J -T -O >> $PS
rm gmt.*