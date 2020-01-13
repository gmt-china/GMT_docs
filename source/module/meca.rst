.. index:: ! meca
.. include:: common_SYN_OPTs.rst_

meca
====

:官方文档: :doc:`gmt:supplements/seis/meca`
:简介: 绘制震源机制解

语法
----

**gmt meca** [ *table* ] |-J|\ *parameters* |SYN_OPT-R|
|-S|\ *<format><scale>*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
[ |SYN_OPT-B| ]
[ |-C|\ [*pen*\ ][\ **+s**\ *size*] ] [ |-D|\ *depmin*/*depmax* ]
[ |-E|\ *fill*]
[ |-F|\ *mode*\ [*args*] ] [ |-G|\ *fill*] [ |-L|\ [*pen*\ ] ]
[ |-M| ]
[ |-N| ]
[ |-T|\ *nplane*\ [/*pen*\ ] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |-Z|\ *cpt*]
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

.. _-S:

**-S**\ *<format><scale>*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    指定输入数据的格式、震源球大小等属性。

    *format* 用于指定输入的震源机制解的格式。

    *scale* 指定了5级地震（地震矩为4.0E23 dynes-cm）的震源球的直径。
    默认情况下，震源球的直径与震级大小成正比，即实际直径为 *size* = M / 5 * *scale*\ 。
    若使用 **-M** 选项，则所有震源球大小相同。

    每个震源球都可以有一个可选的标签。标签默认位于震源球的上方。

    - **+f**\ *font* 设置震源球标签的文本属性
    - **+j**\ *justify* 标签相对于震源球的位置 [默认为 **BC**\ ，即正上方]
    - **+o**\ *dx*\ [/*dy*] 标签的额外偏移量

**-Sa**\ *scale*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    Aki and Richards约定的震源机制格式。输入文件的具体格式为::

        X  Y  depth  strike  dip  rake  mag  [newX  newY]  [title]

    - *X* 和 *Y* 为震源经度和纬度
    - *depth* 为震源深度，单位为km
    - *strike*\ 、\ *dip*\ 、\ *rake* 为断层的三个基本参数，单位为度
    - *mag* 为地震震级
    - *newX* 和 *newY* 震源球在图上的经纬度[可选]。默认震源球会放在 *X* 和 *Y*
      处，指定新的震源球放置位置 *newX* 和 *newY* 以使得震源球与震源位置错开。
    - *title* 震源球标签[可选]

**-Sc**\ *scale*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    Global CMT约定的震源机制解格式。输入文件的具体格式为::

        X Y depth strike1 dip1 rake1 strike2 dip2 rake2 mantissa exponent [newX newY] [title]

    - *X* 和 *Y* 为震源经度和纬度
    - *depth* 为震源深度，单位为km
    - 两组 *strike*\ 、\ *dip*\ 、\ *rake* 为两个断层面的基本参数
    - *mantissa* 和 *exponent* 是地震标量矩的尾数和指数部分。
      例如，地震标量矩为9.56e+26 dyne-cm，则 *mantissa*\ =9.56，\ *exponent*\ =26
    - *newX* 和 *newY* 震源球在图上的经纬度[可选]。默认震源球会放在 *X* 和 *Y*
      处，指定新的震源球放置位置 *newX* 和 *newY* 以使得震源球与震源位置错开。
    - *title* 震源球标签[可选]

**-Sm\|d\|z**\ *scale*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    地震矩张量。输入数据格式为::

        X Y depth mrr mtt mff mrt mrf mtf exp [newX newY] [title]

    - *X* 和 *Y* 为震源经度和纬度
    - *depth* 为震源深度，单位为km
    - *mrr* 等是地震矩的6个分量，单位是 :math:`10^{exp}` dyne-cm
    - *exp* 地震矩的指数部分。例如 *mrr*\ =2.5，\ *exp*\ =26 ，则真实 *mrr* = 2.0e26
    - *newX* 和 *newY* 震源球在图上的经纬度[可选]。默认震源球会放在 *X* 和 *Y*
      处，指定新的震源球放置位置 *newX* 和 *newY* 以使得震源球与震源位置错开。
    - *title* 震源球标签[可选]

    地震矩张量可以分解成各向同性部分（ISO）、双力偶部分（DC）和补偿线性向量
    偶极部分（CLVD）。

    - **m** 表示绘制完整的地震矩张量（ISO+DC+CLVD）
    - **d** 表示仅绘制地震矩的双力偶部分（DC）
    - **z** 表示仅绘制地震矩的各向异性部分（DC+CLVD）

    说明：

    - 6个分量使用的坐标系为USE坐标系，与Global CMT的坐标系一致
    - Global CMT的矩张量解不包含各向同性部分，因而 **-Sm** 和 **-Sz** 的效果相同。

**-Sp**\ *scale*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    由两个断层平面的部分数据构成的机制解。输入数据格式为::

        X Y depth strike1 dip1 strike2 fault mag [newX newY] [title]

    - *X* 和 *Y* 为震源经度和纬度
    - *depth* 为震源深度，单位为km
    - *strike1* 和 *dip1* 平面1的断层参数，\ *strike2* 是平面2的断层参数
    - *fault* 取-1或+1，表示正断层和逆断层
    - *mag* 地震震级
    - *newX* 和 *newY* 震源球在图上的经纬度[可选]。默认震源球会放在 *X* 和 *Y*
      处，指定新的震源球放置位置 *newX* 和 *newY* 以使得震源球与震源位置错开。
    - *title* 震源球标签[可选]

**-Sx\|y\|t**\ *scale*\ [**+f**\ *font*][**+j**\ *justify*][**+o**\ *dx*\ [/*dy*]]
    指定T、N、P轴的方位和大小。输入数据格式为::

        X Y depth Tvalue Tazim Tplunge Nvalue Nazim Nplunge Pvalue Pazim Pplunge exp [newX newY] [title]

    - *X* 和 *Y* 为震源经度和纬度
    - *depth* 为震源深度，单位为km
    - *Tvalue* 等9个量定义了T、N、P轴的大小和方向
    - *exp* 是 *Tvalue* 等的指数部分
    - *newX* 和 *newY* 震源球在图上的经纬度[可选]。默认震源球会放在 *X* 和 *Y*
      处，指定新的震源球放置位置 *newX* 和 *newY* 以使得震源球与震源位置错开。
    - *title* 震源球标签[可选]

    地震矩张量可以分解成各向同性部分（ISO）、双力偶部分（DC）和补偿线性向量
    偶极部分（CLVD）。

    - *x* 绘制完整的地震矩张量 (ISO+DC+CLVD)
    - *y* 只绘制地震矩的双力偶部分 (DC)
    - *z* 只绘制地震局的各向异性部分 (DC+CVLD)

可选选项
--------

.. include:: explain_-B.rst_

.. _-C:

**-C**\ [*pen*\ ][\ **+s**\ *size*]
    在 (*newX*,\ *newY*) 处绘制震源球

    默认会在数据输入所指定的 (*X*,\ *Y*) 坐标处绘制震源球。使用 **-C** 选项，
    则将震源球绘制在 (*newX*,\ *newY*) 处，在震源位置绘制一个小圆，
    并将 (*X*,\ *Y*) 和 (*newX*,\ *newY*) 连线。

    *pen* 控制连线的画笔属性，\ **+s**\ *size* 指定圆的大小。
    [默认使用 **-W** 选项的 *pen* 属性，\ *size* 为0]

.. _-D:

**-D**\ *depmin/depmax*
    只绘制震源深度在 *depmin* 和 *depmax* 之间的地震。

.. _-E:

**-E**\ *fill*
    震源球拉伸部分的填充色[默认为白色]

.. _-F:

**-F**\ *mode*\ [*args*]
    设置多个属性，可重复使用多次。

**-Fa**\ [*size*\ [/*Psymbol*\ [*Tsymbol*\ ]]]
    计算并在震源球上P轴和T轴处绘制符号。
    *size* 是符号大小；
    *Psymbol* 和 *Tsymbol* 符号可以取 **c**\ \|\ **d**\ \|\ **h**\ \|\ **i**\ \|\ **p**\ \|\ **s**\ \|\ **t**\ \|\ **x**\ ，
    具体含义见 :doc:`plot` **-S** 选项 [默认值为 6p/cc]

**-Fe**\ *fill*
    设置T轴符号的填充色

**-Fg**\ *fill*
    设置P轴符号的填充色

**-Fp**\ *pen*
    设置P轴符号的画笔属性

**-Ft**\ *pen*
    设置T轴符号的画笔属性

**-Fo**
    使用旧版本的 **psvelomeca** 命令的输入数据格式，即不需要第三列的深度信息

**-Fr**\ [*fill*\ ]
    在震源球标签后加一个方框 [默认填充色为白色]

**-Fz**\ [*pen*\ ]
    覆盖零迹矩张量的画笔属性

.. _-G:

**-G**\ *fill*
    指定压缩部分的填充色[默认值为黑色]

.. _-L:

**-L**\ [*pen*\ ]
    设置震源球外部轮廓的线条属性[默认由 **-W** 选项决定]

.. _-M:

**-M**
    所有震级使用相同的大小。震源球大小由 **-S** 选项的 *scale* 参数决定。

.. _-N:

**-N**
    地图区域外的震源球也要绘制，默认不绘制

.. _-T:

**-T**\ [*nplane*\ ][\ **/**\ *pen*]
    绘制断层平面。

    *nplanes* 可以取：

    - *0** 绘制两个断层面
    - **1** 绘制第一个断层面
    - **2** 绘制第二个断层面

    *pen* 为画笔属性。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    同时设置所有线条以及符号轮廓的画笔属性以及标题颜色。

    该选项设置的属性可以被 **-C**\ 、\ **-L**\ 、\ **-T**\ 、\ **-Fp**\ 、
    **-Ft**\ 或 **-Fz** 指定的属性替代。

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
----

访问 :doc:`/gallery/beachball/index` 以查看示例。

相关模块
--------

:doc:`polar`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
