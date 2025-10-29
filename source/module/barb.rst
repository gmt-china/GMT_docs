:author: 何星辰
:date: 2025-10-21

.. index:: ! barb
.. include:: common_SYN_OPTs.rst_

barb
=============

:官方文档: :doc:`gmt:supplements/windbarbs/barb`  
:简介: 在 2D 和 3D 中绘制风羽

**barb** 从 *files* （或标准输入）读取 (x, y, 方位角, 风速) 数据，
并生成用于在地图上绘制风羽的 PostScript 代码。如果设置了 **-JZ|z** 
则 **barb** 会将输入数据的第三列解释为 z 值，并在三维中绘制风羽。
如果未通过 **-Q** 指定风羽长度，则 **barb** 会将输入数据的第三列和第四列分别解释为风羽长度和宽度。
使用 **-G** 选择填充颜色。如果设置了 **-G**，则 **-W** 将控制是否绘制轮廓。

语法
--------
**barb** [ *table* ]
|-J|\ *parameters* |-J|\ **z**\ \|\ **Z**\ *parameters*
|SYN_OPT-Rz|
[ |SYN_OPT-B| ]
[ |-C|\ *cpt* ]
[ |-D|\ *dx*/*dy*\ [/*dz*] ]
[ |-G|\ *fill* ]
[ |-I|\ *intens* ]
[ |-N| ]
[ |-Q|\ *length*\ [**+a**\ *angle*][**+g**\ -\|\ *fill*][**+jb**\|\ **c**\|\ **e**][**+p**\ -\|\ *pen*][**+s**\ *scale*][**+w**\ *width*][**+z**] ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*][*attr*] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]

必选选项
------------------
.. _-J:

.. include:: explain_-J.rst_

.. include:: explain_-Jz.rst_

.. _-R:

.. include:: explain_-Rgeo.rst_

.. include:: explain_-Rz.rst_

可选选项
------------------
.. include:: explain_intables.rst_

.. include:: explain_-B.rst_

.. _-C:

**-C**\ *cpt*
    指定 CPT，或用 **-C**\ *color1,color2*\ [*,color3*\ ,...] 来自动构建连续线性 CPT。
    此时 *color*\ **n** 可以是 RGB 三元组、颜色名或 HTML 十六进制颜色（如 #aabbcc）。
    填充颜色由第三列（或如果设置了 **-Jz** 则为第四列）的值决定。
    其他字段会向后移动一列（例如风羽方位将位于第四而非第五列）。

.. _-D:

**-D**\ *dx*/*dy*\ [/*dz*]
    按指定偏移量 *dx/dy*\ [*dz*\ ] 偏移绘图符号或线条位置 [默认无偏移]。

.. _-G:

**-G**\ *fill*
    为符号或多边形选择填充颜色或图案 [默认不填充]。
    注意 **barb** 会在所有段头中搜索 |-G| 和 |-W|，并覆盖命令行设置。

.. _-I:

**-I**\ *intens*
    使用提供的 *intens* 值（通常在 ±1 范围内）来调节填充颜色模拟光照 [默认无效果]。

.. _-N:

**-N**\ [**c**\ \|\ **r**]
    不裁剪落在地图边界之外的符号 [默认只绘制完全在地图内的点]。
    该选项不适用于始终裁剪的线条和多边形。对于周期性（360°经度）地图，为避免重复边界裁剪符号需绘制两次。
    使用 **-Nr** 关闭裁剪但保留重复符号，或 **-Nc** 保留裁剪但不绘制重复符号。

.. _-Q:

**-Q**\ *length*\ [**+a**\ *angle*][**+g**\ -\|\ *fill*][**+jb**\|\ **c**\|\ **e**][**+p**\ -\|\ *pen*][**+s**\ *scale*][**+w**\ *width*][**+z**]
    修改风羽参数。附加风羽 *length* [默认 0.5c]。
    可添加多个修饰符来指定风羽的位置、形状及对齐方式，下文左/右指从线段起点到终点方向看风羽的两侧：


    - **+a** - 设置风羽角度 [120]  
    - **+g** - 关闭填充（如果为 -）或设置风羽填充 [默认填充]  
    - **+p** - 设置风羽画笔属性。如果 *pen* 以 - 开头，则不绘制轮廓 [默认画笔，绘制轮廓]  
    - **+j** - 设置输入 *x*, *y* 点相对于风羽的位置。选择 **b** 起点 [默认]、**e** 终点或 **c** 中心  
    - **+s** - 设置对应长风羽的风速 [默认 5]  
    - **+w** - 设置风羽宽度  
    - **+z** - 输入 (u,v) 分量而非 (方位角, 风速)  


.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ [*pen*][*attr*] :ref:`(more ...) <-Wpen_attrib>`
    设置线条或符号轮廓画笔属性 [默认：宽度=默认，颜色=黑色，样式=实线]。
    若附加 **+cl** 修饰符，则线条颜色取自 CPT (**-C**)；若附加 **+cf**，
    则符号填充取 CPT 颜色。使用 **+c** 可同时应用两者。

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
--------
.. include:: explain_example.rst_

在三维空间 (0-10), (0-10), (0-100) 上绘制蓝色柱状图（宽度 = 1.25 cm），
位置由 heights.xyz 文件指定，每 2, 2, 10 设置刻度，从东南方向以 30° 仰角观察，可使用::

    gmt barb heights.xyz -R0/10/0/10/0/100 -Jx1.25c -Jz0.125c -So1.25c -Gblue \
         -Bx2+lXLABEL -By2+lYLABEL -Bz10+lZLABEL -B+t"3-D PLOT" -p135/30 -Uc -W -pdf heights


段头解析
--------
段头记录可以包含以下一个或多个选项：

**-G**\ *fill*
    使用新的 *fill* 并开启填充。
**-G-**
    关闭填充。
**-G**
    恢复默认填充（命令行未设置则无填充）。
**-W**\ *pen*
    使用新的 *pen* 并开启轮廓。
**-W**
    恢复默认画笔 :term:`MAP_DEFAULT_PEN` （如果命令行未设置）。
**-W-**
    关闭轮廓。
**-Z**\ *zval*
    根据 z 值 *zval* 从 CPT 获取填充颜色。
**-Z**\ *NaN*
    从 CPT 获取 NaN 颜色。

相关模块
--------
:doc:`colorbar`
:doc:`grdbarb`, 
:doc:`plot3d`
