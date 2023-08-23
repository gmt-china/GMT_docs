gmt begin chinese-months png

    # 设置中文字体配置文件 cidfmap 的目录，Windows 下无需此设置
    gmt set PS_CONVERT="C-I${HOME}/.gmt"
    # 设置 GMT 语言为中文
    gmt set GMT_LANGUAGE cn1
    # 设置标注的字体为中文字体
    gmt set FONT_ANNOT_PRIMARY 16p,39,black
    
    # FORMAT_TIME_PRIMARY_MAP 为 full 表示显示“一月”
    gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP full
    gmt basemap -R1997T/1998T/0/10 -JX25c/4c -Bpxa1O -Byaf -BWSen
    
    # FORMAT_TIME_PRIMARY_MAP 为 abbreviated 表示显示“一”
    gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP abbreviated
    gmt basemap -R1997T/1998T/0/10 -JX25c/4c -Bpxa1O -Byaf -BWSen -Y-6c

gmt end show
