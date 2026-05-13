-B 选项
=======

``-B`` 选项用于控制底图边框的显示。

``-B`` 选项有两套语法，分别用于设置底图的边框以及每条轴的属性，因而在一个命令中
可能需要多次使用 ``-B`` 选项。若命令中没有出现 ``-B`` 选项，则不绘制底图边框。

边框设置
--------

``-B`` 选项在设置边框属性时的语法为::

    -B[<axes>][+b][+g<fill>][+n][+o<lon>/<lat>][+t<title]

其中：

- ``<axes>`` 控制显示底图的哪几条边
- ``+b`` 在3D绘图中根据 ``-R`` 选项指定的范围绘制长方体的12条边
- ``+g<fill>`` 在底图内部填色，见 :doc:`/basis/fill` 一节
- ``+n`` 表示不绘制边框和标注
- ``+o<lon>/<lat>`` 指定网格线的参考点。默认情况下，网格线是以北极点作为参考的，
  如果你想要以另一个点作为参考绘制倾斜的网格线，则可以使用 ``+o`` 子选项
- ``+t<title>`` 指定当前底图的标题。该标题位于底图的上方中部。标题可以是任意
  字符串，如果是字符串中有空格，则必须用引号将字符串括起来

通常情况下，只需要使用 ``<axes>`` 和 ``+t<title>`` 选项。

``<axes>``
~~~~~~~~~~

``<axes>`` 用于控制要绘制哪些边以及这些边是否有刻度或标注。\ ``<axes>`` 的格式为::

    WSENZ[1234]wesez[1234]

对于二维图而言，有上下左右四条边，分别用东西南北（WSEN）的
单词首字母表示。对于每条边都有三种状态：

#. 不出现某个字母 => 不绘制该字母所对应的边
#. 出现大写字母WSEN => 绘制某条边，该边有刻度、有标注
#. 出现小写字母wsen => 绘制某条边，该边有刻度、无标注

下面的命令分别使用了不同的 ``-B`` 选项，可以自己执行，查看绘图效果并试着
理解 ``<axes>`` 的用法::

    gmt psbasemap -R0/10/0/10 -JX5c -B2 -BWSEN > test1.ps
    gmt psbasemap -R0/10/0/10 -JX5c -B2 -BWSn > test2.ps

对于3D绘图来说，\ ``<axes>`` 还可以加上一个 ``Z`` 用于控制Z轴。同理，大写的 ``Z``
表示有刻度和标注，小写的 ``z`` 表示有刻度无标注。
表示默认情况下，只会绘制一条Z轴，可以使用
``1234`` 的任意组合来表示要绘制哪些Z轴。其中 ``1`` 表示左下角的Z轴，其他Z轴按
逆时针顺序编号。加上 ``+b`` 子选项，会绘制一个由 ``-R`` 选项范围决定的长方体
的12条边，即相当于一个box。如果Z轴有指定网格间距，则会在xz和yz平面内显示网格线。

下面的命令展示了3D绘图中 ``-B`` 选项的不同用法，读者可以自己一一测试，根据绘图
效果理解 ``-B`` 选项中各字母的含义。命令中的某些选项还没有介绍过，暂时可以不必
理会其含义::

    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bz2 -BWSENZ -p45/45 > test1.ps
    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bz2 -BWSENZ1234 -p45/45 > test2.ps
    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bz2 -BWSEN+b -p45/45 > test3.ps
    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bz2 -B+b -p45/45 > test4.ps
    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bz2 -BWESNZ+b -p45/45 > test5.ps
    gmt psbasemap -R0/10/0/10/0/10 -JX5c -JZ5c -B2 -Bz2 -BwSEnZ+b -p45/45 > test6.ps

示例
~~~~

::

    gmt psbasemap -R0/10/0/10 -JX5c -Ba2g2 -BWSen+glightblue+ttitle > test.ps
    gmt psbasemap -R0/10/0/10 -JX5c -Ba2g2 -BWS+glightblue+t"This is title" > test2.ps

