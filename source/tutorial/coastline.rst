绘制海岸线
==========

绘制海岸线使用coast模块。
coast顾名思义是海岸线、湖岸线的意思，该模块不仅可以绘制这些岸线，还可以绘制比例尺和行政边界等。
一个模块具有多种不太相关的功能是GMT的feature。

绘制海岸线和湖岸线
------------------

.. gmtplot::
    :width: 100%
    :caption: 美国海岸线

    gmt begin coastline_0 pdf,png
    gmt coast -R-130/-50/20/60 -JM25c -Baf -W1/2p,blue
    gmt end


上图中，coast 模块的选项 -W1/2p,blue 是对（海、湖、河）岸的线条进行设置。
1/2p,blue 的含义是岸线的级别为1，线条为2p宽的蓝色线。
岸线是水体与陆地的界线，根据水体或陆地的不同，分为从1到4的四个级别，依次指海岸线、湖岸线、湖中岛和湖中岛内的湖中岛。
该选项可以使用多次，下图用不同的颜色展示了级别的差异。

.. gmtplot::
    :width: 100%
    :caption: 绘制不同级别的（海、湖）岸线

    gmt begin coastline_1 pdf,png
    gmt basemap -JM25c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue -W2/1p,black -W3/1p,purple -W4/1p,red
    gmt end

设置要绘制的对象的最小面积
--------------------------

用 ``-A`` 选项设置要绘制的对象的最小面积（单位为平方公里）。

.. gmtplot::
    :width: 100%
    :caption: 设置要绘制的对象的最小面积

    gmt begin coastline_2 pdf,png
    gmt basemap -JM25c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -W1/1p,blue -W2/1p,black -W3/1p,purple -W4/1p,red -A2000
    gmt end

填充颜色
--------
上面的图都是在画线：海岸线和湖岸线。现在，我们不画线，而是用颜色来表示水体和陆地。

.. gmtplot::
    :width: 100%
    :caption: 填充颜色

    gmt begin coastline_3 pdf,png
    gmt basemap -JM25c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue
    gmt end

``-C`` 指定的是湖泊和河流的颜色， ``-G`` 是陆地的颜色。 ``-S`` 是海洋的颜色。
同时，你可以体会到GMT对于颜色支持的丰富性。

绘制边界
--------

使用 ``-N`` 选项可以绘制边界。
``-N1`` 绘制边界线。 ``-N2`` 绘制制澳大利亚和美洲国家所属的州、省界线。
此处界线不作国家划界依据（The boundary here is not used as the basis for the delimitation of the national territory.）。

.. gmtplot::
    :width: 100%
    :caption: 绘制国界

    gmt begin coastline_4 pdf,png
    gmt basemap -JM25c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue -N1/2p,red -N2/1p,black
    gmt end

比例尺
------

最后我们为图画加上比例尺。 ``-Lg-70/41+c-70+w100k+f`` 的含义是比例尺的中点的经纬度为-70和-41，比例尺的长度为2000公里。
绘制的是比例尺为经度-70度的。 ``+f`` 表示风格为黑白相间的铁轨。

.. gmtplot::
    :width: 100%
    :caption: 加上比例尺

    gmt begin coastline_4 pdf,png
    gmt basemap -JM25c -R-130/-50/20/60 -Bxaf -Byaf -BSWEN
    gmt coast -Clightblue -Gdarkgreen -Scornflowerblue -N1/2p,red -N2/1p,black -Lg-70/25+c-70+w500k+f
    gmt end
