gmt begin chinese-weeks png

    gmt set PS_CONVERT="C-I${HOME}/.gmt"
    # 设置 GMT 语言为中文
    gmt set GMT_LANGUAGE cn1
    # 设置标注的字体为中文字体
    gmt set FONT_ANNOT_PRIMARY 12p,39
    
    # FORMAT_TIME_PRIMARY_MAP 为 full 表示显示“星期一”
    gmt set FORMAT_DATE_MAP u FORMAT_TIME_PRIMARY_MAP full
    gmt basemap -R1969-7-21T/1969-7-28T/0/4 -JX15c/3c -Bpxa1K -Byaf -BWSen
    
    # FORMAT_TIME_PRIMARY_MAP 为 abbreviated 表示显示“周一”
    gmt set FORMAT_DATE_MAP u FORMAT_TIME_PRIMARY_MAP abbreviated
    gmt basemap -R1969-7-21T/1969-7-28T/0/4 -JX15c/3c -Bpxa1K -Byaf -BWSen -Y-5c

gmt end show
