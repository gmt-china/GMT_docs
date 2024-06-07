#!/usr/bin/env bash
#
# 绘制地形起伏剖面图

gmt begin profile

    gmt basemap -JM12c -R122/149/30/48 -Baf
    # 让0到2000m海拔的颜色从白，灰再到黑色渐变，生成cpt
    gmt makecpt -Cwhite,gray,black -T0/2000 -Z
    # 绘制灰度地形底图
    gmt grdimage @earth_relief_04m -C -I+d
    # 用蓝色填充海洋
    gmt coast -S167/194/223
    # 选取测线AB
    echo 126 42 A > tmp1
    echo 146 40 B >> tmp1
    # 绘制测线AB
    gmt plot tmp1 -W2p,red,-.-
    # 标注AB
    gmt text tmp1 -F+f15p -D0c/0.2c 
    
    # 沿测线AB绘制地形高度
    gmt basemap -R0/15/-8000/6000 -JX12c/3c -Bya4000+l"Elevation (m)" -Bxa2f1+l"Distance"+u"\260" -BWSrt -Y12c
    # 标注AB位置
    echo 0 7000 A | gmt text -F+f10p+jBC -N
    echo 15 7000 B | gmt text -F+f10p+jBC -N
    # 沿测线提取地形高度
    gmt project -C126/42 -E146/40 -G0.1 | gmt grdtrack -G@earth_relief_04m > tmp2
    # 将海平面以下填充为淡蓝色
    echo 0 0 > tmp3
    echo 15 0 >> tmp3
    gmt plot tmp3 -Wblack -Glightblue -L+y-8000
    # 将地形填充为灰色
    gmt plot tmp2 -i2,3 -Wblack -Ggray -L+y-8000 

    # 删除临时文件
    rm tmp*
gmt end show
