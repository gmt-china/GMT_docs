PS=vector-head.ps
gmt psxy -R0/5/0/2 -JX2c/1c -K -T > $PS
for shape in -2 -1 0 1 2; do
    echo 1 1 0 1.5 | gmt psxy -R -J -Sv0.5c+b+h$shape -W1.5p -Gred -X2c -K -O >> $PS
    echo 3 0.5 +h$shape | gmt pstext -R -J -F+f8p,9 -N -K -O >> $PS
done
gmt psxy -R -J -O -T >> $PS