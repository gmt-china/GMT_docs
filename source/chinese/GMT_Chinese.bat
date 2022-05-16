gmt begin map pdf,png
REM GMT在Windows下处理中文存在一些已知BUG
REM 需要设置 PS_CHAR_ENCODING 为 Standard+ 以绕过这一BUG
gmt set PS_CHAR_ENCODING Standard+
gmt set FONT_TITLE 25p,41,black
gmt set FONT_LABEL 15p,39,black

REM GMT 6.3每一行含中文的命令前都必须加一句 chcp 936
chcp 936
echo 2 3.5 25p,39,black 中文宋体  > tmp
echo 2 2.5 25p,40,blue  中文仿宋 >> tmp
echo 2 1.5 25p,41,red   中文黑体 >> tmp
echo 2 0.5 25p,42,green 中文楷体 >> tmp
echo 4 3.5 25p,43,black 中文宋体 >> tmp
echo 5 3.5 25p,44,blue  中文仿宋 >> tmp
echo 6 3.5 25p,45,red   中文黑体 >> tmp
echo 7 3.5 25p,46,green 中文楷体 >> tmp

REM GMT 6.3每一行含中文的命令前都必须加一句 chcp 936
chcp 936
gmt text tmp -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" -BWSen+t"中文标题" -F+f
del tmp
gmt end
