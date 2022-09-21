#!/usr/bin/env bash
gmt begin GMT_Chinese
# 设置中文字体配置文件cidfmap的路径
gmt set PS_CONVERT="C-I$(echo ~)/.gmt"

# GMT处理中文存在一些已知BUG
# 需要设置 PS_CHAR_ENCODING 为 Standard+ 以绕过这一BUG
gmt set PS_CHAR_ENCODING Standard+
gmt set FONT_TITLE 25p,41,black
gmt set FONT_LABEL 15p,39,black

gmt text -R0/8/0/4 -JX12c/4c -Bxaf+l"X轴" -Byaf+l"Y轴" -BWSen+t"中文标题" -F+f << EOF
2 3.5 25p,39,black 中文宋体
2 2.5 25p,40,blue  中文仿宋
2 1.5 25p,41,red   中文黑体
2 0.5 25p,42,green 中文楷体
4 3.5 25p,43,black 中文宋体
5 3.5 25p,44,blue  中文仿宋
6 3.5 25p,45,red   中文黑体
7 3.5 25p,46,green 中文楷体
EOF
gmt end show
