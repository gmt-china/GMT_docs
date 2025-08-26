#!/usr/bin/env bash
gmt begin plot_-Sq_3
    gmt coast -R50/160/-15/15 -JM5.3i -Gburlywood -Sazure -A500 -B20f10 -BWSne
    # -i0,1,4 提取数据文件中的第1，2，5列
    # -Em150 每150行提取一个数据。原数据的测线为每 10km 一个测点，这项的意思即为每 1500km 提取一个数据
    # 提取出的第1，2，5列通过管道传送给 gawk 时，就变成了第1，2，3列。
    # int($3) 将第三列数据取整
    gmt convert -i0,1,4 -Em150 @App_O_transect.txt | gawk '{print $1,$2,int($3)}' > fix2.txt
    # -Sqffix2.txt 读取 fix2.txt 前两列作为标注文字的坐标
    # +Lf 从 fix2.txt 第二列之后读取所有文字作为标注内容
    gmt plot -Sqffix2.txt:+g+an+p+Lf+u" m"+f8p -Wthick @App_O_transect.txt
gmt end show