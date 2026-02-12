PS=map_degree_symbol.ps
symbol=ring
gmt set FONT_TITLE 18p MAP_TITLE_OFFSET 0p
gmt psbasemap -R0/2/0/1 -JM5c -Baf -BWSen+t"$symbol" --MAP_DEGREE_SYMBOL=$symbol -K > $PS
for symbol in degree colon none; do
    gmt psbasemap -R -J -Baf -BWSen+t"$symbol" --MAP_DEGREE_SYMBOL=$symbol -X7c -K -O >> $PS
done
gmt psxy -R -J -T -O >> $PS
rm gmt.*