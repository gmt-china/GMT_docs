绘制海岸线
==========

GMT 中使用 :doc:`/module/coast` 模块绘制海岸线。
**coast** 模块，顾名思义是海岸线、湖岸线的意思。
该模块不仅可以绘制这些岸线，还可以绘制比例尺和行政边界等。

这一节我们将通过绘制一张美国地图来介绍 **coast** 模块的基本用法。

绘制海岸线和湖岸线
------------------

下面的脚本用最简单的命令绘制了一张美国地图。其中
**-R** 选项设置了绘图区域，\ **-JM15c** 设置投影方式和图片尺寸，
**-Baf** 设置底图边框属性，这些在前一节都已经做了介绍。

**coast** 模块的选项 **-W0.5p,black** 表示绘制岸线，
并设置岸线为 0.5p 宽的黑色线条。

.. gmtplot::
    :width: 80%
    :caption: 美国海岸线

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -W0.5p,black
    gmt end show

上图看上去有些复杂。这是因为默认情况下 **-W** 选项会绘制所有水体与陆地的界限，
包括海岸线、湖岸线、湖中岛的边界等。
根据水体或陆地的不同，\ **coast**\ 模块将岸线分为从 1 到 4 的四个级别，
依次指海岸线、湖岸线、湖中岛，以及湖中岛内的湖边界。

因而，我们可以在使用 **-W** 选项时指定要绘制哪一个等级的岸线。
下面的脚本中，我们使用 **-W1/0.5p,black** 表示用 0.5p 宽的黑色线条绘制 1 级海岸线。

.. gmtplot::
    :width: 80%
    :caption: 绘制海岸线

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black
    gmt end show

可以在一个命令中多次使用 **-W** 选项，分别用不同的线条绘制不同等级的岸线。
这里我们使用 **-W1/0.5p,black** 绘制 0.5p 黑色的海岸线，
同时使用 **-W2/1p,lightred** 绘制 1p 宽的浅红色湖岸线。

.. gmtplot::
    :width: 80%
    :caption: 绘制海岸线和湖岸线

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black -W2/1p,lightred
    gmt end show

设置要绘制的对象的最小面积
--------------------------

上图看上去依然有些乱。主要是因为美国有大大小小的很多岛屿和湖泊，
GMT 默认会把这些岛屿和湖泊都画出来。如果能够只绘制比较大的岛屿或湖泊就好了，
我们可以通过 **-A** 选项设置要绘制的对象的最小面积（单位为平方千米）。

.. gmtplot::
    :width: 80%
    :caption: 设置要绘制的对象的最小面积

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black -W2/1p,lightred -A5000
    gmt end show

这里我们使用 **-A5000** 表示只绘制面积大于 5000 平方千米的湖泊或岛屿。
这样子得到的图看上去更加干净简洁。

填充陆地与水体
--------------

上面介绍了如何使用 **-W** 绘制海岸线和湖岸线。我们还可以不绘制岸线，
而是为陆地和水体设置不同的填充色。

.. gmtplot::
    :width: 80%
    :caption: 填充颜色

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -A5000 -Gred -Slightblue -Clightred
    gmt end show

其中，\ **-G** 设置了陆地区域的填充色，\ **-S** 设置水体的颜色，
**-C** 则设置湖泊的颜色（若不指定 **-C**\ ，则湖泊颜色由 **-S** 控制）。

当然，你也可以同时使用 **-W** 选项和 **-G** 选项，即绘制岸线并填充颜色。

绘制国界/州界
-------------

使用 **-N** 选项可以绘制国界、州界/省界等行政边界。\ **-N1** 表示绘制国界线，
**-N2** 表示绘制州界/省界线。该选项绘制的行政边界来自 :doc:`/dataset/gshhg`\ ，
目前只有美洲各国以及澳大利亚有州界/省界线。

.. gmtplot::
    :width: 80%
    :caption: 绘制国界与州界

    gmt begin coastline png,pdf
        gmt coast -R-130/-50/20/60 -JM15c -Baf -A5000 -Gred -Slightblue -Clightred -N1/1p -N2/0.25p
    gmt end show

.. note::

    除了 **-N** 选项之外，还有其他方法使用 GMT 绘制洲界、国界、州界/省界等行政区划边界：

    - **-E** 选项可以用于绘制洲界、国界以及省界/州界。详细用法请参考 :doc:`/dataset/dcw/index` 小节。
    - 使用 :doc:`/dataset/gadm/index` 绘制全球所有国家和地区的国界、省界、市界、区界等
      多个级别的行政区划边界
    - 使用 :doc:`/dataset-CN/CN-border` 绘制中国国界和省界等行政区划边界

添加比例尺
----------

最后，我们还需要为地图添加比例尺。为了绘制比例尺，我们需要提供如下参数：

- 要绘制哪个纬度的比例尺
- 比例尺在图中的位置
- 比例尺的长度

在下面的例子中，我们使用了 **-Lg-60/25+c25+w1000k+f+u** 增加比例尺，其中：

- **+w1000k** 表示比例尺长度为 1000 千米
- **+c25** 表示绘制纬度为北纬 25° 处的比例尺
- **g-60/25** 则表示将比例尺画在北纬 25° 西经 60° 处
- **+f** 表示比例尺的风格为图中所示黑白相间的铁轨形式
- **+u** 表示显示比例尺对应的单位

.. gmtplot::
    :width: 80%
    :caption: 添加比例尺

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -A5000 -Gred -Slightblue -Clightred -Lg-60/25+c25+w1000k+f+u
    gmt end show
