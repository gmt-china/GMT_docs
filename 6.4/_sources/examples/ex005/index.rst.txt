:orphan:

双 Y 轴图
====================

:示例贡献者: 陈箫翰

----

GMT 自身并没有绘制双 Y 轴图的功能，读者可以在相同位置绘制两个不同坐标系的图层，叠加在一起成为双 Y 轴图。示例如下：

.. gmtplot::
    :caption: 双 Y 轴图
    :width: 100%
    
    gmt begin ex005
        # 用 gmt math 命令生成示例数据供接下来使用
        gmt math -T0/30/0.1 T SIN = sin.txt
        gmt math -T0/30/0.1 T SQR = sqr.txt
        
        # 首先绘制 Sin 函数图层
        # 设置坐标轴边框颜色、标注字体、刻度线、标签字体为蓝色
        gmt set MAP_FRAME_PEN blue MAP_TICK_PEN_PRIMARY blue
        gmt set FONT_ANNOT_PRIMARY blue FONT_LABEL blue
        # 设置x轴，y轴自动间隔，只绘制下边框(S)和左边框(W)
        gmt basemap -R0/30/-1.5/1.5 -JX10c/5c -Bxaf -Byaf+lSin -BWS
        gmt plot sin.txt -W1p,blue
        
        # 然后绘制 sqr 函数图层，直接在相同位置叠加
        # 设置坐标轴边框颜色、标注字体、刻度线、标签字体为红色
        gmt set MAP_FRAME_PEN red FONT_ANNOT_PRIMARY red
        gmt set MAP_TICK_PEN_PRIMARY red FONT_LABEL red
        # -R选项中改变y轴的范围
        # x轴设置相同，y轴标注间隔100，只绘制右边框(E)
        gmt basemap -R0/30/0/1000 -JX10c/5c -Bxaf -Bya200+lSqr -BE
        gmt plot sqr.txt -W1p,red
        
        rm sin.txt sqr.txt
    gmt end show