gmt begin Jp png,pdf
gmt set FORMAT_GEO_MAP +D FONT_TITLE 14p,1,red
gmt basemap -JP5c  -R0/360/0/1 -Bxa45f -B+t"-JP5c -R0/360/0/1" -Y10c
gmt basemap -JP5c+a -R0/360/0/1 -Bxa45f -B+t"-JP5c+a -R0/360/0/1" -X8c
gmt basemap -JP5c+a -R0/90/0/1 -Bxa45f -Bya0.2 -BWNe+t"-JP5c+a -R0/90/0/1" -X8c
gmt basemap -JP5c+a+t45 -R0/90/0/1 -Bxa45f -Bya0.2 -BWNse+t"-JP5c+a+t45 -R0/90/0/1" -X-16c -Y-6.5c
gmt basemap -JP5c+a+t45 -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t"-JP5c+a+t45 -R0/90/3480/6371" -X8c -Y1c
gmt basemap -JP5c+a+t45+z -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t"-JP5c+a+t45+z -R0/90/3480/6371" -X8c
gmt end show
