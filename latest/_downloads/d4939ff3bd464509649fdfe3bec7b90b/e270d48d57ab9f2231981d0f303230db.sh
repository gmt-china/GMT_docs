gmt begin vector-head
for symbol in t c a A i I; do
    echo 1 1 0 3 | gmt plot -R0/5/0/2 -JX2c/1c -Sv0.5c+b${symbol} -W1.5p -Gred -X2.2c
    echo 3 0.5 -Sv0.5c+b$symbol | gmt text -F+f7p,9 -N
done
gmt end show