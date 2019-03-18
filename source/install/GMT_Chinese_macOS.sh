#!/bin/bash
gmt set FONT_TITLE 25p,41,black
gmt set FONT_LABEL 15p,39,black

gmt pstext -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" \
    -BWSen+t"中文标题" -F+f -P > GMT_Chinese_macOS.ps << EOF
2 3.5 25p,39,black 宋体横排
2 2.5 25p,40,blue  仿宋横排
2 1.5 25p,41,red   黑体横排
2 0.5 25p,42,green 楷体横排
4 3.5 25p,43,black 宋体竖排
5 3.5 25p,44,blue  仿宋竖排
6 3.5 25p,45,red   黑体竖排
7 3.5 25p,46,green 楷体竖排
EOF
gmt psconvert -A -P -Tf GMT_Chinese_macOS.ps
gmt psconvert -A -P -Tg GMT_Chinese_macOS.ps

rm gmt.*
