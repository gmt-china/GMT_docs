:author: 田冬冬, 陈箫翰, 周茂, 王亮
:date: 2026-01-05

.. index:: ! meca
.. program:: meca

meca
====

:官方文档: :doc:`gmt:supplements/seis/meca`
:简介: 绘制震源机制解

语法
----

**gmt meca**
[ *table* ]
:option:`-J`\ *parameters*
:option:`-R`\ *region*
:option:`-S`\ *format*\ [*scale*][**+a**\ *angle*][**+f**\ *font*][**+j**\ *justify*][**+l**][**+m**][**+o**\ *dx*\ [/*dy*]][**+s**\ *reference*]
[ :option:`-A`\ [**+g**\ [*fill*]][**+o**\ *dx*\ [/*dy*]][**+p**\ *pen*][**+s**\ [*symbol*]\ *size*] ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ *depmin*/*depmax* ]
[ :option:`-E`\ *fill* ]
[ :option:`-F`\ *mode*\ [*args*] ]
[ :option:`-G`\ *fill* ]
[ :option:`-H`\ [*scale*] ]
[ :option:`-I`\ [*intens*] ]
[ :option:`-L`\ [*pen*] ]
[ :option:`-N` ]
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
--------

.. include:: explain_intables.rst_

必须选项
--------

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. note::

    请注意，下面的各个震源机制解格式中，
    设置新的震源球放置位置 *newX* 和 *newY* 必须另外再加上 :option:`-A` 选项后才可生效。

.. include:: explain_meca_-S.rst_

可选选项
--------

.. option:: -A

**-A**\ [**+g**\ [*fill*]][**+o**\ *dx*\ [/*dy*]][**+p**\ *pen*][**+s**\ [*symbol*]\ *size*]
    在 (*newX*,\ *newY*) 处绘制震源球。

    默认会在数据输入所指定的 (*X*,\ *Y*) 坐标处绘制震源球。使用 :option:`-A` 选项，
    则将震源球绘制在 (*newX*,\ *newY*) 处，并绘制一条连接原始位置和偏移后震源球位置的直线。

    使用 **+s**\ *size* 可以在原始位置放置一个小符号并设置符号大小。
    默认符号是圆圈，可设置 *symbol* 更改为 :doc:`plot` 中的任何标准几何符号。
    该符号将使用震源球的颜色填充，但也可以选择固定颜色 (**+g**\ *fill*) 或不填充 (**+g**)。

    连线的画笔属性默认为 :option:`-W` 设置的值，但可以使用 **+p**\ *pen* [0.25p] 进行覆盖。

    使用 **+o** 将 (*newX*,\ *newY*) 解释为绘图偏移量，也可以给所有地震设置统一的的偏移量 *dx/dy*。

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *cpt*
    指定CPT文件，根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

.. option:: -D

**-D**\ *depmin/depmax*
    只绘制震源深度在 *depmin* 和 *depmax* 之间的地震。

.. option:: -E

**-E**\ *fill*
    震源球拉伸部分的填充色[默认为白色]

.. option:: -F

**-F**\ *mode*\ [*args*]
    设置多个属性，可重复使用多次。

    **-Fa**\ [*size*\ [/*Psymbol*\ [*Tsymbol*]]]
        计算并在震源球上P轴和T轴处绘制符号，*size* 是符号大小。
        *Psymbol* 和 *Tsymbol* 符号可以取 **c**\|\ **d**\|\ **h**\|\ **i**\|\ **p**\|\ **s**\|\ **t**\|\ **x**，
        具体含义见 :doc:`plot` **-S** 选项 [默认值为 6p/cc]

    **-Fe**\ *fill*
        设置T轴符号的填充色或填充图案

    **-Fg**\ *fill*
        设置P轴符号的填充色或填充图案

    **-Fp**\ *pen*
        设置P轴符号的画笔属性

    **-Ft**\ *pen*
        设置T轴符号的画笔属性

    **-Fo**
        使用旧版本的 **psvelomeca** 命令的输入数据格式，即不需要第三列的深度信息

    **-Fr**\ [*fill*]
        在震源球标签后加一个方框 [默认填充色为白色]

    **-Fz**\ [*pen*]
        地震矩的各向异性部分的画笔属性

.. option:: -G

**-G**\ *fill*
    指定压缩部分的填充色[默认值为黑色]

.. option:: -H

**-H**\ [*scale*]
    不带参数使用 **-H** 选项会从输入数据读取 *scale* 列作为缩放比例，对每一条记录的符号大小和画笔宽度进行缩放。
    也可以附加 *scale* 参数指定一个统一的缩放比例。详细说明请参考 `数据列顺序`_ 。

.. option:: -I

**-I**\ *intens*
    使用 *intens* 值（±1 范围内），通过模拟光照来调节压缩区填充颜色 [默认无]。
    如果未提供光照强度值，将从输入数据中读取 *intens* 列。详细说明请参考 `数据列顺序`_ 。

.. option:: -L

**-L**\ [*pen*]
    设置震源球外部轮廓的线条属性 [默认由 :option:`-W` 选项决定]。

.. option:: -N

**-N**
    地图区域外的震源球也要绘制，默认不绘制

.. option:: -T

**-T**\ [*plane*]\ [**+p**\ *pen*]
    绘制节面并勾勒出透明的球体轮廓。 *planes* 可以取：

    - **0** 绘制两个节面 [默认]
    - **1** 仅绘制第一个节面
    - **2** 仅绘制第二个节面

    附加 **+p**\ *pen* 设置画笔属性 [默认画笔属性由 :option:`-W` 选项设置]。

    对于双力偶机制解而言，:option:`-T` 选项仅绘制节面和圆周使震源球变为透明。
    对于非双力偶机制解而言， **-T0** 在震源球的基础上叠加透明的最佳双力偶解。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*
    同时设置所有线条以及符号轮廓的画笔属性 [默认值: 0.25p,black,solid]。

    该选项设置的属性可以被 :option:`-A`、:option:`-L`、:option:`-T`、**-Fp**、
    **-Ft**\ 或 **-Fz** 指定的属性替代。

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

绘制了两个震源球，位置在其震中处。震源球的大小随震级变化：5 级地震的震源球大小为 1 厘米:

.. gmtplot:: meca/meca_ex1.sh
   :show-code: true
   :width: 75%

绘制了两个震源球，位置在其震中处。震源球的大小固定:

.. gmtplot:: meca/meca_ex2.sh
   :show-code: true
   :width: 75%

.. _gmt-meca-cpt-example:

震源球大小随震级变化，颜色随深度变化:

.. gmtplot:: meca/meca_ex3.sh
   :show-code: true
   :width: 75%

相关模块
--------

:doc:`polar`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
