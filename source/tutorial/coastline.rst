绘制海岸线
==========

绘制海岸线使用coast模块。
coast顾名思义是海岸线、湖岸线的意思，该模块不仅可以绘制这些岸线，还可以绘制比例尺和行政边界等。
一个模块具有多种不太相关的功能是GMT的feature。

绘制海岸线和湖岸线
------------------

.. gmtplot::
    :width: 100%
    :caption: 美加五大湖中的休伦湖、伊利湖和安大略湖附近的（海、湖）岸线

    gmt begin coastline_0 pdf,png
    gmt coast -R-85/-65/40/50 -JM25c -Baf -W1p,blue
    gmt end


上图中，coast 模块特别的选项只有 ``-W``，
``-W[<level>]/<pen>`` 选项是对（海、湖、河）岸的线条进行设置。
首先要强调的是 ``<level>`` 不是必须的， ``<pen>`` 是必须。
所谓的 ``<level>`` 指的是岸线的级别。岸线的级别从1到4，依次指海岸线、湖岸线、湖中岛和湖中岛内的湖中岛。
下图用不同的颜色展示了级别的差异。

.. gmtplot::
    :width: 100%
    :caption: 绘制不同级别的（海、湖）岸线

    gmt begin coastline_1 pdf,png
    gmt basemap -JM25c -R-85/-65/40/50 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue   # 海岸线
    gmt coast -W2/1p,black  # 湖岸线
    gmt coast -W3/1p,purple # 湖中岛
    gmt coast -W4/1p,red    # 湖中岛内的湖中岛
    gmt end

设置要绘制的对象的最小面积
--------------------------

现在，我们想突出三大湖，不让过小的对象出现在图画上。这时候可以用 ``-A`` 选项设置要绘制的对象的最小面积（单位为平方公里）。

.. gmtplot::
    :width: 100%
    :caption: 设置要绘制的对象的最小面积

    gmt begin coastline_2 pdf,png
    gmt basemap -JM25c -R-85/-65/40/50 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue           # 海岸线
    gmt coast -A10000 -W2/1p,black  # 湖岸线
    gmt coast -A1000 -W3/1p,purple  # 湖中岛
    gmt coast -W4/1p,red            # 湖中岛内的湖中岛
    gmt end

填充颜色
--------
上面的图都是在画线：海岸线和湖岸线。现在，我们不画线，而是用颜色来表示水体和陆地。

.. gmtplot::
    :width: 100%
    :caption: 填充颜色

    gmt begin coastline_3 pdf,png
    gmt basemap -JM25c -R-85/-65/40/50 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue
    gmt end

``-C`` 指定的是湖泊和河流的颜色， ``-G`` 是陆地的颜色。 ``-S`` 是海洋的颜色。
同时，你可以体会到GMT对于颜色支持的丰富性。

绘制国界
--------

美国和加拿大是世界上最长的互不设防国界。使用 ``-N`` 选项可以绘制国界。
``-N1`` 绘制美国、加拿大、澳大利亚和南美国家的国界线。 ``-N2`` 绘制美国和加拿大的州、省边界。

.. gmtplot::
    :width: 100%
    :caption: 绘制国界

    gmt begin coastline_4 pdf,png
    gmt basemap -JM25c -R-85/-65/40/50 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue
    gmt coast -N1/2p,red
    gmt coast -N2/1p,black
    gmt end

比例尺
------

最后我们为图画加上比例尺。 ``-Lg-70/41+c-70+w100k+f`` 的含义是比例尺的中点的经纬度为-70和41，比例尺的长度为100公里。
绘制的是比例尺为经度-70度的。 ``+f`` 表示风格为黑白相间的铁轨。

.. gmtplot::
    :width: 100%
    :caption: 加上比例尺

    gmt begin coastline_4 pdf,png
    gmt basemap -JM25c -R-85/-65/40/50 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue -Lg-70/41+c-70+w100k+f
    gmt end
