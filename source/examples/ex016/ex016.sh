#!/usr/bin/env bash
gmt begin ex016
    R=-R-85/5/10/55

    gmt set FORMAT_GEO_MAP ddd:mm:ssF FONT_ANNOT_PRIMARY +9p FONT_TITLE 22p
    # 生成一条纽约到 Canary Islands 的测线
    gmt project -E-74/41 -C-17/28 -G10 -Q > great_NY_Canaries.txt
    # 生成一条纽约到巴黎的测线
    gmt project -E-74/41 -C2.33/48.87 -G100 -Q > great_NY_Paris.txt
    # 计算纽约到 Canary Islands 的距离，单位 km
    km=$(echo -17 28 | gmt mapproject -G-74/41+uk -fg --FORMAT_FLOAT_OUT=%.0f -o2)

    # 生成一个离散的 CPT 文件，用来对3小时以内、3到6小时、以及6小时以上的海啸抵达时间区域进行填色
    gmt makecpt -Clightred,lightyellow,lightgreen -T0,3,6,100 -N
    # @App_O_ttt.nc 是 GMT 服务器上的远程示例网格文件，记录了海啸抵达时间。其经纬度范围为 $R
    # grdgradient 使用 $R 将地形起伏数据 @earth_relief_05m_g 裁剪到和 @App_O_ttt.nc 相同范围
    # grdimage 使用地形起伏数据对海啸抵达时间数据进行了调制。详细请参考示例《使用地形起伏数据对其他非地形起伏数据进行明暗调制》
    # -nc+t1 选项用于控制网格数据重采样过程中的插值算法。详细请参考 https://docs.gmt-china.org/latest/option/n/
    gmt grdgradient @earth_relief_05m_g $R -Nt1 -A45 -Gtopo5_int.nc
    gmt grdimage @App_O_ttt.nc -Itopo5_int.nc -C $R -JM5.3i -nc+t1
    # 绘制等值线并在指定位置进行标注
    gmt grdcontour @App_O_ttt.nc -C0.5 -A1+u" hour"+v+f8p,Bookman-Demi \
        -GL80W/31N/17W/26N,17W/28N/17W/50N -S2
    # 绘制纽约到 Canary Islands 的测线
    gmt plot -Wfatter,white great_NY_Canaries.txt
    # 绘制海岸线，填充陆地颜色，添加标题
    gmt coast -B20f5 -BWSne+t"Tsunami travel times from the Canaries" -N1/thick \
        -Glightgray -Wfaint -A500
    # convert -E 提取数据的第一条和最后一条数据记录，在这里即为提取纽约、巴黎、Canary Islands 的经纬度并绘制五角星
    gmt convert great_NY_*.txt -E | gmt plot $R -Sa0.15i -Gred -Wthin
    # 使用 plot -Sq 绘制 Canary Islands 到纽约到测线，测线上添加一段固定的字符串显示两地间的距离
    gmt plot -Wthick great_NY_Canaries.txt \
        -Sqn1:+f8p,Times-Italic+l"Distance Canaries to New York = $km km"+ap+v
    # 绘制巴黎到纽约到测线
    gmt plot great_NY_Paris.txt -Sc0.08c -Gblack
    # 使用 plot -Sq 在测线上每隔 1000km 绘制一个标注，显示距离。
    gmt plot -Wthinner great_NY_Paris.txt -SqD1000k:+an+o+gblue+LDk+f7p,Helvetica-Bold,white
    # 添加文字
cat << EOF | gmt text -Gwhite -Wthin -Dj0.1i -F+f8p,Bookman-Demi+j
74W	41N	RT	New York
2.33E	48.87N	CT	Paris
17W	28N	CT	Canaries
EOF
gmt end show
