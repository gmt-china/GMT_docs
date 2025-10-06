gmt begin Jp
gmt set FORMAT_GEO_MAP +D FONT_TITLE 12p,1,red
gmt basemap -JP4c  -R0/360/0/1 -Bxa45f -B+t"-JP4c -R0/360/0/1" -Yc -Xc
gmt basemap -JP4c+a -R0/360/0/1 -Bxa45f -B+t"-JP4c+a -R0/360/0/1" -X5.5c
gmt basemap -JP3c+a -R0/90/0/1 -Bxa45f -Bya0.2 -BWNe+t"-JP3c+a -R0/90/0/1" -X-5.5c -Y-5c
gmt basemap -JP4c+a+t45 -R0/90/0/1 -Bxa45f -Bya0.2 -BWNse+t"-JP4c+a+t45 -R0/90/0/1" -X5.5c 
gmt set FORMAT_GEO_MAP +D FONT_TITLE 10p,1,red
gmt basemap -JP4c+a+t45 -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t"-JP4c+a+t45 -R0/90/3480/6371" -X-5.5c -Y-4c
gmt basemap -JP4c+a+t45+z -R0/90/3480/6371 -Bxa45f -Bya -BWNse+t'-JP4c+a+t45\053z -R0/90/3480/6371' -X5.5c
gmt end show
