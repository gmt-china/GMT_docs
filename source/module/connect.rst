:author: 田冬冬, 陈箫翰
:date: 2025-12-30

.. index:: ! connect
.. program:: connect
.. include:: common_SYN_OPTs.rst_

connect
==========

:官方文档: :doc:`gmt:gmtconnect`
:简介: 将端点接近的线段连接起来

该命令会读入一个或多个多段数据，并检查所有线段的两个端点。若某对端点完全相同
或者二者的距离在可容忍的范围内，则将两段线段连接成一条线段。该进程会一直重复，
直到剩余的端点均不在可容忍的范围内。最终连接得到的线段会被写到终端或特定的
输出文件中。

若不清楚该如何确定可容忍范围值，可以使用 :option:`-L` 选项，获得所有端点之间的距离的
列表，通过分析该列表来得到合适的值。

语法
----

**gmt connect**
[ *table* ]
[ :option:`-C`\ [*closed*] ]
[ :option:`-D`\ [*template*] ]
[ :option:`-L`\ [*linkfile*] ]
[ :option:`-Q`\ [*template*] ]
[ :option:`-T`\ [*cutoff*\ [**+s**\ *sdist*]] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-a`\ *flags* ]
[ :option:`-b`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ |SYN_OPT--| ]

|No-spaces|

输入数据
------------------

.. include:: explain_intables.rst_

可选选项
--------

.. option:: -C

**-C**\ [*closed*]
    将所有闭合多边形写到文件 *closed* （默认文件名为 ``gmtconnect_closed.txt`` ）i
    中并将其他数据段写到标准输出。

    使用该选项不会对线段做连接。

.. option:: -D

**-D**\ [*template*]
    对于多段数据文件，将每段数据分别输出到不同的数据文件中。

    *template* 是文件名的模板，该模板中必须包含一个整型参数的格式，比如
    ``%d`` 或 ``%08d`` ，也可以在整型参数格式前加上字符参数格式 ``%c`` ，实际
    输出时会被C或O代替，分别表示closed和open。

    默认的模板为 ``gmtconnect_segment_%d.txt`` 。

.. option:: -L

**-L**\ [*linkfile*]
    将连接信息写到指定的文件中，默认文件名为 ``gmtconnect_link.txt`` 。

    对于每段数据而言，会写入原始的数据段ID；对于线段的起始点和终点而言，会报告
    离得最近的线段的ID，以及两个线段端点之间的距离。

.. option:: -Q

**-Q**\ [*template*]
    与 :option:`-D` 结合使用，写入一个包含各个输出文件名列表的文件。
    可以为各个文件名附加一个文件名模板；该模板 **可能** 包含一个 C 语言格式说明符，
    用于格式化一个字符（分别代表闭合或打开的 C 或 O）。[默认值为 gmtconnect_list.txt]。

.. option:: -T

**-T**\ [*cutoff*\ [**+s**\ *sdist*]]
    指定以数据坐标为单位的分离容差 [0]；对于地理数据，请附加 :doc:`距离单位 </basis/unit>` 。
    如果两条线的端点距离小于 *cutoff*，则它们将被合并。附加 **+s**\ *sdist* 将增加一个额外约束：
    只有在第二短的连接距离超过 *sdist* 时，才会建立连接。后者的距离必须使用与 *cutoff* 相同的单位。
    如果 :option:`-T` 没有参数，将关闭每个线段或多边形，而 *不考虑* 该段起点和终点之间的间隙距离。

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_precision.rst_

示例
----

.. include:: explain_example.rst_

将线段文件 segment_*.txt（其笛卡尔坐标单位为厘米）尽可能地合并为最少的完整线条，假设端点的数字化误差最高可达 0.1 毫米::

```
gmt connect segment_*.txt -T0.1 > new_segments.txt

```

将多段文件 my_lines.txt（其坐标为 *经度, 纬度*）中的线段尽可能地合并为最少的完整线条，
假设端点数字化误差最高可达 150 米，并将完整的线段写入名为 Map_segment_0001.txt、Map_segment_0002.txt 等的独立文件中::

```
gmt connect my_lines.txt -T150e -DMap_segment_%04d.txt

```

Bugs
--------

如果线条仅包含单个点，则线条连接功能将无法工作。
但是 **connect** 会正确地将该点添加到最近的线段中。
对新的线条集合再次运行 **connect**，最终将连接所有满足 :option:`-T` 给定标准的线条。

相关模块
--------

:doc:`simplify`,
:doc:`spatial`,
:doc:`mapproject`