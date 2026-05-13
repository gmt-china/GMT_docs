gmt begin 3D-axes-examples png,pdf
gmt set FONT_TITLE 15p
gmt subplot begin 1x5 -Fs4c/4c -M1.5c
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ+t"-BwesnZ" -p130/30 -c
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -Bwesnz+t"-Bwesnz" -p130/30 -c
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ1234+t"-BwesnZ1234" -p130/30 -c
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -Bwesnz1234+t"-Bwesnz1234" -p130/30 -c
    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ+b+t"-BwesnZ+b" -p130/30 -c
gmt subplot end
gmt end
