gmt begin Roman_numerals_colorbar
    # 生成一个用于6至10级烈度图绘制的cpt
    gmt makecpt -Cseis -Ic -T6/10/1
    # 以下是绘制烈度图的代码，略
    # ...
    
    # 生成罗马数字标注的自定义轴文件

    # 第一种类型：标注对齐刻度
cat << EOF >| roman_labels_ag.txt
1        ag      I
2        ag      II
3        ag      III
4        ag      IV
5        ag      V
6        ag      VI
7        ag      VII
8        ag      VIII
9        ag      IX
10       ag      X
EOF
    #
    gmt colorbar -Dx0c/0c+w5c+h -C -G6/10 -Bxcroman_labels_ag.txt+l"Seismic Intensity" --FONT_ANNOT_PRIMARY=Times-Roman

    # 第二种类型：标注在区间中间
cat << EOF >| roman_labels_ig.txt
1        ig      I
2        ig      II
3        ig      III
4        ig      IV
5        ig      V
6        ig      VI
7        ig      VII
8        ig      VIII
9        ig      IX
10       ig      X
EOF
    #
    gmt colorbar -Dx0c/0c+w5c+h -C -G6/10 -Bxcroman_labels_ig.txt+l"Seismic Intensity" --FONT_ANNOT_PRIMARY=Times-Roman -Y-1.5c

    rm roman_labels_ag.txt roman_labels_ig.txt
gmt end show