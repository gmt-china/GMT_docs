gmt begin CN-border-JD
    gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
    gmt coast -JD105/35/36/42/10c -R70/140/3/60 -G244/243/239 -S167/194/223 -Ba10f5g10 -Lg85/11+c11+w900k+f+u
    gmt plot CN-border-La.gmt -W0.1p
gmt end show