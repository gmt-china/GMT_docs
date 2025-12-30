:author: 田冬冬, 陈箫翰, 周茂, 王亮
:date: 2025-12-30

.. index:: ! coupe
.. program:: coupe

coupe
=====

:官方文档: :doc:`gmt:supplements/seis/coupe`
:简介: 绘制震源机制解的剖面图

:doc:`meca` 在绘制震源球时，本质上是取了一个水平剖面，并将三维震源球的下半球投影到该水平剖面上。
而 :doc:`coupe` 则更灵活一些，可以将三维震源球投影到任意一个剖面上（例如垂直平面）。

- 对于一个水平剖面，会将下半球投影到平面上（即 :doc:`meca` 的做法）
- 对于一个垂直剖面，会将垂直平面 **后方** 的半球投影到平面上
- 对于任意一个非水平的平面而言：

  - u方向为平面的最速下降方向
  - s方向为平面的走向方向

输入数据中定义在 r, t, f 座标系中的矩张量会被重新定义到新的 -u^s, -u, s 座标系中。
在实际绘图中，通常使用 **-JX15c/-5c** 这样的投影参数定义一个Y轴正方向向下的笛卡尔座标系进行绘图。
三维震源球投影在这个笛卡尔座标系中的X座标为s方向上相对于剖面起点的距离，单位km。
而Y座标为u方向上相对于剖面起点的距离，单位km。对于一个垂直剖面，Y座标即为深度。

语法
----

**gmt coupe**
[ *table* ]
:option:`-J`\ *parameters*
:option:`-R`\ *region*
:option:`-A`\ **a**\|\ **b**\|\ **c**\|\ **d**\ *params*\ [**+c**\ [**n**\|\ **t**]][**+d**\ *dip*][**+r**\ [**a**\|\ **e**\|\ *dx*]][**+w**\ *width*][**+z**\ [**s**]\ **a**\|\ **e**\|\ *dz*\|\ *min*/*max*]
:option:`-S`\ *format*\ [*scale*][**+a**\ *angle*][**+f**\ *font*][**+j**\ *justify*][**+l**][**+m**][**+o**\ *dx*\ [/*dy*]][**+s**\ *reference*]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ [**+c**][**+g**\ [*fill*]][**+o**\ *dx*\ [/*dy*]][**+p**\ *pen*][**+s**\ [*symbol*]\ *size*] ]
[ :option:`-E`\ *fill* ]
[ :option:`-F`\ *mode*\ [*args*] ]
[ :option:`-G`\ *fill* ]
[ :option:`-H`\ [*scale*] ]
[ :option:`-I`\ [*intens*] ]
[ :option:`-L`\ [*pen*] ]
[ :option:`-N` ]
[ :option:`-Q` ]
[ :option:`-T`\ [*plane*]\ [**+p**\ *pen*] ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
------------------

.. include:: explain_intables.rst_

必须选项
--------

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. option:: -A

**-Aa**\|\ **b**\|\ **c**\|\ **d**\ *params*\ [**+d**\ *dip*][**+r**\ [**a**\|\ **e**\|\ *dx*]][**+w**\ *width*]
    以多种方式指定剖面

    **-Aa**\ *lon1*/*lat1*/*lon2*/*lat2*

        - *lon1/lat1* 剖面起点的经纬度
        - *lon2/lat2* 剖面终点的经纬度
        - *dip* 剖面所在平面的倾角。0表示水平剖面，90表示垂直剖面。默认为90度垂直剖面。
        - *width* 剖面两侧每一侧的宽度范围，单位为km（即剖面不是一个平面，而是一个有厚度的长方体）。宽度范围以外的数据点会被剔除。注意单位固定为km不可更改。默认为无限宽度，即囊括剖面两侧所有的数据点。
        - **+r** 自动计算作图范围，不需要再设置 :option:`-R` 。在后面附加 **a** 会对作图范围自动进行四舍五入。附加 **e** 则表示进行精确计算（默认）。也可以附加一个数值 *dx* ，表示四舍五入到 *dx* 的整数倍。

    **-Ab**\ *lon1*/*lat1*/*strike*/*length*

        - *lon1/lat1* 剖面起点的经纬度
        - *strike* 是剖面的走向的方位角
        - *length* 是剖面的长度，单位固定为km不可更改。
        - 其他参数与 **-Aa** 相同

    **-Ac**\ *x1*/*y1*/*x2*/*y2*

        与 **-Aa** 选项相同，只是 *x/y* 为笛卡尔坐标而不是地理坐标

    **-Ad**\ *x1*/*y1*/*strike*/*length*
        与 **-Ab** 选项相同，只是 *x/y* 为笛卡尔坐标而不是地理坐标

.. include:: explain_meca_-S.rst_

可选选项
--------

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *cpt*
    设置 CPT 根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

.. option:: -D

**-D**\ [**+c**][**+g**\ [*fill*]][**+o**\ *dx*\ [/*dy*]][**+p**\ *pen*][**+s**\ [*symbol*]\ *size*]
    将投影后的震源机制偏移到输入文件最后两列（在可选文本字符串之前）中给出的备用距离和深度。
    另外，如果这两列中给出的是备用地理坐标，则使用 **+c** 先将其转换为剖面内的 *距离, 深度* 坐标，
    在投影到绘图位置后，还可以通过固定绘图偏移 **+o**\ *dx/dy* 进一步调整它们。
    或者使用 **+o** 将这两列的内容解释为绘图偏移量，或者为所有调整后的事件绘图位置附加固定偏移量 *dx/dy*。
    将绘制一条连接原始位置和重新定位后的震源球位置的直线，并可选择在原始位置放置一个小符号 [圆圈]。
    使用 **+s**\ *size* 设置符号的直径 [默认无符号]。
    可以将圆圈更改为 :doc:`plot` 中的任何标准几何符号，即 **a**|\ **c**|\ **d**|\ **g**|\ **h**|\ **i**|\ **n**|\ **p**|\ **s**|\ **t**|\ **x** [**c**]。
    该符号将填充震源球的颜色，但也可以选择固定颜色 (**+g**\ *fill*) 或不填充 (**+g**)。
    连线画笔默认为通过 :option:`-W` 给出的设置，但可以通过使用 **+p**\ *pen* [0.25p] 进行覆盖。
    **注意**：如果选择了叉号符号 (**x**)，则没有填充，因为它只是两条笔划线。使用 :option:`-W` 设置线条粗细，并附加 **+c** 为叉号着色（与其他符号一致）。

.. option:: -E

**-E**\ *fill*
    扩张部分的填充色 [默认为白色]

.. option:: -F

**-F**\ *mode*\ [*args*]
    设置多个属性，可重复使用多次

    **-Fs**\ *symbol*\ [*size*]
        不绘制震源球，仅绘制一个符号。

        *symbol* 为符号类型，可以选择 **c**\|\ **d**\|\ **i**\|\ **s**\|\ **t**\|\ **x**，
        符号的具体含义见 :doc:`plot` 模块的 :option:`-S` 选项。*size* 为符号大小，后面可以附加单位 **c**, **i** 或 **p** 。

        输入数据的格式为::

            longitude latitude depth [event_label]

        若未指定 *size*，则需要从输入数据的第四列读入符号大小，其余列向后移动。 *event_label* 为字符串标签的文本。

    **-Fa**\ [*size*\ [/*Psymbol*\ [*Tsymbol*]]]
        计算并在震源球上P轴和T轴处绘制符号。
        *size* 是符号大小；
        *Psymbol* 和 *Tsymbol* 符号可以取 **c**\|\ **d**\|\ **h**\|\ **i**\|\ **p**\|\ **s**\|\ **t**\|\ **x**，
        具体含义见 :doc:`plot` :option:`-S` 选项 [默认值为 6\ **p**/**cc**]

    **-Fe**\ *fill*
        设置T轴符号的填充色。默认为 :option:`-E` 控制。

    **-Fg**\ *fill*
        设置P轴符号的填充色。默认为 :option:`-G` 控制。

    **-Fp**\ [*pen*]
        绘制P轴符号的轮廓。如果不设置画笔属性 *pen* 则默认为 :option:`-W` 控制。

    **-Ft**\ [*pen*]
        绘制T轴符号的轮廓。如果不设置画笔属性 *pen* 则默认为 :option:`-W` 控制。

    **-Fr**\ [*fill*]
        在震源球标签后加一个方框 [默认填充色为白色]

