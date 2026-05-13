.. index:: ! solar
.. include:: common_SYN_OPTs.rst_

solar
=====

:官方文档: :doc:`gmt:solar`
:简介: 计算或/和绘制晨昏线以及民用、航海用以及天文用曙暮光区域

语法
----

**gmt solar**
[ |SYN_OPT-B| ]
[ |-C| ]
[ |-G|\ [*fill*] ]
[ |-I|\ [*lon/lat*][**+d**\ *date*][**+z**\ *TZ*] ]
[ |-J|\ *parameters* ]
[ |-M| ]
[ |-N| ]
[ |SYN_OPT-R| ]
[ |-T|\ **dcna**\ [**+d**\ *date*][**+z**\ *TZ*]]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

**-I** 和 **-T** 必须使用一个。

可选选项
--------

.. include:: explain_-B.rst_

.. _-C:

**-C**
    在一行内格式化打印（以Tab键分隔）\ **-I** 选项输出的信息。输出内容包括：

    - 太阳的经度、纬度、方位角、高度角，单位为度
    - 日出、日落、正午的时间，单位为天
    - 日长，单位为分钟
    - 考虑折射效应矫正后的太阳高度较正以及均时差，单位为分钟

    .. note::

       若没有通过 **-I**\ *lon*/*lat* 提供经纬度，则太阳高度角之后的数据均以 (0,0)
       作为参考点。

    示例::

        $ gmt solar -I120/40+d2016-11-01T01:00:00+z8 -C
        160.885755836	-14.5068940782	38.6719503593	-59.513608404	0.270214374769	0.706928713211	0.48857154399	628.868647356	-59.5102114599	16.4569766548

.. _-G:

**-G**\ [*fill*]
    根据晨昏线对黑夜区域填充颜色或图案，见 :doc:`/basis/fill`\。
    若不指定 *fill* 则剪裁黑夜区域，且需要通过 **gmt clip -C** 停止区域剪裁，
    见 :doc:`clip`\ 。

.. _-I:

**-I**\ [*lon/lat*][**+d**\ *date*][**+z**\ *TZ*]
    输出太阳的当前位置、方位角和高度角。加上 *lon*/*lat* 则输出日出、日落、
    正午时间以及一天时间长度。用 **+d**\ *data* 指定ISO格式的日期时间
    （比如 **+d2000-04-25T10:00:00** ）来计算特定时刻的太阳参数。如果有需要，
    也可以通过 **+z**\ *TZ* 加上时区。

    ::

        $ gmt solar -I120/40+d2016-11-01T01:00:00+z8
              Sun current position:    long = 160.885756    lat = -14.506894
                                  Azimuth = 38.6720    Elevation = -59.5136
              Sunrise  = 06:29
              Sunset   = 16:58
              Noon     = 11:44
              Duration = 10:29

.. include:: explain_-J.rst_

.. _-M:

**-M**
    将晨昏线数据以多段ASCII表格式写到标准输出（或二进制格式，
    见 :doc:`/option/binary`\ ）。使用该选项，则只输出数据不绘图。

.. _-N:

**-N**
    反转晨昏线“内”和“外”概念颠倒。仅可与 **-Gc** 一起使用以剪裁出白昼区，
    不可与 **-B** 一同使用。

.. include:: explain_-R.rst_

.. _-T:

**-Tdcna**\ [**+d**\ *date*][**+z**\ *TZ*]
    绘制一个或多个不同定义的晨昏线。若需要导出晨昏线数据，见 **-M** 选项。

    通过添加 **dcna** 来绘制一个或多个不同定义的晨昏线。其中，

    - **d** 指晨昏线
    - **c** 指民用曙暮光
    - **n** 指航海曙暮光
    - **a** 指天文曙暮光

    **+d**\ *date* 为ISO格式的日期时间（例如 **+d2000-04-25T12:15:00**\ ），
    以得到该时刻晨昏交替的位置。也可以通过 **+z**\ *TZ* 加上时区。

    不同曙暮光区的定义如下图所示：

    .. figure:: https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Twilight_subcategories.svg/640px-Twilight_subcategories.svg.png
       :align: center
       :width: 80%

       曙暮光区的多种定义（图片来自于 https://en.wikipedia.org/wiki/Twilight）

    - 民用曙暮光分为晨间曙光区和晚间暮光区：

      - 晨间曙光区是指太阳的几何中心位于地平线以下6˚至地平线以下0˚50'（或日出，
        即太阳上边缘接触地平线）这段时间
      - 晚间曙光区是指太阳的几何中心位于地平线以下 0˚50'（或日落，即太阳下边
        缘接触地平线）至地平线以下6˚ 这段时间

    - 航海曙暮光指太阳中心位于地平线以下 0˚50' 至 12˚ 这段时间
    - 天文曙暮光指太阳中心位于地平线以下 0˚50' 至 18˚ 这段时间

    下面的命令绘制了晨昏线以及三条曙暮光线:

    .. gmtplot::
       :caption: 晨昏线和曙暮光线
       :width: 80%
       :show-code: true

       gmt begin terminator png
         gmt coast -Rd -W0.1p -JQ0/14c -Ba -BWSen -Dl -A1000
         gmt solar -W1p -Tdcna
       gmt end

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*pen*]
    设置晨昏线的画笔属性，见 :doc:`/basis/pen`\ 。

.. include:: explain_-XY.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

示例
----

.. gmtplot::
   :width: 60%

   gmt begin solar png
     gmt coast -Rd -JKs0/10i -Dl -A5000 -W0.5p -N1/0.5p,gray -S175/210/255 -Bafg --MAP_FRAME_TYPE=plain

     gmt solar -Td+d2016-02-09T16:00:00 -Gnavy@95

     gmt solar -Tc+d2016-02-09T16:00:00 -Gnavy@85
     gmt solar -Tn+d2016-02-09T16:00:00 -Gnavy@80
     gmt solar -Ta+d2016-02-09T16:00:00 -Gnavy@80

     gmt solar -I+d2016-02-09T16:00:00 -C | gmt plot -Sksunglasses/1.5c -Gyellow
   gmt end

相关模块
--------

:doc:`clip`,
:doc:`coast`,
:doc:`plot`
