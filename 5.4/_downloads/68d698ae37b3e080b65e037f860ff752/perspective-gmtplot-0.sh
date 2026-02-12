PS=p-option-example-2D.ps
gmt set FONT_TITLE 15p PS_MEDIA 40cx40c
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=90" -p180/90 -Y18c -K > $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=90" -p135/90 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=90" -p90/90 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=90" -p45/90 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=90" -p0/90 -X7c -K -O >> $PS

gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=60" -p180/60 -Y-6c -X-28c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=60" -p135/60 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=60" -p90/60 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=60" -p45/60 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=60" -p0/60 -X7c -K -O >> $PS

gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=30" -p180/30 -Y-6c -X-28c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=30" -p135/30 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=30" -p90/30 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=30" -p45/30 -X7c -K -O >> $PS
gmt psbasemap -JX4c/4c -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=30" -p0/30 -X7c -O >> $PS
gmt psconvert -A -P -Tf $PS
