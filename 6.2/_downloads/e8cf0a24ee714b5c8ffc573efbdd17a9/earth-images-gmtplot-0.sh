gmt begin earth-image png,pdf
    gmt grdmath -Rd -I20m -r $(gmt solar -C -o0:1 -I+d2008-08-08T01:00) 2 DAYNIGHT = w.grd
    gmt grdmix @earth_day_20m @earth_night_20m -Ww.grd -Gview.tif
    gmt grdimage view.tif
    rm -f w.grd view.tif
gmt end show