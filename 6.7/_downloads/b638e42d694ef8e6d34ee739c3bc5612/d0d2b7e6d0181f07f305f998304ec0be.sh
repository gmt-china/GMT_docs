gmt begin vector png
    R="0/10/0/10"
    gmt basemap -R$R -JX10c/-10c -Baf -BWSen
    gmt makecpt -Crainbow -T0/10 -D

    for len in $(seq 0.5 0.5 9.5 | tr '\n' ' '); do
        echo 0 $len 0 $len | gmt plot -C -Sv0.5c+e+g0+v1q+c -G+z -W+c
    done
    gmt colorbar -Bxa2f
gmt end show