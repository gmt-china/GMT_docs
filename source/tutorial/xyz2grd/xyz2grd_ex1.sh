R=195/210/18/25

gmt begin map
    gmt xyz2grd HI_geoid_04.xyz -R${R} -I5m -GHI_geoid_04.grd

    gmt basemap -R${R} -JM15c -Baf
    gmt makecpt -Cturbo -T-1/15
    gmt grdimage HI_geoid_04.grd
    gmt colorbar -Bxaf+l"GEOID (m)"

    rm HI_geoid_04.grd
gmt end show