gmt begin p-option-example-3D
gmt set FONT_ANNOT_PRIMARY 8p
gmt set MAP_FRAME_PEN 1p
gmt set MAP_TICK_LENGTH_PRIMARY 4p/2p
gmt set FONT_TITLE 10p

gmt subplot begin 1x4 -Fs4c/4c -M1c/10p
    p=135/40
    gmt basemap -R0/10/0/10/0/20 -JZ4c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -c

    p=135/40/10
    gmt basemap -R0/10/0/10/0/20 -JZ4c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -c

    p=x135/40/10
    gmt basemap -R0/10/0/10/0/20 -JZ4c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -c

    p=y135/40/10
    gmt basemap -R0/10/0/10/0/20 -JZ4c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -c
gmt subplot end
gmt end show
