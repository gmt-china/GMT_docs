GSHHG: 全球高精度海岸线数据
===========================

**GSHHG数据主页**\ ： http://www.soest.hawaii.edu/wessel/gshhg/

GSHHG，全称为 A Global Self-consistent, Hierarchical, High-resolution Geography Database。
GMT提供的GSHHG数据中包含了海岸线、河流和国界等数据。

GMT的 :doc:`/module/pscoast` 模块可以直接绘制GSHHG中的数据，也可以使用
:doc:`/module/pscoast` 的 ``-M`` 选项将数据导出为纯文本文件供其他程序使用。

数据精度
--------

GSHHG提供了五种不同精度的数据，以满足不同的需求。五种精度从高到低分别为::

    full > high > intermediate > low > crude

:doc:`/module/pscoast` 的 ``-D`` 选项加上每种精度的单词首字母即可指定使用何种精度的数据。
在绘制全球地图时，可以用 ``-Dc`` 指定使用最低精度的数据，以避免绘制了大量细节而导致文件太大；
在绘制几度范围的小区域地图时，则可以使用 ``-Df`` 指定使用最高精度的数据。
当然，也可以使用 ``-Da`` 选项，此时GMT会根据当前绘图区域的大小自动选择
合适的数据精度。

下面的示例绘制了一个小区域的海岸线边界，可以看到 ``-D`` 取不同精度时边界
精细程度的差异:

.. gmtplot::
    :show-code: false

    gmt set MAP_TITLE_OFFSET -10p
    gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Df" -W1p -Df -K > map.ps
    gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dh" -W1p -Dh -K -O -X4c >> map.ps
    gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Di" -W1p -Di -K -O -X4c >> map.ps
    gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dl" -W1p -Dl -K -O -X4c >> map.ps
    gmt pscoast -JM4c -R-158.3/-157.6/21.2/21.8 -B+t"-Dc" -W1p -Dc -O -X4c >> map.ps

数据内容
--------

GSHHG数据中包含了海岸线数据、河流数据和国界数据。

海岸线
~~~~~~

海岸线数据可以进一步细分为4个不同的等级：

- 1: 陆地和海洋的分界线，即真正意义上的海岸线
- 2: 陆地与湖泊的分界线
- 3: 湖泊中的岛屿与湖泊的分界线
- 4: 湖泊中的岛屿里的池塘与岛屿的分界线

:doc:`/module/pscoast` 模块中有如下几个与海岸线相关的选项：

- ``-W[<level>/]<pen>`` 绘制不同等级的海岸线
- ``-G<fill>`` 设置陆地、岛屿等陆区的填充色
- ``-S<fill>`` 设置海洋、湖泊等水区的填充色
- ``-Cl<fill>`` 设置湖泊的填充色
- ``-Cr<fill>`` 设置河流湖的填充色

河流
~~~~

河流进一步可以细分为10个等级：

- 0: Double-lined rivers (river-lakes).
- 1: Permanent major rivers.
- 2: Additional major rivers.
- 3: Additional rivers.
- 4: Minor rivers.
- 5: Intermittent rivers - major.
- 6: Intermittent rivers - additional.
- 7: Intermittent rivers - minor.
- 8: Major canals.
- 9: Minor canals.
- 10: Irrigation canals.

:doc:`/module/pscoast` 模块的 ``-I`` 选项可以用于绘制不同等级的河流，其基本语法
为 ``-I<level>/<pen>``\ 。其中 ``<level>`` 除了可以取1至10之外，还可以取：

- ``a``: 所有河流和运河，即包含0-10等级的所有河流
- ``A``: 除了河流湖之外的所有河流和运河，即包含1-10等级的河流
- ``r``: 所有永久河流，即0-4等级
- ``R``: 除了河流湖之外的永久河流，即1-4等级
- ``i``: 所有间歇性河流，即5-7等级
- ``c``: 所有运河，即8-10等级

该选项可以重复多次使用，为不同等级的河流设置不同的画笔属性。

国界线
~~~~~~

国界线进一步细分为三个等级

- 1: 国界
- 2: 美国州界
- 3: 海洋边界

:doc:`/module/pscoast` 模块的 ``-N`` 选项可以用于绘制不同等级的国界线，其基本
语法为 ``-N<level>/<pen>``\ 。其中 ``<level>`` 可以取1至3，也可以
取 ``a`` \（表示所有边界）。该选项可以重复多次使用，
为不同等级的国界设置不同的画笔属性。

使用示例
--------

绘制1级海岸线：

.. gmtplot::

    gmt pscoast -R-130/-70/24/52 -JL-100/35/33/45/15c -Ba -Dh -A1000 -W1/0.5p -P > map.ps

同时绘制1-3级海岸线，黑色的为1级海岸线，红色的为2级湖泊线（图中的大面积红色区域为五大湖），
蓝色的为3级岛屿线（即五大湖内部的岛屿）：

.. gmtplot::

    gmt pscoast -R-130/-70/24/52 -JL-100/35/33/45/15c -Ba -Dh -A1000 \
        -W1/0.5p -W2/0.3p,red -W3/0.2p,blue -P > map.ps

绘制1-3级海岸线，并为陆地、还有、湖泊填充不同的颜色：

.. gmtplot::

    gmt pscoast -R-130/-70/24/52 -JL-100/35/33/45/15c -Ba -Dh -A1000 \
        -W1/0.5p -W2/0.3p,red -W3/0.2p,blue \
        -Gtan -Slightblue -Cl/royalblue -P > map.ps

绘制海岸线、国界和美国州界：

.. gmtplot::

    gmt pscoast -R-130/-70/24/52 -JL-100/35/33/45/15c -Ba -Dh -A1000 \
        -W1/0.5p -N1/thick,red -N2/thinner \
        -Gtan -Slightblue -Cl/royalblue -P > map.ps

备注
----

GSHHG提供的中国国界数据不符合中国的领土主张，在正式刊物中发表使用此类国界
数据的图件时都可能存在问题。
