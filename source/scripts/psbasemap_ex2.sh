#!/bin/bash
ps=psbasemap_ex2.ps

# 绘制澳大利亚的海岸线
gmt pscoast -R110E/170E/44S/9S -JM6i -P -Baf -BWSne -Wfaint -N2/1p -EAU+gbisque \
        -Gbrown -Sazure1 -Da -K -Xc --FORMAT_GEO_MAP=dddF > $ps
		
# 特别注意：其他绘图命令在inset box之前写，因为绘图起点将被改变

# 最后在右上角绘制inset box,并利用-D的+t子选项把绘图起点移到inset box的左下角
gmt psbasemap -R -J -O -K -DjTR+w1.5i+o0.15i+t -F+gwhite+p1p+c0.1c+s >> $ps
# 在inset box内绘制全球地图，并突出显示澳大利亚。其中-J选项的1.5i表示inset box的宽度，由上句-D选项的+w决定
gmt pscoast -Rg -JG120/30S/1.5i -Da -Gbrown -A5000 -Bg -Wfaint -EAU+gbisque -O -K >> $ps

gmt psxy -R -J -O -T >> $ps

rm gmt.*
