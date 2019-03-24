gmt begin p-option-example-2D png,pdf
gmt set FONT_TITLE 15p
gmt subplot begin 3x5 -Fs4c/4c -M1c/10p
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=90" -p180/90 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=90" -p135/90 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=90" -p90/90 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=90" -p45/90 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=90" -p0/90 -c

    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=60" -p180/60 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=60" -p135/60 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=60" -p90/60 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=60" -p45/60 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=60" -p0/60 -c

    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=180 evel=30" -p180/30 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=135 evel=30" -p135/30 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=90 evel=30" -p90/30 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=45 evel=30" -p45/30 -c
    gmt basemap -R0/10/0/10 -Baf -BWSen+t"azim=0 evel=30" -p0/30 -c
gmt subplot end
gmt end
