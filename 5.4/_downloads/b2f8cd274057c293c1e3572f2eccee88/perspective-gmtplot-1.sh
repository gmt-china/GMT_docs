PS=p-option-example-3D.ps
gmt set FONT_ANNOT_PRIMARY 8p
gmt set MAP_FRAME_PEN 1p
gmt set MAP_TICK_LENGTH_PRIMARY 4p/2p
gmt set FONT_TITLE 10p

p=135/40
gmt psbasemap -R0/10/0/10/0/20 -JX3c -JZ3c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -K > $PS

p=135/40/10
gmt psbasemap -R0/10/0/10/0/20 -JX3c -JZ3c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -K -O -X6c >> $PS

p=x135/40/10
gmt psbasemap -R0/10/0/10/0/20 -JX3c -JZ3c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -K -O -X6c >> $PS

p=y135/40/10
gmt psbasemap -R0/10/0/10/0/20 -JX3c -JZ3c -Baf -Bzaf -BwsENZ1+b+t"-p$p" -p$p -O -X6c >> $PS
