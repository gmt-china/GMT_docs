PS=chinese-texts.ps

# 左图
gmt set FONT_TITLE 20p,41,black FONT_LABEL 16p,39,black
gmt psbasemap -R0/10/0/5 -JX6c/4c -Bxaf+l'横轴' -Byaf+l'纵轴' -BWSen+t'中文标题' -K -P > $PS
gmt pstext -J -R -F+f -K -O >> $PS << EOF
3 2.5 20p,39,black 横排文字
8 4.0 20p,43,red   竖排文字
EOF

# 右图
gmt set FONT_TITLE 20p,41,black FONT_LABEL 16p,39,black
gmt psbasemap -R0/10/0/5 -JX6c/4c -Bxaf+l'横轴' -Byaf+L'纵轴' -BWSen+t'中文标题' -K -O -X10c >> $PS
gmt pstext -J -R -F+f -O >> $PS << EOF
3 2.5 20p,39,black 横排文字
8 4.0 20p,43,red   竖排文字
EOF

gmt psconvert -A -P -Tg $PS
rm gmt.*
