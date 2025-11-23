gmt begin CN-faults
    gmt coast -JM15c -R60/150/0/60 -Baf -W0.5p,black -A10000
    gmt plot CN-faults.gmt -W1p,red
gmt end show