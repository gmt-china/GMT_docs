#!/usr/bin/env bash
gmt begin contour_annot1
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
    # @App_O_geoid.nc 是 GMT 远程数据服务器自带的网格数据
    # -C10：以10为间隔绘制等值线
    # -A20+f8p：以20为间隔对等值线进行标注，标注字体大小设置为8p。有标注的等值线会被加粗。
    # -Gd1.5i：沿等值线每1.5英寸放置一个标注
    # -T+lLH：在极小值和极大值区域标注 L 和 H 
    gmt grdcontour @App_O_geoid.nc -B20f10 -BWSne -C10 -A20+f8p -Gd1.5i -S10 -T+lLH
gmt end show