轴设置
------

X轴、Y轴、Z轴，每条轴都有很多属性，包括刻度间隔、网格线间隔、轴标签以及标注的
间隔、前缀和单位。轴属性可以用如下语法控制::

    -B[p|s][x|y|z]<intervals>[+l<label>][+p<prefix>][+u<unit>]

为了更加清晰，以上的语法也可以被分为两部分::

    -B[p|s][x|y|z]<intervals>
    -B[p|s][x|y|z][+l<label>][+p<prefix>][+u<unit>]

其中，

- ``p|s`` 主属性或次属性
- ``x|y|z`` 设置哪一条轴的属性
- ``<interval>`` 设置刻度、网格线、标注的间隔
- ``+l<label>`` 用于给指定的轴加标签。
- ``+p<prefix>`` 选中的轴的标注加前缀
- ``+u<unit>`` 给选中的轴的标注加单位。对于地图而言，标注的单位为度，该符号是
  自动添加的，由 :ref:`FORMAT_GEO_MAP <FORMAT_GEO_MAP>` 控制

``p|s``
~~~~~~~

对于每个轴来说，都有两个等级的属性可以设置，分别称为p（Primary）和s（Secondary）。

对于地理坐标而言，通常只需要使用默认的Primary属性即可，而Secondary则主要用于
坐标轴为时间轴的情况下，此时 ``p`` 和 ``s`` 分别用于指定不同尺度的时间间隔。
在GMT默认的情况下，\ ``p`` 属性的标注比较靠近坐标轴，而 ``s`` 属性的标注离坐标轴
稍远。\ ``p`` 和 ``s`` 的用法与区别，可以参考后面给出的例子。

``x|y|z``
~~~~~~~~~

要设置哪些边的信息，默认值为 ``xy``\ ，即同时设置X轴和Y轴的信息。可以指定单个轴
（比如只有 ``x``\ ），也可以同时指定多个轴（比如 ``xy`` 和 ``xyz``\ ）。如果想要
不同轴有不同的设置，则需要多次使用 ``-B`` 选项，每个指定不同的轴。

``<interval>``
~~~~~~~~~~~~~~

每个轴都有三个属性，分别是标注（annotation）、刻度（frame）和网格线（grid）。
下图展示了这三个名词在绘图时的具体含义。

.. gmtplot:: /scripts/GMT_-B_afg.sh
    :show-code: false
    :caption: GMT坐标轴中的标注、刻度和网格线

``<interval>`` 可以用于设置这三个属性的间隔，它是一个或多个 ``[<t>]<stride>[±<phase>][<u>]``
的组合。

- ``<t>`` 可以取 ``a``\ （标注）、\ ``f``\ （刻度）、\ ``g``\ （网格线），表明了要设置轴的哪部分的间隔
- ``<stride>`` 用于设置间隔，\ ``stride`` 为0，表示不绘制
- ``±<phase>`` 可以用于控制标注、刻度或网格线的起算点
- ``<u>`` 是间隔的单位，主要用于指定时间间隔

``-B`` 选项还有一个可以自动计算间隔的功能，\ ``-Bafg`` 会根据当前的区域大小等
信息自动计算合适的间隔，\ ``-Bxafg -Byafg`` 则会对X轴和Y轴分别计算合适的间隔。

读者可以将命令::

    gmt psbasemap -JX10c/10c -R0/10/0/10 -Ba2f1g1 > test.ps

中的 ``-B`` 选项替换成如下不同的值并查看绘图效果以理解各个参数的含义：

- ``-Ba2f1g1``
- ``-Bxa2 -Bya1``
- ``-Bxafg -Byafg``
- ``-Ba2+1f1g1``

地理底图
--------

地理底图与一般的坐标轴不同，其底图类型 :ref:`MAP_FRAME_TYPE <MAP_FRAME_TYPE>`
使用 ``fancy`` 形式。