.. option:: -G

**-G**\ *fill*
    指定压缩部分的填充色 [默认为黑色]

.. option:: -H

**-H**\ [*scale*]
    使用从数据集中读取的 *scale* 对每条记录的符号大小和画笔宽度进行缩放，该比例位于（可选的）*size* 列之后的首列 [默认不缩放]。
    符号大小既可以由 :option:`-S` 提供，也可以通过输入的 *size* 列提供。或者，也可以附加一个常数 *scale* 来代替从比例列中读取。

.. option:: -I

**-I**\ *intens*
    使用提供的 *intens* 值（在 ±1 范围内），通过模拟光照来调制压缩填充颜色 [无]。
    如果未提供强度值，将从由 :option:`-S` 确定的必需输入列之后的额外数据列中读取 *intens*。

.. option:: -L

**-L**\ [*pen*]
    绘制震源球外部轮廓。如果不设置画笔属性 *pen* 则默认为 :option:`-W` 控制。

.. option:: -N

**-N**
    绘图区域外的震源球也要绘制，默认不绘制。

.. option:: -Q

**-Q**
    默认会生成一些临时文件，其中包含了剖面和剖面上的震源机制的信息，
    供调试时使用。使用该选项，则不会生成这些临时文件。

.. option:: -T

**-T**\ [*plane*]\ [**+p**\ *pen*]
    绘制断层平面。

    *plane* 可以取：

    - *0* 绘制两个断层面
    - *1* 绘制第一个断层面
    - *2* 绘制第二个断层面

    可以添加 **+p**\ *pen* 设置画笔属性。如果不设置画笔属性则默认为 :option:`-W` 控制。

    对于双力偶机制解而言，:option:`-T` 选项只绘制震源球的圆周和断层平面，不填充颜色；
    对于非双力偶机制解而言，**-T**\ *0* 在震源球的基础上覆盖上透明的断层平面。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ [*pen*]
    设置断层平面的画笔属性 [默认为 0.25p,black,solid]

.. include:: explain_-XY.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: seis_extra_cols.rst_

示例
----

从文本文件 data.txt 中读取数据，只挑选垂直剖面两侧4km的数据点绘图，自动计算作图范围。示例数据下载：:download:`coupe/data.txt`

.. gmtplot:: coupe/coupe_ex1.sh
   :width: 80%

相关模块
--------

:doc:`meca`,
:doc:`polar`,
:doc:`basemap`,
:doc:`plot`
