#!/usr/bin/env bash
gmt begin ex009
        # 从GMT远程服务器下载示例地震目录文件
        gmt which -Gl @quakes_07.txt

        gmt basemap -JM10c -R308/352/-12/24 -Baf
        gmt grdimage @earth_relief_10m_p -Cgeo
        gmt colorbar -Bxaf -C
        # 示例文件三列分别为经度、纬度、震级。
        # 根据震级绘制不同大小的圆点。用户可以根据自己数据震级的最大最小值，调整圆点直径的计算参数
        gawk '{print $1, $2, 0.2*($3-4.0)}' quakes_07.txt | gmt plot -Scc -Gred -W0.1

        # 统计不同震级
        c4=$(gawk '4<=$3 && $3<5 {count++}END{print count}' quakes_07.txt | tr -d '\n\r')
        c5=$(gawk '5<=$3 && $3<6 {count++}END{print count}' quakes_07.txt | tr -d '\n\r')
        c6=$(gawk '6<=$3 && $3<7 {count++}END{print count}' quakes_07.txt | tr -d '\n\r')

        # 输出统计结果
        gmt basemap -JX5c/-5c -R0/10/0/10 -Y4c -X10.5c -Brt
        #
        echo 1 2 | gmt plot -Sc0.2c -Gred -W0.1p
        echo 2 2 '4<=mag<5:' ${c4} | gmt text -F+f14p+jML

        echo 1 4 | gmt plot -Sc0.4c -Gred -W0.1p
        echo 2 4 '5<=mag<6:' ${c5} | gmt text -F+f14p+jML

        echo 1 6 | gmt plot -Sc0.6c -Gred -W0.1p
        echo 2 6 '6<=mag<7:' ${c6} | gmt text -F+f14p+jML
gmt end show
