gmt begin custom
    # 生成指北针符号自定义文件
    cat > compass.def << 'EOF'
N: 1 a
$1 O
0 0.5 M -Gblack
0.25 -0.5 D
0 -0.3 D
0 -0.3 M
-0.25 -0.5 D
0 0.5 D
EOF

    # 绘制底图
    gmt basemap -R-1/1/-1/1 -JM5c -Baf

    # 在(0,0)位置绘制大小为1c的compass符号，旋转角0度
    echo 0 0 0 | gmt plot -Skcompass/1c

gmt end show