#!/usr/bin/env bash
gmt begin plot_-Sq_1
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -B20f10 -BWSne
    # -SqD1000k 大圆弧每1000km放置一个标注
    # +g 绘制一个不透明的文本框背景
    # +LD 使用距离值作为标注的内容，单位和 -SqD 的单位保持一致
    # +an 标注文字的方向与大圆弧垂直
    # +p 添加文本框的轮廓线
    gmt plot -SqD1000k:+g+LD+an+p -Wthick @App_O_transect.txt
gmt end show