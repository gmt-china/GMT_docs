.. index:: ! meca
.. include:: common_SYN_OPTs.rst_

meca
====

:官方文档: :doc:`gmt:supplements/seis/meca`
:简介: 绘制震源机制解

语法
----

**gmt meca** [ *table* ]
|-J|\ *parameters*
|SYN_OPT-R|
|-S|\ *format*\ [*scale*][**+a**\ *angle*][**+f**\ *font*][**+j**\ *justify*][**+l**][**+m**][**+o**\ *dx*\ [/*dy*]][**+s**\ *reference*]
[ |-A|\ [**+p**\ *pen*][**+s**\ *size*] ]
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ *depmin*/*depmax* ]
[ |-E|\ *fill* ]
[ |-F|\ *mode*\ [*args*] ]
[ |-G|\ *fill* ]
[ |-H|\ [*scale*] ]
[ |-I|\ [*intens*] ]
[ |-L|\ [*pen*] ]
[ |-N| ]
[ |-T|\ *nplane*\ [/*pen*] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ *pen* ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. include:: explain_meca_-S.rst_

可选选项
--------

.. include:: explain_-B.rst_

.. _-A:

**-A**\ [**+p**\ *pen*][**+s**\ *size*]
    在 (*newX*,\ *newY*) 处绘制震源球

    默认会在数据输入所指定的 (*X*,\ *Y*) 坐标处绘制震源球。使用 |-A| 选项，
    则将震源球绘制在 (*newX*,\ *newY*) 处，在震源位置绘制一个小圆，
    并将 (*X*,\ *Y*) 和 (*newX*,\ *newY*) 连线。

    *pen* 控制连线的画笔属性，**+s**\ *size* 指定圆的大小。
    [默认使用 |-W| 选项的 *pen* 属性，*size* 为0]

.. _-C:

**-C**\ *cpt*
    指定CPT文件，根据数据文件中第三列的值（即地震深度）确定震源球的压缩部分的颜色。

.. _-D:

**-D**\ *depmin/depmax*
    只绘制震源深度在 *depmin* 和 *depmax* 之间的地震。

.. _-E:

**-E**\ *fill*
    震源球拉伸部分的填充色[默认为白色]

.. _-F:

**-F**\ *mode*\ [*args*]
    设置多个属性，可重复使用多次。

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

**-Fo**
    使用旧版本的 **psvelomeca** 命令的输入数据格式，即不需要第三列的深度信息

**-Fr**\ [*fill*]
    在震源球标签后加一个方框 [默认填充色为白色]

**-Fz**\ [*pen*]
    覆盖零迹矩张量的画笔属性

.. _-G:

**-G**\ *fill*
    指定压缩部分的填充色[默认值为黑色]

.. _-L:

**-L**\ [*pen*]
    设置震源球外部轮廓的线条属性[默认由 |-W| 选项决定]

.. _-M:

**-M**
    所有震级使用相同的大小。震源球大小由 |-S| 选项的 *scale* 参数决定。

.. _-N:

**-N**
    地图区域外的震源球也要绘制，默认不绘制

.. _-T:

**-T**\ [*nplane*][**/**\ *pen*]
    绘制断层平面。

    *nplanes* 可以取：

    - **0** 绘制两个断层面
    - **1** 绘制第一个断层面
    - **2** 绘制第二个断层面

    *pen* 为画笔属性。

    对于双力偶机制解而言，**-T** 选项只绘制震源球的圆周和断层平面，不填充颜色；
    对于非双力偶机制解而言，**-T0** 在震源球的基础上覆盖上透明的断层平面。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    同时设置所有线条以及符号轮廓的画笔属性以及标题颜色。

    该选项设置的属性可以被 **-C**、**-L**、**-T**、**-Fp**、
    **-Ft**\ 或 **-Fz** 指定的属性替代。

.. include:: explain_-XY.rst_

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

绘制了两个震源球，位置在其震中处。震源球的大小随震级变化：5 级地震的震源球大小为 1 厘米:

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt meca -JQ104/15c -R102.5/105.5/30.5/32.5 -Ba -Sa1c -png,pdf beachball_1 << EOF
    # 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
    104.33 31.91 39.8 32 64 85 7 0 0 A
    104.11 31.52 27.1 22 53 57 6 0 0 B
    EOF

绘制了两个震源球，位置在其震中处。震源球的大小固定:

.. gmtplot::
   :show-code: true
   :width: 75%

    gmt meca -JQ104/15c -R102.5/105.5/30.5/32.5 -Ba -Sa1c -M -png,pdf beachball_2 << EOF
    # 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
    104.33 31.91 39.8 32 64 85 7 0 0 A
    104.11 31.52 27.1 22 53 57 6 0 0 B
    EOF

.. _gmt-meca-cpt-example:

震源球大小随震级变化，颜色随深度变化:

.. gmtplot::
   :show-code: true
   :width: 75%

    #!/usr/bin/env bash
    gmt begin beachball_3
    gmt basemap -JQ104/15c -R102.5/105.5/30.5/32.5 -Ba -BWSen
    gmt coast -Da -Ia/0.05,black
    gmt makecpt -T0/100/20
    gmt meca -A+s0.2c -Sa1.3c -C << EOF
    # 经度 纬度 深度(km) strike dip rake 震级 newX newY ID
    104.33 31.91 39.8  32 64   85 7.0      0     0 A
    104.11 31.52 27.1  22 53   57 6.0      0     0 B
    103.67 31.13  6.4  86 32  -65 8.0      0     0 C
    103.90 31.34 43.6 194 84  179 4.9 104.18 30.84 D
    103.72 31.44 67.3  73 84 -162 4.9 103.12 31.64 E
    104.12 31.78 12.7 186 68  107 4.7 103.83 32.26 F
    104.23 31.61 62.0  86 63  -51 4.7 104.96 31.69 G
    EOF
    gmt colorbar -DjBL+w5c/0.5c+ml+o0.8c/0.4c -Bx+lDepth -By+lkm
    gmt end show

相关模块
--------

:doc:`polar`,
:doc:`coupe`,
:doc:`basemap`,
:doc:`plot`
