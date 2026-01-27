gmt begin map
gmt set MAP_TITLE_OFFSET -15p FONT_TITLE 15p,Courier-Bold
gmt subplot begin 1x5 -Fs4c -JM4c -R-158.3/-157.6/21.2/21.8 -B+n -M0
gmt coast -B+t"-Df" -W1p -Df -c
gmt coast -B+t"-Dh" -W1p -Dh -c
gmt coast -B+t"-Di" -W1p -Di -c
gmt coast -B+t"-Dl" -W1p -Dl -c
gmt coast -B+t"-Dc" -W1p -Dc -c
gmt subplot end
gmt end show