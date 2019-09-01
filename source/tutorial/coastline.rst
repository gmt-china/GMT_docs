绘制海岸线
==========

GMT中使用 :doc:`/module/coast` 模块绘制海岸线。
**coast** 模块，顾名思义是海岸线、湖岸线的意思。
该模块不仅可以绘制这些岸线，还可以绘制比例尺和行政边界等。

这一节我们将通过绘制一张美国地图来介绍 **coast** 模块的基本用法。

绘制海岸线和湖岸线
------------------

下面的脚本用最简单的命令绘制了一张美国地图。其中
**-R** 选项设置了绘图区域，\ **-JM15c** 设置投影方式和图片尺寸，
**-Baf** 设置底图边框属性，这些在前一节都已经做了介绍。

**coast** 模块的选项 **-W0.5p,black** 表示绘制岸线，并设置岸线为
0.5p宽的黑色线条。

.. gmtplot::
    :width: 80%
    :caption: 美国海岸线

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -W0.5p,black
    gmt end

上图看上去有些复杂。这是因为默认情况下 **-W** 选项会绘制所有水体与陆地的界限，
包括海岸线、湖岸线、湖中岛的边界等。
根据水体或陆地的不同，\ **coast**\ 模块将岸线分为从1到4的四个级别，
依次指海岸线、湖岸线、湖中岛，以及湖中岛内的湖边界。

因而，我们可以在使用 **-W** 选项时指定要绘制哪一个等级的岸线。下面的脚本中，
我们使用 **-W1/0.5p,black** 表示用 0.5p 宽的黑色线条绘制1级海岸线。

.. gmtplot::
    :width: 80%
    :caption: 绘制海岸线

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black
    gmt end

也可以在一个命令中多次使用 **-W** 选项，分别用不同的线条绘制不同等级的岸线。
这里我们使用 **-W1/0.5p,black** 绘制0.5p黑色的海岸线，同时使用 **-W2/1p,lightred**
绘制1p宽的浅红色湖岸线。

.. gmtplot::
    :width: 80%
    :caption: 绘制海岸线和湖岸线

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black -W2/1p,lightred
    gmt end

设置要绘制的对象的最小面积
--------------------------

上图看上去依然有些乱。主要是因为美国有大大小小的很多岛屿和湖泊，GMT默认会把这些
岛屿和湖泊都画出来。如果能够只绘制比较大的岛屿或湖泊就好了，
我们可以通过 **-A** 选项设置要绘制的对象的最小面积（单位为平方千米）。

.. gmtplot::
    :width: 80%
    :caption: 设置要绘制的对象的最小面积

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -W1/0.5p,black -W2/1p,lightred -A5000
    gmt end

这里我们使用 **-A5000** 表示只绘制面积大于5000平方千米的湖泊或岛屿。这样子
得到的图看上去更加干净简洁了。

填充陆地与水体
--------------

上面介绍了如何使用 **-W** 绘制海岸线和湖岸线。我们还可以不绘制岸线，而是为
陆地和水体设置不同的填充色。

.. gmtplot::
    :width: 100%
    :caption: 填充颜色

    gmt begin coastline png,pdf
    gmt coast -R-130/-50/20/60 -JM15c -Baf -A5000 -Gred -Slightblue -Clightred
    gmt end

其中，\ **-G** 设置了陆地区域的填充色，\ **-S** 设置水体的颜色，
**-C** 则设置湖泊的颜色（若不指定 **-C**\ ，则湖泊颜色由 **-S** 控制）。

当然，你也可以同时使用 **-W** 选项和 **-G** 选项，即绘制岸线并填充颜色。

绘制边界
--------

使用 ``-N`` 选项可以绘制边界。
``-N1`` 绘制边界线。 ``-N2`` 绘制制澳大利亚和美洲国家所属的州、省界线。
此处界线不作国家划界依据（The boundary here is not used as the basis for the delimitation of the national territory.）。

.. gmtplot::
    :width: 100%
    :caption: 绘制国界

    gmt begin coastline_4 pdf,png
    gmt basemap -JM15c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue -W2/1p,black -A2000 -Clightblue -Gdarkgreen -Scornflowerblue -N1/2p,red -N2/1p,black
    gmt end

比例尺
------

最后我们为图画加上比例尺。 ``-Lg-65/25+c-65+w500k+f+u`` 的含义是比例尺的中点的经纬度为-65和25，比例尺的长度为500公里。
绘制的是比例尺为经度-65度的。 ``+f`` 表示风格为黑白相间的铁轨。``+u`` 表示要显示单位。

.. gmtplot::
    :width: 100%
    :caption: 加上比例尺

    gmt begin coastline_4 pdf,png
    gmt basemap -JM15c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue -W2/1p,black -A2000 -Clightblue -Gdarkgreen -Scornflowerblue -N1/2p,red -N2/1p,black -Lg-65/25+c-65+w500k+f+u
    gmt end
