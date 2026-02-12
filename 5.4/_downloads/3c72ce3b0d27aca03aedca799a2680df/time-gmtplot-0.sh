PS=time_is_interval.ps
gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP Abbr FONT_ANNOT_PRIMARY +9p
gmt psbasemap -R1997-01-01T/1997-07-01T/0/2 -JX10c/2c -Ba1Of1o -BWSen -K > $PS
for value in off +1o -1o; do
    gmt set TIME_IS_INTERVAL=$value
    echo 1997-03-05 1 | gmt psxy -J -R -Sc0.2c -Gred -K -O >> $PS
    echo 1997-03-05 1 $value | gmt pstext -J -R -F+jBC -D0c/0.2c -K -O >> $PS
done
gmt psxy -J -R -T -O >> $PS