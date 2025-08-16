#!/usr/bin/env bash
gmt begin ex
    a=122/22
    ap=148/46
    # 从GMT远程服务器下载示例地震目录文件
    gmt which -Gl @quakes_2018.txt

    gmt basemap -JM10c -R116/149/20/48 -Baf
    gmt grdimage @earth_relief_04m_p -Cgeo
    # 绘制 a-ap 测线。生成测线时以0.1度为间隔输出坐标点。
    gmt project -C${a} -E${ap} -G0.1 | gmt plot -W1p,cyan
    # 示例文件前三列分别为经度、纬度、深度
    # 根据深度绘制不同颜色的圆点
    gmt makecpt -Cmagma -T0/600/1 -I
    gmt colorbar -Bxaf+lDepth -C
    gmt plot quakes_2018.txt -Sc0.2c -C -W0.1

    # 绘制地表
    gmt basemap -JP10c+a+t18 -R0/36/5711/6371 -Byg6371 -BS -Y11c
    # 绘制 410 界面
    gmt basemap -Byg6371+5961 -BS
    # 绘制 660 界面
    gmt basemap -Byg6371+5711 -BS
    # 把数据投影到 a-ap 剖面，限制为剖面两侧30度范围的数据
    gmt project quakes_2018.txt -C${a} -E${ap} -Fpz -Lw -W-30/30 | gawk '{print $1,6371-$2,$2}' | gmt plot -Sc0.15c -C -W0.1p -N
gmt end show
