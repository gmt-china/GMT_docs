.. index:: ! gmtvector
.. include:: common_SYN_OPTs.rst_

gmtvector
=========

:官方文档: :doc:`gmt:gmtvector`
:简介: 操作二维和三维笛卡尔坐标向量

**gmtvector** 读取含有 (x, y)，(x, y, z)，(r, theta) 或 (lon, lat) 等坐标的表文件。
给定 **-fg** 时，将坐标假定为地理坐标并只包含两列，将其转换到单位球上的三维笛卡尔
坐标；使用 **-Ci** 选项时，则表明输入数据为 (x, y) 或 (x, y, z)；默认情况下，输入文件的坐标
为 (r, theta) 形式的极坐标。如果不给定输入文件，则可以通过 |-A| 选项传递单个向量。
可对向量进行的操作包括求夹角，叉乘，相加以及旋转等，其中需要第二个向量时可由 **-S**
指定。输出向量将会被转换为 (lon, lat) 或者 (r, theta) 的形式，除非使用 **-Co** ，该
选项将输出指定为笛卡尔坐标形式。

语法
----

**gmt vector** [ *table* ]
[ |-A|\ **m**\ [*conf*]\|\ *vector* ]
[ |-C|\ [**i**\|\ **o**] ]
[ |-E| ]
[ |-N| ]
[ |-S|\ *vector* ]
[ |-T|\ **a**\|\ **d**\|\ **D**\|\ **p**\ *azim*\|\ **r**\ [*arg*]\|\ **R**\|\ **s**\|\ **t**\ [*arg*]\|\ **x** ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    输入表数据文件名。**-fg** 表明输入坐标为 (lon, lat)；**-Ci** 表明输入数据为 
    (x, y) 或 (x, y, z)，其他情况下，坐标为 (r, theta) 形式。

可选选项
--------

.. _-A:

**-A**\ **m**\ [*conf*]\|\ *vector*
    指定单个向量，而不从文件中读取。**m** 选项可以对输入文件中的向量平均，得到一个向量
    作为主向量（即对所有点的平均），并可计算该向量的置信椭圆（长轴以及方位角，地理坐标的轴单位为 km）。
    可使用百分比的形式添加置信水平 *conf* [95]。这三个参数将在输出的最后三列。

.. _-C:

**-C**\ [**i**\|\ **o**]
    将输入和输出设置笛卡尔坐标。 **i** 和 **o** 分别表示输入和输出。默认情况下，二维
    向量为极坐标，三维向量为地理坐标。

.. _-E:

**-E**
    将输入的地理坐标从大地坐标转换为地心坐标，并将输出的地理坐标从地心坐标转换为大地坐标。
    该选项只有 **-fg** 设置时，才会生效。

.. _-N:

**-N**
    在输出前，将向量进行归一化（仅在 **-Co** 设置时有效）

.. _-S:

**-S**\ [*vector*]
    指定第二个向量，格式与第一个向量相同。**-T** 选项可以实现两向量之间的运算。

.. _-T:

**-T**\ **a**\|\ **b**\|\ **d**\|\ **D**\|\ **p**\ *azim*\|\ **s**\|\ **r**\ [*arg*]\|\ **R**\|\ **s**\|\ **t**\ [*arg*]\|\ **x**
    对向量进行变换

    - **a** 平均位置

    - **b** 经过两向量（点）的大圆的中点

    - **d** 点积

    - **D** 两向量之间的角度

    - **p**\ *azim* 求大圆的极点，该大圆的极点必须以 *azim* 方位角经过设定的点

    - **s** 相加

    - **r**\ *par* 向量旋转，*par* 对二维笛卡尔数据表示旋转角度，对三维向量，则为 *lon/lat/angle*
      中的角度

    - **R** 通过输入的文件指定旋转的角度

    - **t**\[args] *args* 表示 *azimuth*/*distance*\ [*unit*] ；给定距离 *distance* 和
      方位角 *azimuth* 计算其对应方位角上的点，同时可以追加单位，默认距离单位为 m。如果
      不指定距离和方位角，则 GMT 默认从文件读取方位角和距离

    - **x** 计算两个向量的叉乘

    不设置 |-T| 选项，则不实施转换，对于 **-Tt** ，不设置 **-je** 时，使用大圆计算，设置时则使用
    大地线/测地线计算（即大地测量学中的大地主题正算）

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_


示例
----

确定 :file:`ship_15.txt` 文件中所有点的平均位置，并计算该点 95% 置信椭圆 ::

    gmt vector @ship_15.txt -Am -fg

计算 :file:`points.txt` 中的点与 133/34 点的球面夹角 ::

    gmt vector points.txt -S133/34 -TD -fg > angles.txt

将相同的文件以 133/34 为极点旋转 35 度，并输出笛卡尔坐标 ::

    gmt vector points.txt -Tr133/34/35 -Co -fg > reconstructed.txt

使用文件 :file:`rot.txt` 给出的角度将 65/33 旋转对应的角度 ::

    gmt vector rots.txt -TR -S64/33 -fg > reconstructed.txt

计算两个笛卡尔向量 0.5/1/2 和 1/0/0.4 之间的叉乘 ::

    gmt vector -A0.5/1/2 -Tx -S1/0/0.4 -N -C > cross.txt

旋转二维向量 r = 2，theta = 35，旋转角度为 120 度 ::

    gmt vector -A2/35 -Tr120 > rotated.txt

确定连接 123/35 和 -155/-30 的大圆的中点 ::

    gmt vector -A123/35 -S-155/-30 -Tb -fg > midpoint.txt

确定 :file:`points.txt` 中点的平均位置，并确定其 99% 的置信椭圆 ::

    gmt vector points.txt -Am99 -fg > centroid.txt

寻找以 105 度方位角通过点 -30/60 的大圆对应的极点 ::

    gmt vector -A-30/60 -Tp105 -fg > pole.txt

将地理坐标文件 :file:`points.txt` 中的所有位置在球面上以东北方向平移 65 km ::

    gmt vector points -Tt45/65k -fg > shifted.txt

确定距离 (8E,50N) 23 海里 310 度方位角方向上的点，距离使用大地线/测地线长度衡量 ::

    echo 8 50 | gmt vector -Tt310/23n -je

旋转
----

关于板块构造重建中的更高级的三维旋转，参见 Spotter 相关模块

相关模块
--------

:doc:`project`, :doc:`mapproject`
