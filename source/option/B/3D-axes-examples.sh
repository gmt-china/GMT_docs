gmt begin 3D-axes-examples png,pdf
gmt set FONT_TITLE 15p
gmt subplot begin 1x7 -Fs4c/4c -M20p/10p
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ+t'-BwesnZ' -p130/30 -c1,1
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -Bwesnz+t'-Bwesnz' -p130/30 -c1,2
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ1234+t'-BwesnZ1234' -p130/30 -c1,3
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -Bwesnz1234+t'-Bwesnz1234' -p130/30 -c1,4
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ+b+t'-BwesnZ+b' -p130/30 -c1,5
gmt subplot end
gmt end
