gmt set MAP_TITLE_OFFSET -10p
gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Df" -W1p -Df -K > map.ps
gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dh" -W1p -Dh -K -O -X4c >> map.ps
gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Di" -W1p -Di -K -O -X4c >> map.ps
gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dl" -W1p -Dl -K -O -X4c >> map.ps
gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dc" -W1p -Dc -O -X4c >> map.ps