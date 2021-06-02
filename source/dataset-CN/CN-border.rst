CN-border: 中国行政区划数据
============================

由于 GMT 自带的国界线数据不符合中国领土主张，因而绘制正式图件时，用户需要自己准备国界数据。
中文社区提供一套数字化的国界数据：

- 中国国界、省界、十段线以及南海诸岛数据: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/CN-border-La.gmt
- 中国国界、十段线以及南海诸岛数据，不含省界数据: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/CN-border-L1.gmt
- 仅包含十段线数据: https://raw.githubusercontent.com/gmt-china/china-geospatial-data/master/ten-dash-line.gmt

.. note::

   社区无法保证数据完全准确或可通过地图审核，欢迎用户共享更准确的国界数据。

图例
------

-JD 等距圆锥投影：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JD png
        gmt set FONT_ANNOT_PRIMARY 9p FORMAT_GEO_MAP ddd:mm:ssF
        gmt set MAP_FRAME_WIDTH 2p MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2:1
        gmt set FONT_LABEL 8p MAP_LABEL_OFFSET 4p
        gmt coast -JD105/35/36/42/7.5i -R70/140/3/60 -G244/243/239 -S167/194/223 -B10f5g10 -Lg85/11+c11+w900k+f+u
        gmt plot CN-border-La.gmt -W0.5p
    gmt end
    
-JM 墨卡托投影：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JM png
        gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2:1
        gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_FRAME_WIDTH 3p
        gmt set FONT_ANNOT_PRIMARY 7p
        gmt set FONT_LABEL 8p MAP_LABEL_OFFSET 4p
        # 绘制中国地图
        gmt coast -JM105/35/6.5i -R70/138/13/56 -G244/243/239 -S167/194/223 -B10f5g10 -Lg85/17.5+c17.5+w800k+f+u
        gmt plot CN-border-La.gmt -W0.5p 

        # 绘制南海区域
        gmt basemap -JM1.1i -R105/123/3/24 -B0 -X5.4i --MAP_FRAME_TYPE=plain --MAP_FRAME_PEN=1p
        gmt coast -N1/0.1p -W1/0.25p -G244/243/239 -S167/194/223
        gmt plot CN-border-La.gmt -W0.25p
    gmt end
    
数据来源
---------

- 1:100万全国基础地理数据库: https://www.webmap.cn/commres.do?method=result100W
