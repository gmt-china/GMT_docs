.. index:: ! mgd77track
.. include:: common_SYN_OPTs.rst_

mgd77track
==========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77track`
:简介: 绘制 MGD77 测线轨迹

语法
----

**gmt mgd77track** *GEODAS-ids*
|SYN_OPT-R|
|-J|\ *parameters*
[ |-A|\ [**c**][*size*][**+i**\ *spacing*] ]
[ |SYN_OPT-B| ]
[ **-Da**\ *startdate* ]
[ |-D|\ **b**\ *stopdate* ]
[ |-F| ]
[ |-G|\ **d**\|\ **t**\|\ **n**\ *gap* ]
[ |-I|\ **a\|c\|m\|t** ]
[ |-L|\ *trackticks* ]
[ |-S|\ **a**\ *startdist* ]
[ |-S|\ **b**\ *stopdist* ]
[ |-T|\ **T**\|\ **t**\|\ **d**\ *ms*,\ *mc*,\ *mfs*,\ *mf*,\ *mfc* ]
[ |SYN_OPT-U| ]
[ |SYN_OPT-V| ]
[ |-W|\ [*pen*] ]
[ |SYN_OPT-X| ]
[ |SYN_OPT-Y| ]
[ |SYN_OPT-p| ]
[ |SYN_OPT-t| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

.. include:: explain_-J.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**\ [**c**][*size*][**+i**\ *spacing*]
    标注测线，追加 **c** 选项表示使用 cruise ID 进行标注，默认使用文件名前缀。
    *size* 为字体大小，单位为 points，字体由 :term:`FONT_LABEL` 控制。追加
    **+i**\ *spacing* 则在沿轨每隔一定距离/时间放置一个此标注，单位可以为 **k**
    (km)，**n** (nautical mile)，**d** (day) 或者 **h** (hour)

.. include:: explain_-B.rst_

.. _-D:

**-Da**\ *startdate*
    不绘制 *startdate* （yyyy-mm-dd\ **T**\ [hh:mm:ss]）时刻之前的数据，默认为第一天
**-Db**\ *stopdate*
    不绘制 *stopdate* （yyyy-mm-dd\ **T**\ [hh:mm:ss]）时刻之后的数据，默认为最后一天

.. _-F:

**-F**
    如果 MGD77+ 文件中存在 error flag，不应用这些 flag，默认情况下会应用

.. _-G:

**-G**\ **d**\|\ **t**\|\ **n**\ *gap*
    如果测线中两个点的距离超过 **d**\ *gap* (km) 或者时间超过 **t**\ *gap* (minutes)
    表示轨迹存在中断，不绘制连续的线。重复使用可分别设置时间和距离。**n**\ *N* 则表示
    每 N 个点绘制一个点，这对于减小图所占的空间很有必要，但是不能和 **d** 以及 **t**
    选项共用。

.. _-I:

**-I**\ **a\|c\|m\|t**
    忽略某些数据格式的文件。**a\|c\|m\|t** 分别表示忽略 MGD77 ASCII、MGD77+ NetCDF、
    MGD77T ASCII 、tab 分隔的普通文本文件。该选项可以重复使用以忽略多个格式

.. _-L:

**-L**\ *trackticks*
    在轨迹上放置时间或者距离标记。例如，**a**\ 500\ **ka**\ 24\ **ht**\ 6\ **h**
    表示每 500 km 标注，每 24 小时标注，每 500 km 和 6 小时绘制刻度线。时间和距离
    单位也可以是 **d** （天）和 **n** （nautical miles）。

.. _-S:

**-Sa**\ *startdist*
    不绘制从港口出发累积距离小于 *startdist* 米的数据，默认为 0，可追加单位：
    **k** 为 km，**M** 为 miles，**n** 为 nautical miles。
**-Sb**\ *stopdist*
    不绘制从港口出发累积距离大于 *stopdist* 米的数据，默认为整个测线长度，
    可追加单位：**k** 为 km，**M** 为 miles，**n** 为 nautical miles

.. _-T:

**-TT**\|\ **t**\|\ **d**\ *ms*,\ *mc*,\ *mfs*,\ *mf*,\ *mfc*
    控制三种标记的属性，**T** 为新一天的第一个时间标记，**t** 同一天的其他时间
    标记，**d** 为距离标记。对于其中的每个标记，可以指定 5 个由逗号分隔的属性，
    *markersize* ，*markercolor* ，*markerfontsize* ，*markerfont* 和 *markerfontcolor*
    。重复使用 **-T** 选项可设置不同的标记。

.. _-W:

**-W**\ [*pen*]
    设置绘制轨迹线的属性，默认 width = defaults，color = black，style = solid。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. include:: explain_-XY.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

本示例生成一个 70 W 到 20 E，40 S 到 20 N 内 01010007 测线轨迹的墨卡托地图，使用
0.1 inch/degree 的比例尺，轨迹 ID 标注大小为 10p，每 10 度标注边框，每 5 度绘制
网格线，每天和每 1000 km 标记时间和距离，每 6  小时和每 250 km 绘制刻度线，最终
生成 PDF ::

    gmt mgd77track 01010007 -R70W/20E/40S/20N -Jm0.1 -B10g5 -A10 \
               -La1da1000kf6hf250k -pdf map

参考
----

MGD77 (Marine Geophysical Data Exchange Format) 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77manage`,
:doc:`mgd77path`,
:doc:`mgd77sniffer`
