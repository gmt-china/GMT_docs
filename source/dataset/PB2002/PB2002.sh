gmt begin PB2002
    gmt coast -JH20c -Rg -B0 -B+tPB2002 -W1/0.1p,black -A1000
    gmt plot PB2002_boundaries.dig.txt -W0.5p,red
gmt end show
