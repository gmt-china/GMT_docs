gmt set FONT_TITLE 15p MAP_TITLE_OFFSET -5p
cap=85/90
gmt pscoast -Rg -JA280/30/5c -Bg -B+t"$cap" -Dc -A1000 -Gnavy --MAP_POLAR_CAP=$cap -K > map_polar_cap.ps
cap=80/60
gmt pscoast -Rg -JA280/30/5c -Bg -B+t"$cap" -Dc -A1000 -Gnavy --MAP_POLAR_CAP=$cap -O -X6c >> map_polar_cap.ps
rm gmt.*