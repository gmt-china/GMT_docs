.. index:: ! clip
.. include:: common_SYN_OPTs.rst_

clip
====

:官方文档: :doc:`gmt:clip`
:简介: 打开或关闭多边形裁剪路径

该模块会从输入文件中读取XY数据，由此构成一个或多个多边形，进而构建出一个或
多个裁剪路径。接下来的所有绘图命令中，只有在多边形内部的部分才会被绘制。

为了判断某个点是在裁剪区域内还是在裁剪区域外，clip使用了“奇偶规则”。从任意
一点绘制一条任意方向的射线，若该射线穿过裁剪路径线段奇数次，则该点位于裁剪
区域内；若穿过偶数次，则该点位于裁剪区域外。\ **-N** 选项可以颠倒内外的定义。

最后，记得再次调用 **gmt clip -C** 以关闭裁剪区域。

语法
----

**gmt clip** [ *table* ] |-J|\ *parameters* |-C|\ [*n*]
|SYN_OPT-Rz|
[ |-A|\ [**m**\|\ **p**\|\ **x**\|\ **y**] ]
[ |SYN_OPT-B| ]
|-J|\ **z**\|\ **Z**\ *parameters* ]
[ |-N| ]
[ |-T| ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. _-C:

**-C**\ [*n*]
    结束当前裁剪路径。

    默认会关闭所有已开启的裁剪路径。使用 **-C**\ *n* 则仅关闭当前所有处于激活状态下的
    裁剪路径中的其中 *n* 个。

    若在开启裁剪后有使用 **-X** 或 **-Y** 移动过坐标原点，则在关闭裁剪路径时也需要
    使用 **-X** 或 **-Y** 选项。

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

可选选项
--------

.. include:: explain_intables.rst_

.. _-A:

**-A**\ [**m**\|\ **p**\|\ **x**\|\ **y**]
    修改两点间的连接方式

    地理投影下，两点之间默认沿着大圆弧连接。

    - **-A**\ ：忽略当前的投影方式，直接用直线连接两点
    - **-Am**\ ：先沿着经线画，再沿着纬线画
    - **-Ap**\ ：先沿着纬线画，再沿着经线画

    笛卡尔坐标下，两点之间默认用直线连接。

    - **-Ax** 先沿着X轴画，再沿着Y轴画
    - **-Ay** 先沿着Y轴画，再沿着X轴画

.. include:: explain_-B.rst_

.. _-N:

**-N**
    反转“区域内”和“区域外”的概念，即只有在多边形外的部分才是裁剪区域，绘图时
    只有在多边形外的才会被绘制。该选项不能与 **-B** 选项连用。

.. _-T:

**-T**
    不需要任何输入数据。根据 **-R** 选项将整个地图区域裁剪出来，
    该选项不能与 **-B** 选项连用。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. _-W:

**-W**\ *pen*
    绘制裁剪路径的轮廓 [默认不绘制]

.. include:: explain_-XY.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

示例
----

::

    gmt begin clip
    # 打开裁剪路径
    gmt clip -R0/6/0/6 -Jx2.5c -W1p,blue << EOF
    0 0
    5 1
    5 5
    EOF
    # 其他绘图命令
    gmt plot @tut_data.txt -Gred -Sc2c
    # 关闭裁剪路径
    gmt clip -C -B
    gmt end show

相关模块
--------

:doc:`basemap`,
:doc:`grdmask`,
:doc:`mask`
