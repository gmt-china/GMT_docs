gmt begin map_degree_symbol
gmt set FONT_TITLE 18p MAP_TITLE_OFFSET 0p
gmt subplot begin 1x4 -Fs5c
for symbol in ring degree colon none; do
    gmt basemap -R0/2/0/1 -JM5c -Baf -BWSen+t"$symbol" --MAP_DEGREE_SYMBOL=$symbol -c
done
gmt subplot end
gmt end show