gmt begin chinese-texts png,pdf C-I${HOME}/.gmt/

# 左图
gmt set FONT_TITLE 24p,STHeiti-Regular--UniGB-UTF8-H,black FONT_LABEL 16p,STSong-Light--UniGB-UTF8-H,black
gmt basemap -R0/10/0/5 -JX6c/4c -Bxaf+l"横轴" -Byaf+l"纵轴" -BWSen+t"中文标题"
gmt text -F+f << EOF
3 2.5 20p,STSong-Light--UniGB-UTF8-H,black 横排文字
8 4.0 20p,STSong-Light--UniGB-UTF8-V,red   竖排文字
EOF

# 中图
gmt set FONT_TITLE 24p,STHeiti-Regular--UniGB-UTF8-H,black FONT_LABEL 16p,STSong-Light--UniGB-UTF8-H,black
gmt basemap -R0/10/0/5 -JX6c/4c -Bxaf+l"横轴" -Byaf+L"纵轴" -BWSen+t"中文标题" -X9c
gmt text -F+f << EOF
3 2.5 20p,STSong-Light--UniGB-UTF8-H,black 横排文字
8 4.0 20p,STSong-Light--UniGB-UTF8-V,red   竖排文字
EOF

# 右图
gmt set FONT_TITLE 24p,STHeiti-Regular--UniGB-UTF8-H,black FONT_LABEL 16p,STSong-Light--UniGB-UTF8-H,black
gmt basemap -R0/10/0/5 -JX6c/4c -Bxaf+l"横轴" -BWSen+t"中文标题" -X9c
gmt basemap -Byaf+L"纵轴" -BW --FONT_LABEL=16p,STSong-Light--UniGB-UTF8-V,black --MAP_LABEL_OFFSET=20p
gmt text -F+f << EOF
3 2.5 20p,STSong-Light--UniGB-UTF8-H,black 横排文字
8 4.0 20p,STSong-Light--UniGB-UTF8-V,red   竖排文字
EOF

gmt end show
