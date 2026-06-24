.. index:: ! mask
.. include:: common_SYN_OPTs.rst_

mask
====

:官方文档: :doc:`gmt:mask`
:简介: 将没有数据的区域裁剪或者覆盖

**mask** 读取 (x,y,z) 形式的数据并判断哪些网格中哪些节点是可靠的。只有包含一个或者
多个数据的节点被认为是可靠的。另外，可以指定影响半径，在数据点半径内的所有节点都是
可靠的。同时还可对上述结果取反，即寻找不可靠的节点。在得到可靠/不可靠的节点后，该
模块将使用 |-T| 选项覆盖这些节点，或者使用轮廓创建多边形以剪除不感兴趣的区域。当
使用裁剪后，直到第二次该模块调用 |-C| 选项才可以关闭。

语法
----

**gmt mask** [ *table* ]
|SYN_OPT-I|
|-J|\ *parameters*
|SYN_OPT-R|
[ |SYN_OPT-B| ]
[ |-C| ]
[ |-D|\ *dumpfile* ]
[ |-F|\ [**l**\|\ **r**] ]
[ |-G|\ *fill* ]
[ |-Jz|\ \|\ **Z**\ *parameters* ]
[ |-L|\ *nodegrid*\ [**+i**\|\ **o**] ]
[ |-N| ]
[ |-Q|\ *cut* ]
[ |-S|\ *search\_radius* ]
[ |-T| ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-qi| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

.. include:: explain_-I.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. include:: explain_-B.rst_

.. _-C:

**-C**
    终结裁剪；使用该选项后不需要输入文件

.. _-D:

**-D**\ *dumpfile*
    将每个裁剪多边形的 (x,y) 坐标输出到 *dumpfile* 文件，不给定文件则输出到标准输出。
    该选项不进行绘图。如果 *dumpfile* 包含 C 语言格式的说明符（例如，%5d 或者 %05d）,
    多边形将被写入不同的文件，否则都写入到 *dumpfile* 文件中。**-Q** 选行可用来排除
    小多边形。

.. _-F:

**-F**\ [**l**\|\ **r**]
    设置裁剪多边形的方向，与 |-D| 选项同时使用。
    **-Fl** 为向左（逆时针）；**-Fr** 为向右（顺时针）。

.. _-G:

**-G**\ *fill*
    对裁剪多边形进行填充

.. _-L:

**-L**\ *nodegrid*\ [**+i**\|\ **o**]
    将计算过程中包含 1 和 0 的网格储存到 *nodegrid* ，1 和 0 分别为选定和不被选定的标记。
    **+o** 选项将无数据的节点转换为 NaN，**+i** 选项将有数据的节点转转为 NaN

.. _-N:

**-N**
    反转选择，即裁剪有数据覆盖的区域

.. _-Q:

**-Q**\ *cut*
    不输出少于 *cut* 点数的多边形，仅能和 |-D| 选项共同使用

.. _-S:

**-S**\ *search\_radius*
    设置影响半径。网格节点在数据的影响半径内，就被认为是可靠的，默认半径为 0，即
    只有数据落入的网格是可靠的，可在半径后追加单位

.. _-T:

**-T**
    绘制数据而不是多边形轮廓，使用 |-G| 选项可以用来设置其中的填充。不能和 |-D| 选项
    同时使用

.. include:: explain_-XY.rst_

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-qi.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_-t.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

假设数据的影响范围为 5 度，对其中影响的网格范围填充为黄色 ::

    gmt begin mask
    gmt math -T-90/90/10 -N2/1 0 = | gmt mask -Gyellow -I30m -R-75/75/-90/90 -JQ0/7i \
        -S5d -T -Bafg10 -BWSne+t"Mask for points with r = 5 degrees"
    gmt end show

使用裁剪多边形制作 mask，将其中没有控制数据的部分覆盖 ::

    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -JM10i -pdf mask

使用和上面的例子相同的数据，但这次将裁剪多边形保存到文件 :file:`all_pols.txt` ::

    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -Dall_pols.txt

类似第二个例子，但这次对数据覆盖的部分进行填充 ::

    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -JM10i -T -Gwhite -pdf mask

相关模块
--------

:doc:`grdmask`, :doc:`surface`,
:doc:`basemap`, :doc:`clip`
