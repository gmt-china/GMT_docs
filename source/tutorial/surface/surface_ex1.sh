gmt begin map1
    gmt basemap -R-0.2/6.6/-0.2/6.6 -JM10c -Baf
    gmt plot Table_5_11.txt -Sc0.12c -Gblack
    gmt text Table_5_11.txt -F+f6p+jLM -D3p/0 -Gwhite -W
gmt end show