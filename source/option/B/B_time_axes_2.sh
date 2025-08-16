gmt begin GMT_-B_time2
    gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY +9p
    gmt basemap -R1969-7-21T/1969-7-23T/0/1 -JX5i/0.2i -Bpxa6Hf1h -Bsxa1K -BS
    gmt basemap -Bpxa6Hf1h -Bsxa1D -BS -Y0.65i
gmt end show