#!/bin/bash

#变量命名
J=H110/24c
R=g
PS=GMT_tutor2_1.ps
# 文件头
gmt psxy -J$J -R$R -T -K > $PS
# 底图
gmt psbasemap -Bg30 -J -R -K -O >> $PS
# 文件尾
gmt psxy -J -R -T -O >> $PS
# 删除临时文件
rm gmt.*
