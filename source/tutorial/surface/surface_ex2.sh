gmt begin map2
    gmt surface Table_5_11.txt -R-0.2/6.6/-0.2/6.6 -I0.05 -Gtmp.grd    

    gmt basemap -R-0.2/6.6/-0.2/6.6 -JM10c -Baf
    gmt makecpt -Cseis -T650/1000
    gmt grdimage tmp.grd
    gmt plot Table_5_11.txt -Sc0.12c -Gblack
    gmt text Table_5_11.txt -F+f6p+jLM -D3p/0 -Gwhite -W

    gmt colorbar -Baf

    rm tmp.grd
gmt end