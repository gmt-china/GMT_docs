gmt begin B_time5 pdf,png
gmt set FORMAT_DATE_MAP u FORMAT_TIME_PRIMARY_MAP Character FORMAT_TIME_SECONDARY_MAP full \
	FONT_ANNOT_PRIMARY +9p
gmt basemap -R1969-7-21T/1969-8-9T/0/1 -JX5i/0.2i -Bpa1K -Bsa1U -BS
gmt set FORMAT_DATE_MAP o TIME_WEEK_START Sunday FORMAT_TIME_SECONDARY_MAP Chararacter
gmt basemap -Bpa3Kf1k -Bsa1r -BS -Y0.65i 
gmt end