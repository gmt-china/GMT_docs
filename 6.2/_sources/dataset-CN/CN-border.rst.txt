CN-border: 中国国界省界数据
===========================

:贡献者: |刘珠妹|, |田冬冬|, |陈箫翰|

----

GMT 自带的国界线数据不符合中国领土主张。例如，阿克赛钦地区、藏南地区边界均存在明显差异，
其他地方也存在微小差异。在正式出版的中外期刊上发表带有中国国界的地图时需要格外注意。
2017 年国家测绘地理信息局发布的
《`“问题地图”清查工作指南 <https://www.nwafu.edu.cn/docs/2017-09/20170907152504884294.pdf>`__》
中列出了绘图中应避免的若干错误。下面列出了绘制中国全图时的常见注意事项：

- 阿克赛钦地区正确表示
- 藏南地区正确表示
- 钓鱼岛、赤尾屿位置正确
- 南海诸岛各岛点位置正确
- 台湾省底色设置与大陆一致

为了避免绘制错误国界带来的一系列问题，最简单的方法就是只绘制海岸线不绘制国界。
若必须绘制国界，用户需要自己准备符合要求的国界数据。
CN-border 是 GMT 中文社区为用户提供的一套基本准确的数字化的国界、省界数据。
即便正确绘制了国界、省界，所绘地图如果要在境内公开展示，依然需要审图。
个人没有提交审图申请的资格，需要付费，委托给有资质的企事业单位代为提交审图申请。

.. admonition:: 免责声明

   本数据仅供科研用途使用。GMT 中文社区不保证数据完全准确或可通过地图审核。
   欢迎用户共享更准确的国界数据。

数据文件
--------

CN-border 数据提供了三个数据文件：

- :file:`CN-border-La.gmt`：中国国界、省界、十段线以及南海诸岛数据
- :file:`CN-border-L1.gmt`：中国国界、十段线以及南海诸岛数据，不含省界数据
- :file:`ten-dash-line.gmt`：仅十段线数据

具体的下载地址和使用方式请见：:doc:`/dataset-CN/index`。

示例图
------

使用等距圆锥投影（**-JD**）绘制中国国界省界数据：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JD pdf,png
        gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
        gmt coast -JD105/35/36/42/10c -R70/140/3/60 -G244/243/239 -S167/194/223 -Ba10f5g10 -Lg85/11+c11+w900k+f+u
        gmt plot CN-border-La.gmt -W0.1p
    gmt end show

使用墨卡托投影（**-JM**）绘制中国国界省界数据：

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt begin CN-border-JM pdf,png
        gmt set MAP_GRID_PEN_PRIMARY 0.25p,gray,2_2
        # 绘制中国地图
        gmt coast -JM105/35/10c -R70/138/13/56 -Ba10f5g10 -G244/243/239 -S167/194/223
        gmt basemap -Lg85/17.5+c17.5+w800k+f+u --FONT_ANNOT_PRIMARY=4p
        gmt plot CN-border-La.gmt -W0.1p

        # 绘制南海区域
        gmt inset begin -DjRB+w1.8c/2.2c -F+p0.5p
            gmt coast -JM? -R105/123/3/24 -G244/243/239 -S167/194/223 -Df
            gmt plot CN-border-La.gmt -W0.1p
        gmt inset end
    gmt end show

数据来源与处理
--------------

CN-border 原始数据来自于 `1:100 万全国基础地理数据库 <https://www.webmap.cn/commres.do?method=result100W>`_，
并由\ `刘珠妹 <https://github.com/liuzhumei>`__ 处理得到 GMT 可使用的数据。
**具体数据处理方式待补充**。

数据引用
--------

CN-border 原始数据来自于\ `全国地理信息资源目录服务系统 <https://www.webmap.cn>`__，
其\ `版权声明 <https://www.webmap.cn/main.do?method=otherService&clickFlag=copyright>`__\ 中要求：

    转载或引用本网站所有之内容须注明“转自（或引自）全国地理信息资源目录服务系统”字样，并标明本网网址 www.webmap.cn。
