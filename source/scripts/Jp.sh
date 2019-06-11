gmt set FORMAT_GEO_MAP +D FONT_TITLE 14p,1,red
gmt psbasemap -JP5c  -R0/360/0/1 -Bxa45f -B+t"-JP5c -R0/360/0/1" -Y10c -K > Jp.ps
gmt psbasemap -JPa5c -R0/360/0/1 -Bxa45f -B+t"-JPa5c -R0/360/0/1" -X8c -K -O >> Jp.ps
gmt psbasemap -JPa5c -R0/90/0/1 -Bxa45f -Bya0.2 -BWNe+t"-JPa5c -R0/90/0/1" -X8c -K -O >> Jp.ps
gmt psbasemap -JPa5c/45 -R0/90/0/1 -Bxa45f -Bya0.2 -BWNse+t"-JPa5c/45 -R0/90/0/1" -X-16c -Y-6.5c -K -O >> Jp.ps
gmt psbasemap -JPa5c/45 -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t"-JPa5c/45 -R0/90/3480/6371" -X8c -Y1c -K -O >> Jp.ps
gmt psbasemap -JPa5c/45z -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t"-JPa5c/45z -R0/90/3480/6371" -X8c -O >> Jp.ps
