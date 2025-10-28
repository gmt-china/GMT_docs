#!/usr/bin/env bash
gmt begin plot_-Sq_2
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -B20f10 -BWSne
    # -SqD15d 大圆弧每15弧度放置一个标注
    # +gblack 文本框背景黑色，+fwhite 标注文字白色
    # +o 使用圆角矩形文本框
    # +u@. 添加度单位。详细可以参考 基础知识 -> 转义序列 章节了解如何输出度符号
    gmt plot -SqD15d:+gblack+fwhite+LD+o+u@. -Wthick @App_O_transect.txt
gmt end show