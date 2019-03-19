gmt begin chinese-texts-2 png
gmt set FONT_TITLE 24p,41,black FONT_LABEL 16p,39,black
gmt basemap -R0/10/0/5 -JX10c/5c -Bxaf+l'横轴' -Byaf -BWSen+t'中文标题'
echo 纵轴 | gmt text -F+f16p,43+cML -D-1.25c/0.5c -N
gmt text -F+f << EOF
3 2.5 25p,39,black 横排文字
8 4.0 25p,43,red   竖排文字
EOF
gmt end
