R1=202/204/20/22
R2=195/210/18/25

gmt begin map2
    gmt xyz2grd HI_geoid_04.xyz -R${R1} -I5m -GHI_geoid_04.grd

    gmt basemap -R${R2} -JM15c -Baf
    gmt coast -G244/243/239 -S167/194/223
    gmt makecpt -Crainbow -T-1/15
    gmt grdimage HI_geoid_04.grd -Q
    gmt coast -W1p
    gmt colorbar -DJRM+o1c/0+e+mc -Bx2+l"GEOID (m)"

    rm HI_geoid_04.grd
gmt end show