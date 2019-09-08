绘制地形起伏
============

GMT中使用 :doc:`gridimage` 模块绘制地形。

earth_relief 全球地形起伏数据
--------------------------------
该数据并非 GMT 官方采集，而是 GMT 官方收集，以方便用户使用。
该数据有不同精度和覆盖范围的版本。

绘制全球地形
-------------

.. gmtplot::
    :width: 100%
    :caption: 全球地形

    gmt begin earth_relief_1 pdf,png
    gmt grdimage -JH10c @earth_relief_15m
    gmt end

上图中，使用gridimage模块绘制地形数据。使用的数据是@earth_relief_15m。
数据名称中的@表示是GMT官方提供的数据，如果你之前从来没有用过，gmt会下载，今后再使用就不再下载了。
15m表示精度为15弧分。

加上光照效果
--------------

我们首先绘制一副中国新疆的一个局部：

.. gmtplot::
    :width: 80%
    :caption: 新疆局部

    gmt begin earth_relief_2 pdf,png
    gmt grdimage -JM15c -R85/90/42/44 -Baf -BWSEN earth_relief_15s.grd
    echo '87.611671 43.875513' | gmt plot -Sa0.5c -W1p,red
    gmt end

图中的红色五角星为坐落在天山脚下的自治区首府乌鲁木齐。下面我们为图幅加上光照效果，明显增加立体感：

.. gmtplot::
    :width: 80%
    :caption: 带光照效果的新疆局部

    R=85/90/42/44                                               # 确定图幅范围

    gmt grdcut earth_relief_15s.grd -R$R -Gcut_data             # 对数据切割，减少计算机的运行负担
    gmt begin earth_relief_3 pdf,png
    gmt grdimage -JM15c -R$R -Baf -BWSEN cut_data -I+d  # 用-I选项指定光照文件
    echo '87.611671 43.875513' | gmt plot -Sa0.5c -W1p,red      # 标出乌鲁木齐
    gmt end
    rm cut_data

选用不同的色标
------------------

在刚才画的图的东南部分似乎有一个很大的湖。这其实是吐鲁番，并不是湖。
本质上，gridimage模块绘制地形，是在读取某个位置的高程数值后，绘制该数值对应的颜色。
高程数值和颜色的对应关系是由色标确定的。gmt并不知道自己绘制的是高程。
通常，地球上海平面以下就是海洋，gmt默认的色标便把负数的高程和蓝色对应以便符合人的经验。
因为吐鲁番的海拔高度在海平面以下，所以看着像海洋或者湖。
这个时候，我们就需要自己指定色标。

首先，我们通过-C选项指定一个gmt的默认色标。

.. gmtplot::
    :width: 80%
    :caption: 指定色标的新疆局部

    R=85/90/42/44                                               # 确定图幅范围

    gmt grdcut earth_relief_15s.grd -R$R -Gcut_data             # 对数据切割，减少计算机的运行负担
    gmt begin earth_relief_4 pdf,png
    gmt basemap -JM15c -R$R -Baf -BWSEN 
    gmt grdimage -Cglobe -I+d cut_data                  # 用-I选项指定光照文件，用-C指定色标
    echo '87.611671 43.875513' | gmt plot -Sa0.5c -W1p,red      # 标出乌鲁木齐
    gmt end
    rm cut_data

似乎效果还不如默认的。这时候我们可以自己设计色标。
gmt中色标存储为一个CPT格式的文本文件，通常以cpt结尾。你也可以用其他后缀名，或者不用后缀名，这都不会改变其本质。
色标文件中颜色由三个变量给定。中间中的每一行对应一个高程范围。一行的第一列和第五列为高程的最小值和最大值。
第二三四列为最小高程对应的颜色，第六七八为最大高程的颜色。

.. gmtplot::
    :width: 80%
    :caption: 自制色标的新疆局部

    R=85/90/42/44                                               # 确定图幅范围
    CPT=turpan.cpt                                              # 色标文件的文件名
    #输出色标文件
    cat << EOF > $CPT
    -500  148 171 132  100   148 171 132
    100   172 191 139  200   172 191 139
    200   189 204 150  500   189 204 150
    500   228 223 175  1000  228 223 175
    1000  230 202 148  2000  230 202 148
    2000  205 171 131  3000  205 171 131
    3000  181 152 128  4000  181 152 128
    4000  206 206 206  6000  255 255 255
    EOF

    gmt grdcut earth_relief_15s.grd -R$R -Gcut_data             # 对数据切割，减少计算机的运行负担
    gmt begin earth_relief_5 pdf,png
    gmt basemap -JM15c -R$R -Baf -BWSEN 
    gmt grdimage -C$CPT -I+d cut_data                  # 用-I选项指定光照文件，用-C指定色标
    echo '87.611671 43.875513' | gmt plot -Sa0.5c -W1p,red      # 标出乌鲁木齐
    gmt end
    rm cut_data

加上显示高程的色标卡
-----------------------

地形图中不同颜色代表高程的数值，所以需要一个色标卡表明颜色对应的高程。

.. gmtplot::
    :width: 80%
    :caption: 加色标卡的新疆局部

    R=85/90/42/44                                               # 确定图幅范围
    CPT=turpan.cpt                                              # 色标文件的文件名
    #输出色标文件
    cat << EOF > $CPT
    -500  148 171 132  100   148 171 132
    100   172 191 139  200   172 191 139
    200   189 204 150  500   189 204 150
    500   228 223 175  1000  228 223 175
    1000  230 202 148  2000  230 202 148
    2000  205 171 131  3000  205 171 131
    3000  181 152 128  4000  181 152 128
    4000  206 206 206  6000  255 255 255
    EOF

    gmt grdcut earth_relief_15s.grd -R$R -Gcut_data             # 对数据切割，减少计算机的运行负担
    gmt begin earth_relief_6 pdf,png
    gmt basemap -JM15c -R$R -Baf -BWSEN 
    gmt grdimage -C$CPT -I+d cut_data                   # 用-I选项指定光照文件，用-C指定色标
    echo '87.611671 43.875513' | gmt plot -Sa0.5c -W1p,red      # 标出乌鲁木齐
    gmt colorbar -DjCB+w18c/0.3c+o0/-2.5c+h -C$CPT -BWSEN -Bxa500f100+l"Elevation/m" -G-500/6000 #绘制色标卡
    gmt end
    rm cut_data