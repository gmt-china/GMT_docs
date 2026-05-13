gmt begin map pdf,png
gmt set FONT_TITLE 15p MAP_TITLE_OFFSET -5p
gmt subplot begin 1x3 -Fs5c -M0c
for cap in none 85/90 80/60; do
    gmt coast -Rg -JA280/30/? -Bg -B+t"$cap" -Dc -A1000 -Gnavy --MAP_POLAR_CAP=$cap -c
done
gmt subplot end
gmt end