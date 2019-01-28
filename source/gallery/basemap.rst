绘制底图
========

这一节将使用GMT的 ``psbasemap`` 和 ``pscoast`` 模块绘制简单的坐标轴以及世界地图。

线性投影
---------

GMT可以绘制最简单的线性X-Y图。

.. gmt-plot::
   :language: bash
   :caption: 线性X-Y图

    gmt psbasemap -R10/70/-3/8 -JX8c/5c -Bx10 -By3 -B+t"Linear X-Y Plot" > GMT_tutor1_1.ps

在这个示例中：

- ``-R10/70/-3/8`` 设置了X轴范围是10到70，Y轴范围为-3到8
- ``-JX8c/5c`` 指定了整张图为线性投影，图的宽度（X轴长度）为8厘米，图的高度（Y轴长度）为5厘米
- ``-Bx10 -By3`` 分别设置了X、Y轴标注以及刻度的间隔为10和3
- ``-B+t"Linear X-Y Plot"`` 为整张图添加了标题
- ``> GMT_tutor1_1.ps`` GMT绘图模块的输出是PS代码，因而需要使用重定向符号 ``>`` 将PS代码输出到PS文件中

你可以尝试如下操作以增进对各个选项的理解：

#. 修改 ``-JX`` 中的值
#. 修改 ``-Bx`` 和 ``-By`` 中的值
#. 修改 ``-R`` 中的值
#. 增进 ``-P`` 选项并查看效果

对数投影
--------

下面展示如何用GMT绘制对数X-Y图。

.. gmt-plot::
    :language: bash
    :caption: 对数X-Y图

    gmt psbasemap -R1/10000/1e20/1e25 -JX15cl/10cl -Bxa2+l"Wavelength (m)" \
        -Bya1pf3+l"Power (W)" -BWS > GMT_tutor1_2.ps

此示例中：

- ``-R1/10000/1e20/1e25`` 设置了X和Y轴的范围
- ``-JX15cl/10cl`` 中 ``l`` 表明用对数轴表示
- ``-B`` 选项中 ``+l`` 用于指定每个轴的轴标签
- ``-BWS`` 表示只绘制图边框左（W）和下（S）边框

试试看：

#. 将 ``-Bya1pf3`` 改成 ``-Bya1f3``
#. 将 ``-BWS`` 改成 ``-BWSen`` 、 ``-BWSEN`` 、 ``-BwsEN`` 等

区域地图
---------

GMT自带了海岸线数据，通过 ``pscoast`` 模块可以直接调用。

.. gmt-plot::
    :language: bash
    :caption: 区域地图

    gmt pscoast -R-90/-70/0/20 -JM6i -P -Ba -Gchocolate > GMT_tutor1_3.ps

此示例中使用 ``pscoast`` 绘制了拉丁美洲区域的海岸线。

- ``-R-90/-70/0/20`` 指定了地理区域的范围
- ``-JM6i`` 表示使用墨卡托投影，地图的宽度为6英寸，高度由投影自动决定
- ``-Ba`` 会根据地理范围以及图片大小自动计算出适合的标注和刻度间隔
- ``-Gchocolate`` 将陆地区域填充颜色chocolate

``pscoast`` 还有很多常用的选项：

#. ``-D`` 选项海岸线数据的精度
#. ``-G`` 设置陆地区域的填充色
#. ``-S`` 设置海洋、湖泊区域的填充色
#. ``-W`` 绘制海岸线，并设置海岸线的画笔属性
#. ``-N`` 绘制政治边界
#. ``-I`` 绘制河流
#. ``-L`` 在图上绘制比例尺

试试看：

#. 加上 ``-V`` 选项
#. 修改 ``-R`` 选择中的地理范围
#. 加上 ``-W1p`` 选项
#. 加上 ``-N1/thickest -N2/thinnest`` 选项

全球地图
---------

.. gmt-plot::
    :language: bash
    :caption: 全球地图

    gmt pscoast -Rg -JK180/9i -Bag -Dc -A5000 -Gchocolate -SDarkTurquoise \
        -Wthinnest > GMT_tutor1_4.ps

此示例中：

#. ``-JK180/9i`` 表明使用Eckert投影，地图中心位于经度180度，地图宽度为9英寸
