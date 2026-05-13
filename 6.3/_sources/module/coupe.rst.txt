.. index:: ! coupe
.. include:: common_SYN_OPTs.rst_

coupe
=====

:官方文档: :doc:`gmt:supplements/seis/coupe`
:简介: 绘制震源机制解的剖面图

:doc:`meca` 在绘制震源球时，本质上是取了一个水平剖面，并将三维震源球的下半球
投影到该水平剖面上。而 :doc:`coupe` 则更灵活一些，可以将三维震源球投影到任意
一个剖面上（例如垂直平面）。

- 对于一个水平剖面，会将下半球投影到平面上（即 :doc:`meca` 的做法）
- 对于一个垂直剖面，会将垂直平面\ **后方** 的半球投影到平面上
- 对于任意一个非水平的平面而言：

  - 北方向为平面的最速下降方向
  - 东方向为平面的走向方向
  - 下方向则根据右手定则确定

语法
----

**gmt coupe** [ *files* ] |-J|\ *parameters*
|SYN_OPT-R| |-A|\ *parameters*
|-S|\ *<format><scale>*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
[ |SYN_OPT-B| ]
[ |-E|\ *fill* ]
[ |-F|\ *mode*\ [*args*] ]
[ |-G|\ *fill* ]
[ |-L|\ *[pen]* ]
[ |-M| ] [ |-N| ]
[ |-Q| ]
[ |-T|\ *nplane*\ [/*pen*] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |-Z|\ *cpt* ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. _-A:

**-A**
    以多种方式指定剖面

**-Aa**\ *lon1/lat1/lon2/lat2/dip/p\_width/dmin/dmax*\ [**+f**]

    - *lon1/lat1* 剖面起点的经纬度
    - *lon2/lat2* 剖面终点的经纬度
    - *dip* 剖面所在平面的倾角（0表示水平剖面，90表示垂直剖面）
    - *p_width* 剖面的宽度（即剖面不是一个平面，而是一个有厚度的长方体）
    - *dmin/dmax* 是沿着最速下降方向（“北”方向）的最小、最大距离（对于垂直平面，可以理解为限制地震深度范围）
    - **+f** 表示根据剖面的参数自动计算边框的范围

**-Ab**\ *lon1/lat1/strike/p\_length/dip/p\_width/dmin/dmax*\ [**+f**]

    - *lon1/lat1* 剖面起点的经纬度
    - *strike* 是剖面的走向
    - *p_length* 是剖面的长度
    - 其他参数与 **-Aa** 相同

**-Ac**\ *x1/y1/x2/y2/dip/p\_width/dmin/dmax*\ [**+f**]

    与 **-Aa** 选项相同，只是 *x/y* 为笛卡尔坐标而不是地理坐标

**-Ad**\ *x1/y1/strike/p\_length/dip/p\_width/dmin/dmax*\ [**+f**]
    与 **-Ab** 选项相同，只是 *x/y* 为笛卡尔坐标而不是地理坐标

.. include:: explain_meca_-S.rst_

可选选项
--------

.. include:: explain_-B.rst_

.. _-E:

**-E**\ *fill*
    扩张部分的填充色 [默认为白色]

.. _-F:

**-F**\ *mode*\ [*args*]
    设置多个属性，可重复使用多次

**-Fs**\ *symbol*\ [*size*][**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    不绘制震源球，仅绘制一个符号。

    *symbol* 为符号类型，可以选择 **c**\|\ **d**\|\ **i**\|\ **s**\|\ **t**\|\ **x**，
    符号的具体含义见 :doc:`plot` 模块的 |-S| 选项。*size* 为符号大小。

    输入数据的格式为::

        longitude latitude depth [event_label]

    若未指定 *size*，则需要从输入数据的第四列读入符号大小，其余列向后移动。

    *event_label* 默认位于震源球上方。使用 **+f** 控制其字体，**+j** 控制其
    位置，**+o** 进一步控制其偏移量。

**-Fa**\ [*size*\ [/*Psymbol*\ [*Tsymbol*]]]
    计算并在震源球上P轴和T轴处绘制符号。
    *size* 是符号大小；
    *Psymbol* 和 *Tsymbol* 符号可以取 **c**\|\ **d**\|\ **h**\|\ **i**\|\ **p**\|\ **s**\|\ **t**\|\ **x**，
    具体含义见 :doc:`plot` |-S| 选项 [默认值为 6p/cc]

**-Fe**\ *fill*
    设置T轴符号的填充色

**-Fg**\ *fill*
    设置P轴符号的填充色

**-Fp**\ *pen*
    设置P轴符号的画笔属性

**-Ft**\ *pen*
    设置T轴符号的画笔属性

**-Fr**\ [*fill*]
    在震源球标签后加一个方框 [默认填充色为白色]

.. _-G:

**-G**\ *color*
    指定压缩部分的填充色 [默认为黑色]

.. _-L:

**-L**\ [*pen*]
    设置震源球外部轮廓的线条属性

.. _-M:

**-M**
    所有震级使用相同的大小，具体大小由 |-S| 选项的 *scale* 参数决定。

.. _-N:

**-N**
    地图区域外的震源球也要绘制，默认不绘制。

.. _-Q:

**-Q**
    默认会生成一些临时文件，其中包含了剖面和剖面上的震源机制的信息，
    供调试时使用。使用该选项，则不会生成这些临时文件。

.. _-T:

**-T**\ [*nplane*][**/**\ *pen*]
    绘制断层平面。

    *nplanes* 可以取：

    - *0** 绘制两个断层面
    - **1** 绘制第一个断层面
    - **2** 绘制第二个断层面

    *pen* 为画笔属性。

    对于双力偶机制解而言，**-T** 选项只绘制震源球的圆周和断层平面，不填充颜色；
    对于非双力偶机制解而言，**-T0** 在震源球的基础上覆盖上透明的断层平面。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*pen*]
    设置断层平面的画笔属性 [默认为 default,black,solid]

.. include:: explain_-XY.rst_

.. _-Z:

**-Z**\ *cpt*
    指定CPT文件，根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
---

矩张量形式的震源机制解，剖面的起点为130E 43N，终点为140E 36N，90度剖面，即垂直剖面。
压缩部分为黑色。建议使用上 **-N**，这样可以防止漏画::

    #!/usr/bin/env bash
    gmt begin profile
    gmt coupe -JX15c/-6c -Sd0.8 -Aa130/43/140/36/90/100/0/700+f -Gblack -Q -N << EOF
    131.55 41.48 579  1.14 -0.10 -1.04 -0.51 -2.21 -0.99 26 X Y
    133.74 41.97 604  6.19 -1.14 -5.05 -0.72 -9.03 -4.24 25 X Y
    135.52 37.64 432  0.95  0.11 -1.06 -0.20 -2.32  0.90 25 X Y
    138.37 42.85 248 -2.49  3.40 -0.91  3.09  0.83 -3.64 25 X Y
    EOF
    gmt basemap -BWS -Byaf+l"Focal depth (km)" -Bxaf+l"Distance (km)"
    gmt end show

相关模块
--------

:doc:`meca`,
:doc:`polar`,
:doc:`basemap`,
:doc:`plot`
