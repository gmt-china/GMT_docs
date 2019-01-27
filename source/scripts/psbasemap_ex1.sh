#!/bin/bash
R=115/123/35/40             # 小区域地图的范围-R
J=M20c                      # 小区域的投影方式-J
PS=psbasemap_ex1.ps

# 打开GMT
gmt psxy -R$R -J$J -T -K > $PS

# 绘制小区域的地图
gmt pscoast -R$R -J$J -B1 -Df -W2p -I2p -N1/2p -A1000 -K -O >> $PS
# ...
# 此处可以任意添加其他绘图命令
# ...

# 开始绘制inset map
Rg=72/135/16/55     # 大区域地图的范围-R
Jg=M7c              # 大区域地图的投影方式-J
# 绘制大区域地图的海岸线及边框
gmt pscoast -R$Rg -J$Jg -B0 -B+gwhite -Df -N1 -W -A5000 -K -O --MAP_FRAME_TYPE=plain >> $PS
# 在大区域地图内绘制小区域所在的方框
gmt psbasemap -R$Rg -J$Jg -D$R -F+p2p,blue -K -O >> $PS

# 结束GMT绘图
gmt psxy -R$R -J$J -T -O >> $PS
rm gmt.*
