gmt begin map_annot_ortho pdf,png
gmt subplot begin 1x4 -Fs5c
for axes in we sn wesn z; do
    gmt basemap -R0/5/0/5 -Baf -B+t"$axes" --MAP_ANNOT_ORTHO=$axes -c
done
gmt subplot end
gmt end