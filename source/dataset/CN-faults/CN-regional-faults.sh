gmt begin CN-regional-faults
    gmt basemap -JM15c -R95/105/25/35 -Baf
    gmt plot CN-faults.gmt -W1p,red
gmt end show