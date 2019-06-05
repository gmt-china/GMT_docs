gmt begin
gmt set MAP_FRAME_PEN thinner MAP_TICK_LENGTH_PRIMARY 0.2c
gmt set FONT_TITLE 10p,1 MAP_TITLE_OFFSET 5p

for cpt in \
    abyss \
    bathy \
    batlow \
    berlin \
    bilbao \
    broc \
    categorical \
    cool \
    copper \
    cork \
    cubhelix \
    cyclic \
    davos \
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
    grayC \
    hawaii \
    haxby \
    hot \
    ibcso \
    inferno \
    jet \
    lajolla \
    lapaz \
    lisbon \
    magma \
    nighttime \
    no_green \
    ocean \
    oleron \
    oslo \
    paired \
    panoply \
    plasma \
    polar \
    rainbow \
    red2green \
    relief \
    roma \
    seafloor \
    sealand \
    seis \
    split \
    srtm \
    terra \
    tofino \
    tokyo \
    topo \
    turku \
    vik \
    viridis \
    world \
    wysiwyg
do
    gmt figure $cpt PNG,pdf
    #gmt basemap -R0/6/0/2 -JX6c/0.9c -B+t"$cpt"
    gmt plot -R0/6/0/2 -JX6c/1c -T
    gmt makecpt -C$cpt
    gmt colorbar -D0c/0.5c+w6c/0.4c+h+jBL -C -B0
    gmt makecpt -C$cpt -T-1/1/0.25
    gmt colorbar -D0c/0.0c+w6c/0.4c+h+jBL -C -Bf0.25
done
gmt end
