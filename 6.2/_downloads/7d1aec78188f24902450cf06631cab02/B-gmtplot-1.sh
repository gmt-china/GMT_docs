gmt begin 2D-axes-examples png,pdf
gmt set FONT_TITLE 15p
gmt subplot begin 1x7 -Fs4c/4c -M5p/10p
    gmt basemap -R0/4/0/4 -BWS+t"-BWS" -c
    gmt basemap -R0/4/0/4 -BWSEN+t"-BWSEN" -c
    gmt basemap -R0/4/0/4 -BWSen+t"-BWSen" -c
    gmt basemap -R0/4/0/4 -BWSrt+t"-BWSrt" -c
gmt subplot end
gmt end
