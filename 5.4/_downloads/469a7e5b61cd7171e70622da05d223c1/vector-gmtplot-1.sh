PS=vector-head.ps
gmt psxy -R0/5/0/2 -JX2c/1c -K -T > $PS
for symbol in t c a A i I; do
    echo 1 1 0 3 | gmt psxy -R -J -Sv0.5c+b${symbol} -W1.5p -Gred -X2c -K -O >> $PS
    echo 3 0.5 $symbol | gmt pstext -R -J -F+f15p,9 -N -K -O >> $PS
done
gmt psxy -R -J -O -T >> $PS