.. gmtplot:: /scripts/GMT_-B_geo_1.sh
   :show-code: false

   地理底图示例1

   ``-Ba1f15mg5m -BS``

下图同时使用了 ``p`` 和 ``s`` 两级属性。这里 ``p`` 属性用于显示弧度，\ ``s``
属性用于显示弧分。

.. gmtplot:: /scripts/GMT_-B_geo_2.sh
   :show-code: false

   地理底图示例2

   同时使用P和S两级属性 ``-Bpa15mf5mg5m -BwSe -Bs1f30mg15m``

笛卡尔线性轴
------------

对于一般的线性轴而言，标注的格式由 :ref:`FORMAT_FLOAT_OUT <FORMAT_FLOAT_OUT>`
决定，其默认值为 ``%g``\ ，即根据数据的大小决定用一般表示还是指数表示，小数位的
数目会根据 ``<stride>`` 自动决定。若设置 :ref:`FORMAT_FLOAT_OUT <FORMAT_FLOAT_OUT>`
为其他值，则会严格使用其定义的格式，比如 ``%.2f`` 表示显示两位小数。

.. gmtplot:: /scripts/GMT_-B_linear.sh
   :show-code: false

   笛卡尔线性轴

   ``-R0/12/0/0.95 -JX3i/0.3i -Ba4f2g1+lFrequency+u" %" -BS``

笛卡尔log\ :sub:`10`\ 轴
------------------------

由于对数坐标的特殊性，\ ``<stride>`` 参数具有特殊的含义。下面说明 ``<stride>``
在对数坐标下的特殊性：

- ``<stride>`` 必须是1、2、3或负整数-n。

  - ``1``\ ：每10的指数
  - ``2``\ ：每10的指数的1、2、5倍
  - ``3``\ ：每10的指数的0.1倍
  - ``-n``\ ：每10的n次方出现一次

- 在 ``<stride>`` 后加 ``l``\ ，则标注会以log\ :sub:`10`\ 的值显示，比如100会显示成2
- 在 ``<stride>`` 后加 ``p``\ ，则标注会以10的n次方的形式显示，比如10\ :sup:`-5`

.. gmtplot:: /scripts/GMT_-B_log.sh
   :show-code: false

   对数坐标轴

   (上) \ ``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3``\
   (中) \ ``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3l``\
   (下) \ ``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3p``\

笛卡尔指数轴
------------

正常情况下，\ ``<stride>`` 用于生成等间隔的标注或刻度，但是由于指数函数的特性，
这样的标注会在坐标轴的某一端挤在一起。为了避免这个问题，可以在 ``<stride>`` 后
加 ``p``\ ，则标注会按照转换后的值等间隔出现，而标注本身依然使用未转换的值。
比如，若stride=1，pow=0.5（即sqrt），则在1、4、处会出现标注。

.. gmtplot:: /scripts/GMT_-B_pow.sh
   :show-code: false

   指数投影坐标轴

   (上) ``-R0/100/0/0.9 -JX3ip0.5/0.25i -Ba20f10g5``
   (下) ``-R0/100/0/0.9 -JX3ip0.5/0.25i -Ba3f2g1p``

时间轴
------

时间轴与其他轴不同的地方在于，时间轴可以有多种不同的标注方式。下面会用一系列
示例来演示时间轴的灵活性。在下面的例子中，尽管只绘制了X轴（绘图时使用了 ``-BS``\ ），
实际上时间轴标注的各种用法使用于全部轴。

在绘制时间轴时，需要指定时间间隔，时间间隔的单位可以取如下值：

