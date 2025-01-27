gmt begin ex006
    # 绘制底图
    gmt basemap -R7.5/10.5/49/50.5 -JM10c -Baf

    # 将原始数据处理为需要的格式
    gmt convert data.txt -Fv -o0:4 > trackv.txt
    # 根据飞行的高度范围生成cpt
    gmt makecpt -T0/20000/1 -Z -Cseis
    # 根据飞行高度，绘制颜色渐变的线段
    gmt plot trackv.txt -Sv1p+s -W2p+cl -C

    rm trackv.txt
gmt end show