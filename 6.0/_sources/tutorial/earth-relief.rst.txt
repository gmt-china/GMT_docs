绘制地形起伏
============

绘制地图时另一个常见的需求是绘制全球或者区域的地形起伏作为底图。

GMT中 :doc:`/module/grdimage` 模块可以绘制二维网格，其原理是建立Z值与颜色之间的映射关系，
每个坐标点不同的Z值用不同的颜色表征。
地形起伏，即不同经纬度处的高程或海深数据，也是一种二维数据，因而我们可以使用
**grdimage** 模块绘制地形起伏。

全球地形起伏数据
----------------

要绘制全球或区域地形起伏图，首先需要拥有地形起伏数据，即不同经纬度处的高程或海深数据。
GMT收集整理并提供了一套全球地形起伏数据，供用户直接使用。
这套地形起伏数据分为包含了从60弧分到1弧秒的多种不同精度的全球地形起伏数据，
以满足不同的绘图区域大小的需求。

GMT用户可以通过给定文件名 :file:`@earth_relief_xxx` 的方式来指定要使用某个精度的
地形。\ *xxx* 用于指定数据精度，例如 **15m**\ 、\ **01m**\ 和 \ **15s** 分别表示
数据分辨率为15弧分、1弧分和15弧秒。

文件名前的 **@** 表示该数据是由GMT官方提供并维护的数据，当第一次使用该文件时，
GMT会自动从服务器下载该数据并保存到本地的GMT数据目录中，当以后再使用该文件时，
则直接读取本地文件，而无需重新下载该数据。

关于全球地形起伏数据的详细介绍见 :doc:`/dataset/earth-relief`\ 。

绘制全球地形起伏图
------------------

下面我们将使用 **grdimage** 模块绘制5弧分精度的全球地形起伏数据（\ :file:`@earth_relief_05m`\ ）。
不同的高程用不同的颜色表示，从中我们很容易看出不同地区的地形变化。

.. gmtplot::
    :width: 100%
    :caption: 全球地形起伏图

    gmt begin global_relief png,pdf
    gmt grdimage @earth_relief_05m -JH180/10c
    gmt end show

绘图区域地形起伏图
------------------

想要绘制区域地形起伏？只需要在 **grdimage** 模块中使用 **-R** 选项指定
区域经纬度范围即可。这里我们设置了绘图区域为118°E至125°E、20°N至26°N。
由于绘图区域比较小，所以我们选用了更高精度的 30 弧秒的地形起伏数据。

.. note::

    30弧秒的地形起伏数据大小约为800Mb。
    第一次使用该数据时GMT会自动从服务器下载该文件，因而会很耗时，请耐心等待。

.. gmtplot::
    :width: 70%
    :caption: 台湾区域地形图

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen
    gmt end show

增加光照效果
------------

为了让地形起伏图更加立体，我们可以为图幅加上光照效果。我们可以指定光照的方向、
强度等参数，也可以直接使用 **-I+d** 以使用默认的光照效果。

下面的示例中，我们加上了 **-I+d** 以增加光照效果。跟上图比一比，是否图片更加立体
也更加美观了呢？

.. gmtplot::
    :width: 70%
    :caption: 带光照效果的台湾区域地形图

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen -I+d
    gmt end show

增加光照效果本质上是计算了每个点沿着某个方位角的方向梯度，然后根据每个点的
方向梯度的正负以及振幅调节该点颜色的亮度值。对于向阳处，其方向梯度为正值，则增加
该点颜色的亮度；对于背阴处，其方向梯度为负值，则降低该点颜色的亮度。由此达到
增加光照效果、增强立体感的目的。

添加色标
--------

前面提到，\ **grdimage** 绘制地形起伏数据本质上就是将高程的数值与颜色之间对应起来。
二者之间的对应关系由色标文件（即CPT文件）决定。那么，上图使用的是怎么样的CPT呢？
高程数值与颜色之间的对应关系又是怎样的呢？不同的颜色代表的具体数值又是多少呢？
这就需要用 :doc:`/module/colorbar` 向图中添加色标。

.. gmtplot::
    :width: 70%

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen -I+d
    gmt colorbar
    gmt end show

上面的脚本中 **colorbar** 命令在地形图的下方添加了一个色标，但是色标下面的有一团
很乱的标注，这显示不是我们想要的。我们可以使用 **-B** 选项设置色标的标注间隔，
并为色标添加一个标签。

.. gmtplot::
    :width: 70%

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen -I+d
    gmt colorbar -Bxaf+l"Elevation (m)"
    gmt end show

当然，我们还可以更进一步调整色标的位置、长度等属性。下面的脚本中，我们使用了
**-D** 选项将色标放在了地形起伏图的右侧中间（\ **JMR**\ ）向右偏移1.5厘米，
色标长度为10厘米，并将标签放在了色标左侧（\ **+ml**\ ）。

.. gmtplot::
    :width: 70%

    gmt begin taiwan_relief png,pdf
    gmt grdimage @earth_relief_30s -JM15c -R118/125/20/26 -Baf -BWSen -I+d
    gmt colorbar -DJMR+w10c+o1.5c/0c+ml -Bxa1000f -By+l"m"
    gmt end show

制作CPT文件
-----------

上面的示例中使用的是GMT的默认CPT文件。用户也可以使用 :doc:`/module/makecpt` 或
:doc:`gmt:grd2cpt` 制作CPT文件。

下面的示例中，我们使用 :doc:`/module/makecpt` 模块在GMT内置CPT **globe** 的基础
上生成了一个-8000到8000范围内的新CPT文件。生成的CPT文件将作为当前CPT文件，供
接下来的 **grdimage** 和 **colorbar** 命令使用。

.. gmtplot::
    :width: 70%

    gmt begin taiwan_relief png,pdf
    gmt basemap -JM15c -R118/125/20/26 -Baf -BWSen
    gmt makecpt -Cglobe -T-8000/8000
    gmt grdimage @earth_relief_30s -I+d
    gmt colorbar -Bxa2000 -B+l"m"
    gmt end show
