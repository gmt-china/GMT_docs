lon0=30
lat0=30
gmt begin vector+q+o png
    lonp=0
    latp=20
    gmt coast -Rg -JG20/20/10c -Dc -A5000 -Gpink -Sthistle -Bg -B+t"\053q\053o$lonp/$latp"
    echo $lon0 $lat0 0 320 | gmt plot -S=1c+e+g0+q+o$lonp/$latp -W2p
    echo $lon0 $lat0 | gmt plot -Sc0.4c -G0
    echo $lonp $latp | gmt plot -Sc0.4c -Gred
    echo $lonp $latp pole | gmt text -F+f15p+jTL -C20%/20%+tO -Gwhite -Dj0.3c

    lonp=50
    latp=-5
    gmt coast -Rg -JG20/20/10c -Dc -A5000 -Gpink -Sthistle -Bg -B+t"\053q\053o$lonp/$latp" -X+w+2c
    echo $lon0 $lat0 0 320 | gmt plot -S=1c+e+g0+q+o$lonp/$latp -W2p
    echo $lon0 $lat0 | gmt plot -Sc0.4c -G0
    echo $lonp $latp | gmt plot -Sc0.4c -Gred
    echo $lonp $latp pole | gmt text -F+f15p+jTL -C20%/20%+tO -Gwhite -Dj0.3c

    gmt coast -Rg -JG20/20/10c -Dc -A5000 -Gpink -Sthistle -Bg -B+t"\053q\053o" -X+w+2c
    echo $lon0 $lat0 0 320 | gmt plot -S=1c+e+g0+q+o -W2p
    echo $lon0 $lat0 | gmt plot -Sc0.4c -G0
    echo 0 90 | gmt plot -Sc0.4c -Gred
    echo 0 90 pole | gmt text -F+f15p+jTL -C20%/20%+tO -Gwhite -Dj0.3c

gmt end show