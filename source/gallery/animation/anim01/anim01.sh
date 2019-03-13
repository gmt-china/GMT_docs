#!/bin/bash
n_frames=18  # 帧数
name=anim01  # 文件名前缀

. gmt_shell_functions.sh

# 绘制静态的底图
angle_step=`gmt math -Q 360 ${n_frames} DIV =`
angle_inc=`gmt math -Q ${angle_step} 10 DIV =`
gmt psbasemap -R0/360/-1.2/1.6 -JX3.5i/1.65i -P -K -X0.35i -Y0.25i \
    -BWSne+glightgreen -Bxa90g90f30+u\\312 -Bya0.5f0.1g1 \
    --PS_MEDIA=4ix2i --FONT_ANNOT_PRIMARY=9p > $$.map.ps

mkdir -p $$  # $$是当前进程的ID，用于构建唯一的文件夹和文件名
frame=0
# 开始循环生成静态图片
while [ ${frame} -le ${n_frames} ]; do
    # 文件名格式为 name_##
    file=`gmt_set_framename ${name} ${frame}`
    cp -f $$.map.ps $$.ps
    angle=`gmt math -Q ${frame} ${angle_step} MUL =`
    if [ ${frame} -gt 0 ]; then  # 第一张图不绘制曲线
        # 绘制曲线
        gmt math -T0/${angle}/${angle_inc} T SIND = $$.sin.d
        gmt psxy -R -J -O -K -W1p,blue $$.sin.d >> $$.ps
        gmt math -T0/${angle}/${angle_step} T SIND = $$.sin.d
        gmt psxy -R -J -O -K -Sc0.1i -Gdarkred $$.sin.d >> $$.ps
    fi
    # 绘制红点
    sin=`gmt math -Q ${angle} SIND =`
    gmt psxy -R -J -O -K -Sc0.1i -Gred >> $$.ps <<< "${angle} ${sin}"
    printf "0 1.6 a = %03d" ${angle} | gmt pstext -R -J -F+f14p,Helvetica-Bold+jTL \
        -N -Dj0.1i/0.05i -K -O >> $$.ps
    gmt psxy -R -J -O -T >> $$.ps

    # 将生成的PS文件转换为TIF文件
    gmt psconvert -E125 -Tt -F$$/$file $$.ps
    echo "Frame ${file} completed"

    # 递增frame
    frame=`gmt_set_framenext ${frame}`
done

# 将静态图片转换为动图
gm convert -delay 20 -loop 0 $$/${name}_*.tif ${name}.gif

# 清理
gmt_cleanup .gmt
