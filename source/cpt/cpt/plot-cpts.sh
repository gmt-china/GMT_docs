gmt set MAP_FRAME_PEN thinner MAP_TICK_LENGTH_PRIMARY 0.2c
gmt set FONT_TITLE 10p,1 MAP_TITLE_OFFSET 5p

for cpt in \
    abyss \
    bathy \
    categorical \
    cool \
    copper \
    cubhelix \
    cyclic \
    dem1 \
    dem2 \
    dem3 \
    dem4 \
    drywet \
    earth \
    elevation \
    etopo1 \
    gebco \
    geo \
    globe \
    gray \
    haxby \
    hot \
    ibcso \
    inferno \
    jet \
    magma \
    nighttime \
    no_green \
    ocean \
    paired \
    panoply \
    plasma \
    polar \
    rainbow \
    red2green \
    relief \
    seafloor \
    sealand \
    seis \
    split \
    terra \
    topo \
    viridis \
    world \
    wysiwyg
do
    #gmt psbasemap -R0/6/0/2 -JX6c/0.9c -B+t"$cpt"
    PS=$cpt.ps
    gmt psxy -R0/6/0/2 -JX6c/1c -T -K > $PS
    gmt makecpt -C$cpt > tt1.cpt
    gmt makecpt -C$cpt -T-1/1/0.25 > tt2.cpt
    gmt psscale -J -R -D0c/0.5c+w6c/0.4c+h+jBL -Ctt1.cpt -B0 -K -O >> $PS
    gmt psscale -J -R -D0c/0.0c+w6c/0.4c+h+jBL -Ctt2.cpt -Bf0.25 -O >> $PS
    gmt psconvert -A -P -Tf $PS
    gmt psconvert -A -P -TG $PS
    rm tt1.cpt tt2.cpt
done
rm gmt.*