.. table:: GMT时间单位
   :align: center

   +------------+------------------+--------------------------------------------------------------------------+
   | **Flag**   | **Unit**         | **Description**                                                          |
   +============+==================+==========================================================================+
   | ``Y``      | year             | Plot using all 4 digits                                                  |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``y``      | year             | Plot using last 2 digits                                                 |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``O``      | month            | Format annotation using ``FORMAT_DATE_MAP``                              |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``o``      | month            | Plot as 2-digit integer (1--12)                                          |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``U``      | ISO week         | Format annotation using ``FORMAT_DATE_MAP``                              |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``u``      | ISO week         | Plot as 2-digit integer (1--53)                                          |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``r``      | Gregorian week   | 7-day stride from start of week (see ``TIME_WEEK_START``)                |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``K``      | ISO weekday      | Plot name of weekday in selected language                                |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``k``      | weekday          | Plot number of day in the week (1--7) (see ``TIME_WEEK_START``)          |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``D``      | date             | Format annotation using ``FORMAT_DATE_MAP``                              |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``d``      | day              | Plot day of month (1--31) or day of year (1--366) (FORMAT_DATE_MAP)      |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``R``      | day              | Same as ``d``; annotations aligned with week (see ``TIME_WEEK_START``)   |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``H``      | hour             | Format annotation using ``FORMAT_CLOCK_MAP``                             |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``h``      | hour             | Plot as 2-digit integer (0--24)                                          |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``M``      | minute           | Format annotation using ``FORMAT_CLOCK_MAP``                             |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``m``      | minute           | Plot as 2-digit integer (0--60)                                          |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``S``      | seconds          | Format annotation using ``FORMAT_CLOCK_MAP``                             |
   +------------+------------------+--------------------------------------------------------------------------+
   | ``s``      | seconds          | Plot as 2-digit integer (0--60)                                          |
   +------------+------------------+--------------------------------------------------------------------------+

第一个例子展示了2000年春天的两个月，想要将这两个月的每周的第一天的日期标注出来。

.. gmtplot::
   :caption: 时间轴示例1

   gmt set FORMAT_DATE_MAP=-o FONT_ANNOT_PRIMARY +9p
   gmt psbasemap -R2000-4-1T/2000-5-25T/0/1 -JX5i/0.2i -Bpa7Rf1d -Bsa1O -BS -P > GMT_-B_time1.ps

需要注意，\ ``-Bsa1O`` 指定了次级标注的间隔为一个月，由于此处使用的是大写的 ``O``\ ，
因而具体的显式方式由 :ref:`FORMAT_DATE_MAP <FORMAT_DATE_MAP>` 决定。
根据 :ref:`FORMAT_DATE_MAP <FORMAT_DATE_MAP>` 的说明可知，其值为 ``-o`` 表明
以月份名格式显式。破折号表示要去掉日期前面的前置零（即02变成2）。

下面的例子用两种不同的方式标注了1969年的两天。图中下面的例子使用周来标注，
上面的例子使用日期来标注。

.. gmtplot::
    :caption: 时间轴示例2

    gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY +9p
    gmt psbasemap -R1969-7-21T/1969-7-23T/0/1 -JX5i/0.2i -Bpa6Hf1h -Bsa1K -BS -P -K > GMT_-B_time2.ps
    gmt psbasemap -R -J -Bpa6Hf1h -Bsa1D -BS -O -Y0.65i >> GMT_-B_time2.ps

第三个例子展示了两年的时间，并标注了每年以及每三个月。
年标注位于一年间隔的中间，月标注位于对应月的中间而不是三个月间隔的中间。

.. gmtplot::
    :caption: 时间示例3

    gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP Character FONT_ANNOT_PRIMARY +9p
    gmt psbasemap -R1997T/1999T/0/1 -JX5i/0.2i -Bpa3Of1o -Bsa1Y -BS -P > GMT_-B_time3.ps

第四个例子展示了一天中的几个小时，通过在R选项中指定 ``t`` 来使用相对时间坐标。
这里使用了 ``p`` 属性和 ``s`` 属性，12小时制，时间从右向左增加：

