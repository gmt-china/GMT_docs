PS=chinese-months.ps
# 设置GMT语言为中文
gmt set GMT_LANGUAGE cn1
# 设置标注的字体为中文字体
gmt set FONT_ANNOT_PRIMARY 16p,39,black

# FORMAT_TIME_PRIMARY_MAP 为 full 表示显示“一月”
gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP full
gmt psbasemap -R1997T/1998T/0/10 -JX25c/4c -Bpxa1O -Byaf -BWSen -K -Y8c > $PS

# FORMAT_TIME_PRIMARY_MAP 为 abbreviated 表示显示“一”
gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP abbreviated
gmt psbasemap -R1997T/1998T/0/10 -JX25c/4c -Bpxa1O -Byaf -BWSen -Y-6c -O >> $PS
gmt psconvert -A -P -Tg $PS
rm gmt.*
