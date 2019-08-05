gmt begin map pdf,png C-sFONTPATH=C:\windows\fonts
gmt set FONT_TITLE 25p,41,black
gmt set FONT_LABEL 15p,39,black

echo 2 3.5 25p,39,black 宋体横排  > tmp
echo 2 2.5 25p,40,blue  仿宋横排 >> tmp
echo 2 1.5 25p,41,red   黑体横排 >> tmp
echo 2 0.5 25p,42,green 楷体横排 >> tmp
echo 4 3.5 25p,43,black 宋体竖排 >> tmp
echo 5 3.5 25p,44,blue  仿宋竖排 >> tmp
echo 6 3.5 25p,45,red   黑体竖排 >> tmp
echo 7 3.5 25p,46,green 楷体竖排 >> tmp

gmt text tmp -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" -BWSen+t"中文标题" -F+f
del tmp
gmt end
