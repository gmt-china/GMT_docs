gmt begin vector-shape pdf,png
for shape in -2 -1 0 1 2; do
    echo 1 1 0 1.5 | gmt plot -R0/5/0/2 -JX2c/1c -Sv0.5c+b+h$shape -W1.5p -Gred -X2c
    echo 3 0.5 +h$shape | gmt text -F+f8p,9 -N
done
gmt end