gmt begin PB2002 pdf,png
gmt coast -JH20c -Rg -B0 -B+t'PB2002' -W1/0.1p,black -A1000
gmt plot PB2002_plates.dig.txt -W0.5p,red
gmt end show
