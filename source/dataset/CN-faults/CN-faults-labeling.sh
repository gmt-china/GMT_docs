gmt begin CN-faults-labeling C-I${HOME}/.gmt/
    # GMT 处理中文存在一些已知 BUG
    # 需要设置 PS_CHAR_ENCODING 为 Standard+ 以绕过这一BUG
    gmt set PS_CHAR_ENCODING Standard+
    gmt coast -JM10c -RTW -Baf -W0.5p,black
    # -Sqn1 小写的 n 表示标注位置在每段断层的中心，1即只绘制一个标注
    # +Lh 从数据头段 -L 中读取标注文字
    # +f6p,39 设置字体属性，大小为6p，字体编号为39号中文字体
    gmt convert CN-faults.gmt -aL="FN_Ch" | gmt plot -Sqn1:+Lh+f6p,39
gmt end show