.. gmtplot::
    :caption: 时间轴示例4

    gmt set FORMAT_CLOCK_MAP=-hham FONT_ANNOT_PRIMARY +9p TIME_UNIT d
    gmt psbasemap -R0.2t/0.35t/0/1 -JX-5i/0.2i -Bpa15mf5m -Bsa1H -BS -P > GMT_-B_time4.ps

第五个例子用两种方式展示了几周的时间：

.. gmtplot::
    :caption: 时间轴示例5

    gmt set FORMAT_DATE_MAP u FORMAT_TIME_PRIMARY_MAP Character \
           FORMAT_TIME_SECONDARY_MAP full FONT_ANNOT_PRIMARY +9p
    gmt psbasemap -R1969-7-21T/1969-8-9T/0/1 -JX5i/0.2i -Bpa1K -Bsa1U -BS -P -K > GMT_-B_time5.ps
    gmt set FORMAT_DATE_MAP o TIME_WEEK_START Sunday FORMAT_TIME_SECONDARY_MAP Chararacter
    gmt psbasemap -R -J -Bpa3Kf1k -Bsa1r -BS -O -Y0.65i >> GMT_-B_time5.ps

第六个例子展示了1996年的前5个月，每个月用月份的简写以及两位年份标注：

.. gmtplot::
    :caption: 时间轴示例6

    gmt set FORMAT_DATE_MAP "o yy" FORMAT_TIME_PRIMARY_MAP Abbreviated
    gmt psbasemap -R1996T/1996-6T/0/1 -JX5i/0.2i -Ba1Of1d -BS -P > GMT_-B_time6.ps

第七个例子：

.. gmtplot::
    :caption: 时间轴示例7

    gmt set FORMAT_DATE_MAP jjj TIME_INTERVAL_FRACTION 0.05 FONT_ANNOT_PRIMARY +9p
    gmt psbasemap -R2000-12-15T/2001-1-15T/0/1 -JX5i/0.2i -Bpa5Df1d -Bsa1Y -BS -P > GMT_-B_time7.ps

自定义轴
--------

GMT允许用户定义标注来实现不规则间隔的标注，用法是 ``-Bc`` 后接标注文件名。

标注文件中以“#”开头的行为注释行，其余为记录行，记录行的格式为::

    coord   type   [label]

- ``coord`` 是需要标注、刻度或网格线的位置
- ``type`` 是如下几个字符的组合

  - ``a`` 或 ``i`` 前者为annotation，后者表示interval annotation
  - 在一个标注文件中，\ ``a`` 和 ``i`` 只能出现其中的任意一个
  - ``f`` 表示刻度，即frame tick
  - ``g`` 表示网格线，即gridline

- ``label`` 默认的标注为 ``coord`` 的值，若指定 ``label``\ ，则使用 ``label`` 的值

需要注意，\ ``coord`` 必须按递增顺序排列。

下面的例子展示中展示了自定义标注的用法，\ ``xannots.txt`` 和 ``yannots.txt``
分别是X轴和Y轴的标注文件：

.. gmtplot::
    :caption: 自定义坐标轴

    cat << EOF > xannots.txt
    416.0 ig Devonian
    443.7 ig Silurian
    488.3 ig Ordovician
    542 ig Cambrian
    EOF
    cat << EOF > yannots.txt
    0 a
    1 a
    2 f
    2.71828 ag e
    3 f
    3.1415926 ag @~p@~
    4 f
    5 f
    6 f
    6.2831852 ag 2@~p@~
    EOF
    gmt psbasemap -R416/542/0/6.2831852 -JX-5i/2.5i -Bpx25f5g25+u" Ma" -Bpycyannots.txt \
                  -BWS+glightblue -P -K > GMT_-B_custom.ps
    gmt psbasemap -R416/542/0/6.2831852 -JX-5i/2.5i -Bsxcxannots.txt -BWS -O \
                  --MAP_ANNOT_OFFSET_SECONDARY=10p --MAP_GRID_PEN_SECONDARY=2p >> GMT_-B_custom.ps
    rm -f [xy]annots.txt
