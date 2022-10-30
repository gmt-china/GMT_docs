gmt begin chinese-compass png
    # 设置GMT语言为中文
    gmt set GMT_LANGUAGE cn1
    # 设置标注的字体为中文字体
    gmt set FONT_TITLE 12p,39
    # 方向玫瑰图
    gmt basemap -R-7/7/-5/5 -Tdg0/0+w0.6i+f3+l+jCM
    # 磁场玫瑰图
    gmt basemap -R-7/7/-5/5 -Tmg0/0+w1i+d-14.5+t45/10/5+i0.25p,blue+p0.25p,red+l+jCM -X1.5i 
gmt end show
