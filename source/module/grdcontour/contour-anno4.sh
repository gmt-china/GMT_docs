#!/usr/bin/env bash
gmt begin contour_annot4
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500
    # -GLZ-/Z+：定义一条大圆路径连线，为数据 @App_O_geoid.nc 中最大值和最小值点的连线
    # 在该连线与等值线的交点上进行标注
    # 使用 -A 中的 +d 附加选项会绘制出连线。如果不想绘制连线可以去掉 +d
    gmt grdcontour @App_O_geoid.nc -B20f10 -BWSne -C10 -A20+f8p+d -GLZ-/Z+ -S10 -T+lLH
gmt end show
