gmt begin map pdf,png
REM GMT处理中文存在一些已知BUG
REM 需要设置 PS_CHAR_ENCODING 为 Standard+ 以绕过这一BUG
gmt set PS_CHAR_ENCODING Standard+
gmt set FONT_TITLE 25p,STHeiti-Regular--UniGB-UTF8-H,black
gmt set FONT_LABEL 15p,STSong-Light--UniGB-UTF8-H,black

echo 2 3.5 25p,STSong-Light--UniGB-UTF8-H,black 中文宋体  > tmp
echo 2 2.5 25p,STFangsong-Light--UniGB-UTF8-H,blue  中文仿宋 >> tmp
echo 2 1.5 25p,STHeiti-Regular--UniGB-UTF8-H,red   中文黑体 >> tmp
echo 2 0.5 25p,STKaiti-Regular--UniGB-UTF8-H,green 中文楷体 >> tmp
echo 4 3.5 25p,STSong-Light--UniGB-UTF8-V,black 中文宋体 >> tmp
echo 5 3.5 25p,STFangsong-Light--UniGB-UTF8-V,blue  中文仿宋 >> tmp
echo 6 3.5 25p,STHeiti-Regular--UniGB-UTF8-V,red   中文黑体 >> tmp
echo 7 3.5 25p,STKaiti-Regular--UniGB-UTF8-V,green 中文楷体 >> tmp

gmt text tmp -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" -BWSen+t"中文标题" -F+f
del tmp
gmt end
