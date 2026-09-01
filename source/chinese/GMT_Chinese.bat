gmt begin map pdf,png
REM GMT处理中文存在一些已知BUG
REM 需要设置 PS_CHAR_ENCODING 为 Standard+ 以绕过这一BUG
gmt set PS_CHAR_ENCODING Standard+
gmt set FONT_TITLE 25p,STHeiti-Regular--GB-EUC-H,black
gmt set FONT_LABEL 15p,STSong-Light--GB-EUC-H,black

REM GMT 6.3 及之后的版本连续使用echo命令输出含中文的文件时，必须在开始设置 chcp 936，即 GB 编码
chcp 936
echo 2 3.5 25p,STSong-Light--GB-EUC-H,black 中文宋体  > tmp
echo 2 2.5 25p,STFangsong-Light--GB-EUC-H,blue  中文仿宋 >> tmp
echo 2 1.5 25p,STHeiti-Regular--GB-EUC-H,red   中文黑体 >> tmp
echo 2 0.5 25p,STKaiti-Regular--GB-EUC-H,green 中文楷体 >> tmp
echo 4 3.5 25p,STSong-Light--GB-EUC-V,black 中文宋体 >> tmp
echo 5 3.5 25p,STFangsong-Light--GB-EUC-V,blue  中文仿宋 >> tmp
echo 6 3.5 25p,STHeiti-Regular--GB-EUC-V,red   中文黑体 >> tmp
echo 7 3.5 25p,STKaiti-Regular--GB-EUC-V,green 中文楷体 >> tmp

REM GMT 6.3 及之后的版本每句使用中文的命令之前必须设置 chcp 936，即 GB 编码
chcp 936
gmt text tmp -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" -BWSen+t"中文标题" -F+f
del tmp
gmt end
