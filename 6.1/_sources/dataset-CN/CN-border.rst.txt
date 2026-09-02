CN-border: 中国国界省界数据
============================

GMT 自带的国界线数据不符合中国领土主张。例如，阿克赛钦地区、藏南地区边界均存在明显差异，
其他地方也存在微小差异。在正式出版的中外期刊上发表带有中国国界的地图时需要格外注意。
最简单的方法就是只绘制海岸线不绘制国界，以避免任何国界带来的可能争议。否则，用户需要
自己准备国界数据。

2017年国家测绘地理信息局发布的《“问题地图”清查工作指南》中列出了绘图中应避免的若干错误。
下面列出了绘制中国全图时的常见注意事项：

 - 阿克赛钦地区正确表示
 - 藏南地区正确表示
 - 钓鱼岛、赤尾屿位置正确
 - 南海诸岛各岛点位置正确
 - 台湾省底色设置与大陆一致

中文社区提供一套数字化的国界数据，数据包含三个文件:

-  :file:`CN-border-La.gmt`\ ：中国国界、省界、十段线以及南海诸岛数据
-  :file:`CN-border-L1.gmt`\ ：中国国界、十段线以及南海诸岛数据，不含省界数据
-  :file:`ten-dash-line.gmt`\ ：仅十段线数据

具体的下载地址和使用方式请见: :doc:`/dataset-CN/index`\ 。

.. admonition:: 免责声明

   本数据仅供科研用途使用。社区不保证数据完全准确或可通过地图审核。
   欢迎用户共享更准确的国界数据。

中国国界省界示例图
------------------

**-JD** 等距圆锥投影：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JD pdf,png
        gmt set FONT_ANNOT_PRIMARY 9p FORMAT_GEO_MAP ddd:mm:ssF
        gmt set MAP_FRAME_WIDTH 2p MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2:1
        gmt coast -JD105/35/36/42/10c -R70/140/3/60 -G244/243/239 -S167/194/223 -B10f5g10 -BnSWe -Lg85/11+c11+w900k+f+u
        gmt plot CN-border-La.gmt -W0.1p
    gmt end show

**-JM** 墨卡托投影：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JM pdf,png
        gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2:1
        gmt set FORMAT_GEO_MAP ddd:mm:ssF MAP_FRAME_WIDTH 3p
        # 绘制中国地图
        gmt basemap -JM105/35/10c -R70/138/13/56 -B10f5 -BnSWe --FONT_ANNOT_PRIMARY=7p
        gmt coast -G244/243/239 -S167/194/223 -Lg85/17.5+c17.5+w800k+f+u --FONT_ANNOT_PRIMARY=4p
        gmt plot CN-border-La.gmt -W0.1p

        # 绘制南海区域
        gmt inset begin -DjRB+w1.8c/2.2c -F+p0.5p
            gmt coast -JM? -R105/123/3/24 -G244/243/239 -S167/194/223 -Df
            gmt plot CN-border-La.gmt -W0.1p
        gmt inset end
    gmt end show

数据来源
---------

- 1:100万全国基础地理数据库: https://www.webmap.cn/commres.do?method=result100W
