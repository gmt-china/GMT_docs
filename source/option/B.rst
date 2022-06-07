-B 选项
=======

**-B** 选项用于设置底图边框和轴的属性。

- :ref:`frame_setting`\ 包括：绘制哪条边、画布填充以及图标题
- :ref:`axes_setting`\ 包括：标注、刻度、网格线间隔、轴标签以及标注单位

**-B** 选项有两套语法，分别用于设置底图边框以及每条边（轴）的属性，
因而在一个命令中可能需要多次使用 **-B** 选项。

1. 若命令中没有出现 **-B** 选项，则不绘制底图边框。
2. 若命令中仅出现 **-B**，后面没有任何子选项或字符，则默认绘制上下左右四个轴，
   只在左轴和下轴绘制刻度并标注；其效果等效于 ``-BWSrt``，具体参数含义见下文。

.. _frame_setting:

边框设置
--------

**-B** 选项在设置边框属性时的语法为:

**-B**\ [*axes*][**+b**][**+g**\ *fill*][**+i**\ [*val*]][**+n**][**+o**\ *lon*/*lat*][**+s**\ *subtitle*][**+t**\ *title*][**+w**\ [*pen*]][**+x**\ *fill*][**+y**\ *fill*][**+z**\ *fill*]

其中：

- *axes* 控制显示底图的哪几条边，具体用法在下面进一步介绍
- **+t**\ *title* 指定当前底图的标题。该标题位于底图上方的中间位置。
  标题的文本属性由 :term:`FONT_TITLE` 控制，
  标题与上边框之间的距离由 :term:`MAP_TITLE_OFFSET` 控制
- **+s**\ *subtitle* （需要 **+t**\ *title* 子选项）指定底图副标题，位于标题下方。
  副标题的文本属性由 :term:`FONT_SUBTITLE` 控制
- **+g**\ *fill* 为底图内部填充颜色，见 :doc:`/basis/fill`；在 3-D 图中可用于填充两个背景墙
- **+n** 表示不绘制边框
- **+i**\ [*val*] 对于某些投影方式，某条轴可能不会被绘制或标注（比如 360 度的方位投影地图\
  没有纬度轴，全球 Hammer 投影没有经度轴），使用该子选项可以强制标注一个 *val* 经线或纬线。
  [ *val* 默认值为 0 ]
- **+o**\ *lon*/*lat* 指定网格线的参考点。默认情况下，网格线是以北极点作为参考的，
  如果你想要以另一个点作为参考绘制倾斜的网格线，则可以使用 **+o** 子选项

以下子选项仅用于绘制 3-D 图：

- **+b** 使用该子选项则会绘制 3-D 底图的 12 条边
- **+w**\ [*pen*] 绘制 x-z 和 y-z 平面轮廓，*pen* 可以指定轮廓画笔属性 [默认使用 :term:`MAP_GRID_PEN_PRIMARY`]
- **+x**\ [*fill*] 填充 y-z 平面
- **+y**\ [*fill*] 填充 x-z 平面
- **+z**\ [*fill*] 填充 z-y 平面

通常情况下，绘图时只需要使用 *axes* 和 **+t**\ *title* 选项。

.. note::

    - **+t**\ *title* 以及 **+s**\ *subtitle* 设置的（副）标题可以是任意字符串，
      如果是字符串中有空格，则必须用引号将字符串括起来
    - 使用 ``@^`` 或者 ``<break>`` 标记可以将（副）标题分为多行
    - （副）标题中可以使用 LaTeX 表达式，详见 :doc:`/basis/latex`

*axes*
~~~~~~

*axes* 用于控制要绘制哪些边以及这些边是否有刻度或标注。*axes* 的格式为::

    WSENZ[1234]wsenz[1234]lrbtu

.. gmtplot:: B/axes.sh
    :show-code: false

二维底图（上图中的左图）有四条边，分别用东西南北（WSEN 或 wsen）或左右上下（lrtb）的
单词首字母表示。每条边都有四种状态：

#. 不出现某个字母 => 不绘制该字母所对应的边
#. 出现大写字母 WSEN => 绘制某条边，该边有刻度、有标注
#. 出现小写字母 wsen => 绘制某条边，该边有刻度、无标注
#. 出现小写字母 lrtb => 绘制某条边，该边无刻度、无标注

下图给出了不同的 **-B** 选项绘制出来的效果图。读者可以修改如下命令中的 **-B**
选项来尝试不同搭配的效果::

    gmt basemap -R0/4/0/4 -JX10c -BWS -pdf axes

.. gmtplot:: B/2D-axes-examples.sh
    :show-code: false

3-D 底图有 12 条边（上图中的右图）。对于 3-D 底图而言，**Zzu** 用于控制 Z 轴的绘制

- **Z** 表示有刻度和标注
- **z** 表示有刻度无标注
- **u** 表示无刻度无标注

默认只绘制一条 Z 轴，可以额外加上 **1234** 的任意组合来表示要绘制哪些 Z 轴。
其中 **1** 始终表示位于左下角的 Z 轴，其他 Z 轴按逆时针顺序编号。
加上 **+b** 子选项则绘制全部 12 条边。

下图展示了 3-D 绘图中 **-B** 选项的不同用法。读者可以修改如下命令中的 **-B** 选项
来实现不同搭配的效果::

    gmt basemap -R0/10/0/10/0/10 -JX5c -JZ5c -Bxaf -Byaf -Bzaf -BwesnZ+t"-BwesnZ" -p130/30 -pdf map

.. gmtplot:: B/3D-axes-examples.sh
    :show-code: false

.. _axes_setting:

轴设置
------

X 轴、Y 轴、Z 轴，每条轴都有很多属性，包括刻度间隔、网格线间隔、轴标签以及标注的间隔、前缀和单位。
轴属性可以用如下语法控制:

**-B**\ [**p**\|\ **s**][**x**\|\ **y**\|\ **z**]\ *intervals*\ [**+a**\ *angle*\|\ **n**\|\ **p**][**+e**\ [**l**\|\ **u**]][**+f**][**+l**\|\ **L**\ *label*][**+s**\|\ **S**\ *seclabel*][**+p**\ *prefix*][**+u**\ *unit*]

以上语法也可以被拆分为两部分:

**-B**\ [**p**\|\ **s**][**x**\|\ **y**\|\ **z**]\ *intervals*
和
**-B**\ [**p**\|\ **s**][**x**\|\ **y**\|\ **z**]\ [**+a**\ *angle*\|\ **n**\|\ **p**][**+e**\ [**l**\|\ **u**]][**+f**][**+l**\|\ **L**\ *label*][**+s**\|\ **S**\ *seclabel*][**+p**\ *prefix*][**+u**\ *unit*]

其中，

- **p|s** 表示一级属性（primary）和二级属性（secondary），具体用法下面会进一步介绍
- **x|y|z** 表示设置哪一条轴的属性，具体用法下面会进一步介绍
- *interval* 设置刻度、网格线、标注的间隔，具体用法下面会进一步介绍
- **+a**\ *angle*\|\ **n**\|\ **p** （仅用于笛卡尔轴）用于设置标注的倾斜角度，
  其中 *angle* 是相对于水平方向的旋转角度，取值范围为 -90 到 90 度。
  **+an** 等效于 **+a90** 即垂直标注 [ y 轴默认标注方式]，
  **+ap** 等效于 **+a0** 即平行标注 [ x 轴默认标注方式]。
  默认设置可以使用 :term:`MAP_ANNOT_ORTHO` 修改
- **+l**\ *label* （仅用于笛卡尔轴）用于给指定的轴加标签。
  默认情况下，X 轴标签文字方向平行于 X 轴，Y 轴标签文字方向平行于 Y 轴。
  对于 Y 轴，可以使用 **+L**\ *label* 使得 Y 轴标签文字方向平行于 X 轴
- **+s**\ *label* （仅用于笛卡尔轴）与 **+l**\ *label* 类似，也用于给指定的轴添加标签。
  当同时使用 **+l**\ *label* 和 **+s**\ *secabel* 时，前者用于指定左轴或下轴的标签，
  而后者用于指定右轴和上轴的标签。
  同样，**+S** 使得 Y 轴标签文字平行于 X 轴
- **+p**\ *prefix* （仅用于笛卡尔轴）在选中的轴的标注加前缀
- **+u**\ *unit* （仅用于笛卡尔轴）给选中的轴的标注加单位。
  对于地理图而言，标注的单位为度，该符号是自动添加的，由 :term:`FORMAT_GEO_MAP` 控制
- **+f** （仅用于地理坐标轴）在轴标注后增加 W|S|E|N 标志
- **+e**\ [**l**\|\ **u**] 不显示轴末端的标注（该选项可避免在轴相交的
  地方不同轴的标注重合）。**l** 和 **u** 分别表示较小的标注和较大
  的标注。

.. note::

    - 如果 *label* 、*prefix* 或 *unit* 中包括空格或特殊字符，则必须用引号将字符串括起来。
      特殊字符的使用见 :doc:`/basis/special-character` 章节
    - 轴标签 *label* 可以使用 LaTeX 表达式，详见 :doc:`/basis/latex`
    - 对于非地理投影（如线性投影），指定负的比例尺或底图长度，可以改变坐标轴正方向的指向

**x**\|\ **y**\|\ **z**
~~~~~~~~~~~~~~~~~~~~~~~

**x**\|\ **y**\|\ **z** 用于指明要设置哪条边的属性，默认值为 **xy**，即同时设置 X 轴和 Y 轴的属性。
可以指定单个轴（比如只有 **x**），也可以同时指定多个轴（比如 **xy** 和 **xyz**）。
如果想要不同轴有不同的设置，则需要多次使用 **-B** 选项，每个指定不同的轴。例如::

    -Bxaf -Byaf
    -Bxyzaf

*interval*
~~~~~~~~~~

每个轴都有三个属性，分别是标注（annotation）、刻度（frame）和网格线（grid）。
下图展示了这三个名词在绘图时的具体含义。

.. gmtplot:: B/B_afg.sh
    :width: 60%
    :show-code: false

    GMT 坐标轴中的标注、刻度和网格线

*interval* 用于设置这三个属性的间隔，它是一个或多个 [**a**\|\ **f**\|\ **g**]\ *stride*\ [*phase*][*unit*]
的组合。

- **a** 表示标注、**f** 表示刻度、**g** 表示网格线
- *stride* 用于设置间隔的具体值，*stride* 为 0，表示不绘制
- *phase* 可以用于控制标注的偏移量，需要在前面使用正号或者负号来表示偏移方向
- *unit* 是间隔的单位，通常只在绘制时间轴时才使用，具体见\ :ref:`time_axes`

使用 **c**\ *intfile* 可以用来实现用户自定义的标注和间隔，
详见\ :ref:`custom_axes`

**-B** 选项还有一个可以自动计算间隔的功能，**-Bafg** 会根据当前的区域大小等
信息自动计算合适的间隔，**-Bxafg -Byafg** 则会对 X 轴和 Y 轴分别计算合适的间隔。

用户可以将命令::

    gmt basemap -JX10c/10c -R0/10/0/10 -Ba2f1g1 -pdf test

中的 **-B** 选项替换成如下不同的值并查看绘图效果以理解各个参数的含义：

- **-Ba2f1g1**
- **-Bxa2 -Bya1**
- **-Bxafg -Byafg**
- **-Ba2+1f1g1**

**p**\|\ **s**
~~~~~~~~~~~~~~

对于每个轴来说，都有两个等级的属性可以设置，分别称为 p（Primary，一级属性）和 s（Secondary，二级属性）。

对于地理坐标而言，通常只需要使用默认的 Primary 属性即可，
而 Secondary 则主要用于坐标轴为时间轴的情况下，
此时 **p** 和 **s** 分别用于指定不同尺度的时间间隔。
在 GMT 默认的情况下，**p** 属性的标注比较靠近坐标轴，而 **s** 属性的标注离坐标轴稍远。
因此，为了更好的显示，相比于 **s** 属性，通常情况下，
**p** 属性的标注、刻度线以及网格线间隔都较短，间隔也较小。
**p** 和 **s** 的具体用法与区别，可以参考后面给出的例子。

地理底图
--------

地理底图与一般的坐标轴不同，其底图类型支持使用 :term:`MAP_FRAME_TYPE` 设置为 **fancy** 形式。
使用 :term:`FORMAT_GEO_MAP` 以及 :term:`MAP_DEGREE_SYMBOL` 参数可以修改标注的形式。

.. gmtplot:: B/B_geo_1.sh
    :show-code: false
    :width: 60%

    地理底图示例 1

图中轴和边框属性设置为 ``-Ba1f15mg5m -BS``

下图同时使用了 **p** 和 **s** 两级属性。这里 **p** 属性用于显示度，**s**
属性用于显示分。

.. gmtplot:: B/B_geo_2.sh
    :show-code: false
    :width: 60%

    地理底图示例 2

图中轴和边框属性设置为 ``-Bpa15mf5mg5m -BwSe -Bs1f30mg15m``

笛卡尔线性轴
------------

对于非地理坐标轴，:term:`MAP_FRAME_TYPE` 隐式地设置为 **plain** 。
除此之外，笛卡尔轴和地理坐标轴非常类似。
对于一般的线性轴而言，标注的格式由 :term:`FORMAT_FLOAT_OUT` 决定，
其默认值为 ``%g`` ，即根据数据的大小决定用一般表示还是指数表示，
小数位的数目会根据 *stride* 自动决定。
若设置 :term:`FORMAT_FLOAT_OUT` 为其他值，则会严格使用其定义的格式，
比如 ``%.2f`` 表示显示两位小数。
对于笛卡尔线性轴，使用 **+u**\ *unit* 子选项可以为每个标注添加单位。

.. gmtplot:: B/B_linear.sh
    :show-code: false
    :width: 60%

    笛卡尔线性轴

上图对应的选项设置为 ``-R0/12/0/0.95 -JX3i/0.3i -Ba4f2g1+lFrequency+u" %" -BS``

某些情况下，标注的长度太长导致水平放置时会形成重叠或标注太少，此时，可以使用 **+a**\ *angle*
子选项将标注适当倾斜（如下图所示）。

.. gmtplot::
    :show-code: true
    :width: 60%
    :caption: 笛卡尔线性轴的倾斜标注

    gmt basemap -R2000/2020/35/45 -JX12c -Bxa2f+a-30 -BS -png GMT_-B_slanted

笛卡尔 log\ :sub:`10`\ 轴
-------------------------

由于对数坐标的特殊性，*stride* 参数具有特殊的含义。下面说明 *stride*
在对数坐标下的特殊性：

- *stride* 必须是 1、2、3 或负整数 -n。
  数字用来设置要素（标注/刻度/网格线）出现的位置。

  - **1**：表示要素出现在所有 10 的整次幂的位置
  - **2**：表示要素出现在所有 10 的整次幂的 1、2、5 倍的位置
  - **3**：表示要素出现在所有 10 的整次幂的 1、2、3、4、...、9 倍的位置
  - **-n**：表示要素出现在 10 的 n 次幂的位置

- 在 *stride* 后加 **l**，则标注会以 log\ :sub:`10` 的值显示，比如 100 会显示成 2
- 在 *stride* 后加 **p**，则标注会以 10 的 n 次方的形式显示，比如 10\ :sup:`-5`

.. gmtplot:: B/B_log.sh
    :show-code: false
    :width: 60%

    对数坐标轴

上图分别为 ``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3``、``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3l``
和 ``-R1/1000/0/1 -JX3il/0.25i -Ba1f2g3p`` 三种情况下的结果，请用户仔细分辨其中的差别。

笛卡尔指数轴
------------

正常情况下，*stride* 用于生成等间隔的标注或刻度，但是由于指数函数的特性，
这样的标注会在坐标轴的某一端挤在一起。为了避免这个问题，
可以在 *stride* 后加 **p**，则标注会按照转换后的值等间隔出现，而标注本身依然使用未转换的值。
比如，若 stride = 1，power = 0.5（即 sqrt ），则在 1、4、9、... 处会出现标注。

.. gmtplot:: B/B_pow.sh
    :show-code: false
    :width: 60%

    指数投影坐标轴

图中分别使用 ``-R0/100/0/0.9 -JX3ip0.5/0.25i -Ba20f10g5``
和 ``-R0/100/0/0.9 -JX3ip0.5/0.25i -Ba3f2g1p`` 设置轴属性

.. _time_axes:

时间轴
------

时间轴与其他轴不同的地方在于，时间轴可以有多种不同的标注方式。
下面会用一系列示例来演示时间轴的灵活性。
在下面的例子中，尽管只绘制了 X 轴（绘图时使用了 **-BS**），
实际上时间轴标注的各种用法可以用于全部轴。

在绘制时间轴时，需要指定时间间隔，时间间隔的单位可以取如下值：

.. table:: GMT 时间单位
   :align: center

   +------------+------------------+----------------------------------------------------------------------------------+
   | **Flag**   | **Unit**         | **Description**                                                                  |
   +============+==================+==================================================================================+
   | **Y**      | year             | Plot using all 4 digits                                                          |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **y**      | year             | Plot using last 2 digits                                                         |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **O**      | month            | Format annotation using :term:`FORMAT_DATE_MAP`                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **o**      | month            | Plot as 2-digit integer (1--12)                                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **U**      | ISO week         | Format annotation using :term:`FORMAT_DATE_MAP`                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **u**      | ISO week         | Plot as 2-digit integer (1--53)                                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **r**      | Gregorian week   | 7-day stride from start of week (see :term:`TIME_WEEK_START` )                   |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **K**      | ISO weekday      | Plot name of weekday in selected language                                        |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **k**      | weekday          | Plot number of day in the week (1--7) (see :term:`TIME_WEEK_START` )             |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **D**      | date             | Format annotation using :term:`FORMAT_DATE_MAP`                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **d**      | day              | Plot day of month (1--31) or day of year (1--366) (see :term:`FORMAT_DATE_MAP` ) |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **R**      | day              | Same as **d**; annotations aligned with week (see :term:`TIME_WEEK_START` )      |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **H**      | hour             | Format annotation using :term:`FORMAT_CLOCK_MAP`                                 |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **h**      | hour             | Plot as 2-digit integer (0--24)                                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **M**      | minute           | Format annotation using :term:`FORMAT_CLOCK_MAP`                                 |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **m**      | minute           | Plot as 2-digit integer (0--60)                                                  |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **S**      | seconds          | Format annotation using :term:`FORMAT_CLOCK_MAP`                                 |
   +------------+------------------+----------------------------------------------------------------------------------+
   | **s**      | seconds          | Plot as 2-digit integer (0--60)                                                  |
   +------------+------------------+----------------------------------------------------------------------------------+

.. note::

    - 时间轴的标注（月、周以及天的名字）可能会同时受 :term:`GMT_LANGUAGE`，:term:`FORMAT_TIME_PRIMARY_MAP`
      以及 :term:`FORMAT_TIME_SECONDARY_MAP` 参数的影响。

第一个例子展示了 2000 年春天的两个月，将这两个月的每周的第一天的日期标注出来：

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 1

    gmt begin GMT_-B_time1
        gmt set FORMAT_DATE_MAP=-o FONT_ANNOT_PRIMARY +9p
        gmt basemap -R2000-4-1T/2000-5-25T/0/1 -JX5i/0.2i -Bpxa7Rf1d -Bsxa1O -BS
    gmt end show

需要注意，**-Bsa1O** 指定了次级标注的间隔为一个月，由于此处使用的是大写的 **O**，
因而具体的显示方式由 :term:`FORMAT_DATE_MAP` 决定。
根据 :term:`FORMAT_DATE_MAP` 的说明可知，其值为 **-o**，表明以月份名格式显式。
破折号表示要去掉日期前面的前置零（即 02 变成 2）。

下面的例子用两种不同的方式标注了 1969 年的两天。
图中下面的例子使用周来标注，上面的例子使用日期来标注。

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 2

    gmt begin GMT_-B_time2
        gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY +9p
        gmt basemap -R1969-7-21T/1969-7-23T/0/1 -JX5i/0.2i -Bpxa6Hf1h -Bsxa1K -BS
        gmt basemap -Bpxa6Hf1h -Bsxa1D -BS -Y0.65i
    gmt end show

第三个例子展示了两年的时间，并标注了每年以及每三个月。
年标注位于一年间隔的中间，月标注位于对应月的中间而不是三个月间隔的中间。

.. gmtplot::
    :width: 60%
    :caption: 时间示例 3

    gmt begin GMT_-B_time3
        gmt set FORMAT_DATE_MAP o FORMAT_TIME_PRIMARY_MAP Character FONT_ANNOT_PRIMARY +9p
        gmt basemap -R1997T/1999T/0/1 -JX5i/0.2i -Bpxa3Of1o -Bsxa1Y -BS
    gmt end show

第四个例子展示了一天中的几个小时，通过在 **-R** 选项中指定 **t** 来使用相对时间坐标。
这里使用了 **p** 属性和 **s** 属性，12 小时制，时间从右向左增加：

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 4

    gmt begin GMT_-B_time4
        gmt set FORMAT_CLOCK_MAP=-hham FONT_ANNOT_PRIMARY +9p TIME_UNIT d
        gmt basemap -R0.2t/0.35t/0/1 -JX-5i/0.2i -Bpxa15mf5m -Bsxa1H -BS
    gmt end show

第五个例子用两种方式展示了几周的时间：

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 5

    gmt begin GMT_-B_time5
        gmt set FORMAT_DATE_MAP u FORMAT_TIME_PRIMARY_MAP Character \
            FORMAT_TIME_SECONDARY_MAP full FONT_ANNOT_PRIMARY +9p
        gmt basemap -R1969-7-21T/1969-8-9T/0/1 -JX5i/0.2i -Bpxa1K -Bsxa1U -BS
        gmt set FORMAT_DATE_MAP o TIME_WEEK_START Sunday FORMAT_TIME_SECONDARY_MAP Chararacter
        gmt basemap -Bpxa3Kf1k -Bsxa1r -BS -Y0.65i
    gmt end show

第六个例子展示了 1996 年的前 5 个月，每个月用月份的简写以及两位年份标注：

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 6

    gmt begin GMT_-B_time6
        gmt set FORMAT_DATE_MAP "o yy" FORMAT_TIME_PRIMARY_MAP Abbreviated
        gmt basemap -R1996T/1996-6T/0/1 -JX5i/0.2i -Bxa1Of1d -BS
    gmt end show

第七个例子展示了 2000 年末，2001 年初的部分时段，天用年积日（一年中第几天）的形式标注：

.. gmtplot::
    :width: 60%
    :caption: 时间轴示例 7

    gmt begin GMT_-B_time7
        gmt set FORMAT_DATE_MAP jjj TIME_INTERVAL_FRACTION 0.05 FONT_ANNOT_PRIMARY +9p
        gmt basemap -R2000-12-15T/2001-1-15T/0/1 -JX5i/0.2i -Bpxa5Df1d -Bsxa1Y -BS
    gmt end show

弧度轴 :math:`\pi` 的标注
-------------------------

如果坐标轴以弧度为单位，用户可以直接指定 :math:`\pi` 的整数倍或分数倍作为标注间隔，
其格式为 [*s*]\ **pi**\ [*f*]，其中 s 表示标注间隔是 :math:`\pi` 的 s 倍，
而 f 表示标注间隔为 :math:`\pi` 的 f 分之一。

.. gmtplot::
    :show-code: true
    :width: 60%

    gmt basemap -JX10c/5c -R-12pi/12pi/-1/1 -Bxa3pi -BS -png test1

.. gmtplot::
    :show-code: true
    :width: 60%

    gmt basemap -JX10c/5c -R-pi/pi/-1/1 -Bxapi4 -BS -png test2

.. _custom_axes:

自定义轴
--------

GMT 允许用户定义标注来实现不规则间隔的标注，用法是 **-Bc** 后接标注文件名。

标注文件中以“#”开头的行为注释行，其余为记录行，记录行的格式为::

    coord   type   [label]

- *coord* 是需要标注、刻度或网格线的位置
- *type* 是如下几个字符的组合

  - **a** 或 **i** 前者为 annotation，后者表示 interval annotation，
    在一个标注文件中，**a** 和 **i** 只能出现其中的任意一个
  - **f** 表示刻度，即 frame tick
  - **g** 表示网格线，即 gridline

- *label* 默认的标注为 *coord* 的值，若指定 *label*，则使用 *label* 的值

.. note::

    *coord* 必须按递增顺序排列

下面的例子中展示了自定义标注的用法，**xannots.txt** 和 **yannots.txt**
分别是 X 轴和 Y 轴的标注文件：

.. gmtplot::
    :width: 60%
    :caption: 自定义坐标轴

    cat << EOF >| xannots.txt
    416.0	ig	Devonian
    443.7	ig	Silurian
    488.3	ig	Ordovician
    542	ig	Cambrian
    EOF
    cat << EOF >| yannots.txt
    0	a
    1	a
    2	f
    2.71828	ag	e
    3	f
    3.1415926	ag	@~p@~
    4	f
    5	f
    6	f
    6.2831852	ag	2@~p@~
    EOF

    gmt begin GMT_-B_custom
        gmt basemap -R416/542/0/6.2831852 -JX-12c/6c -Bpx25f5g25+u" Ma" \
            -Bpycyannots.txt -Bsxcxannots.txt -BWS+glightblue \
            --MAP_ANNOT_OFFSET_SECONDARY=10p --MAP_GRID_PEN_SECONDARY=2p
    gmt end show
