:author: 朱邓达
:date: 2025-09-29

.. index:: ! grdinterpolate
.. program:: grdinterpolate

grdinterpolate
================

:官方文档: :doc:`gmt:grdinterpolate`
:简介: 从一个 3D 网格 (cube) 或堆叠的一系列 2D 网格 (layer) 中采样一个 3D 网格，或一系列 2D 网格，或 1D 序列。

**grdinterpolate** 读取一个 netCDF 格式的 3D 网格（以下称之为 cube ）或一系列 2D 网格层
（以下称每个 2D 网格层为 layer，按顺序堆叠形成第三个维度），
沿着第三个维度（以下称之为 level ）对一个或多个 level 做插值。
要求 cube 的数据维度包含两个共有的 *x* 和 *y* 维度，第三个维度通常为距离或时间。
输出的插值结果可以保存为一个 cube 或者一系列 layer。
或者，可以在一个或多个任意点位 (*x/y*) 沿着 level 轴插值 (\ :option:`-S`\ ) ，
输出的表数据包含一个或多个 level 系列；也可以沿着任意垂直切片 (\ :option:`-E`\ ) 做插值，
输出为 2D 网格形式。

语法
------

**gmt grdinterpolate**
*cube* | *grd1 grd2 ...*
:option:`-G`\ *outfile*
[ :option:`-D`\ [**+x**\ *xname*][**+y**\ *yname*][**+z**\ *zname*][**+v**\ *vname*][**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*][**+t**\ *title*][**+r**\ *remark*] ]
[ :option:`-E`\ *line* ]
[ :option:`-F`\ **a**\|\ **c**\|\ **e**\|\ **l**\|\ **n**\|\ **s**\ *p*\ [**+d1**\|\ **2**] ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ *x/y*\|\ *pointfile*\ [**+h**\ *header*] ]
[ :option:`-T`\ [*min/max*\ /]\ *inc*\ [**+i**\|\ **n**] \|\ :option:`-T`\ *file*\|\ *list* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ [*levels*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-bo`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-g`\ *gaps* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-q`\ *flags* ]
[ :option:`-s`\ *flags* ]
[ :option:`-:`\ [**i**\|\ **o**] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
-----------

*cube* | *grd1 grd2 ...*
    指定 netCDF 格式的 3D 输入网格。或者使用 :option:`-Z` 时，此处可指定一系列 2D 网格层 (layer)。

必须选项
------------------

.. option:: -G

**-G**\ *outfile*
    输出的 cube 插值结果。如果通过 :option:`-T` 仅指定单一 level，则退化为常规的 2D 网格。
    如果 *outfile* 包含 C 语言浮点数格式 (e.g., layer_%6.6f.grd)，
    则插值结果输出为一系列包含每个 level 的 2D 网格 (layer)。
    使用 :option:`-S` 则插值结果输出为 ASCII 格式的表数据。

可选选项
------------------

.. include:: explain_-D_cap.rst_

.. include:: explain_lines.rst_

.. include:: explain_interpolant.rst_

.. include:: explain_-R.rst_

.. option:: -S

**-S**\ *x/y*\|\ *pointfile*\ [**+h**\ *header*]
    在给定点位 (*x/y*) 或 *pointfile* 文件中的多个点位处沿 level 轴插值，输出空间或时间序列。
    如果需要由起点和终点或类似点定义的一系列点位，可以首先使用 :doc:`project` 制作这样的点位文件。
    默认将采样 cube 的每个 level。使用 :option:`-T` 可自定义 level。
    在输出的插值结果中，level 值将插入点位文件的第 3 列，后跟其它输入列，最后一列为每个 level 对应的采样值。
    加上 **+h** 可在输出的每段序列段头后增加头段注释 *header* 。
    在输出时，输入的每个点位的尾随文本将作为每个点位输出序列的段头。
    默认情况下，表数据输出到标准输出。使用 :option:`-G` 可指定输出文件名。
    或者如果希望每个点位的序列输出到单独文件，可在 :option:`-G` 指定的文件名中包含 C 语言的整数格式 (e.g., %d)，
    此时将根据点数创建单独的输出文件。

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+a**][**+i**\|\ **n**][**+u**] \| [**-T**\ *file*\|\ *list*]
    定义要等距采样的 level 范围（从 *min* 到 *max* ）和步长 *inc*
    （默认使用输入 cube 的每个 level ）。 具体详见 `生成一维数组`_ 。

    **注：**

    + 如果使用了 :option:`-Z` ，且 :option:`-E`\ ，\ :option:`-S` 和 :option:`-T` 均未使用，则相当于将一系列 layer 组合成一个 cube 文件。
    + 对于 :option:`-E` 和 :option:`-S` ，可仅设置 :option:`-T`\ *min/max* 来限制 level 范围，而对原有的 level 之间不做插值。
    + 如果 :option:`-E`\ ，\ :option:`-S` 和 :option:`-T` 均未使用，则将输入的 cube 拆分，输出为一系列的 layer，
      这要求 :option:`-G` 文件名中包含 C 语言浮点数格式，可使用 :option:`-R` 指定范围。

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**\ [*levels*]
    读取命令行中传入的所有 2D 网格作为一个 cube 的每个 layer（默认读取一个 cube 文件）。
    可指定 *levels* 来控制这些 2D 网格如何组合成一个 cube，即为这些 2D 网格分配其所在level。
    *levels* 的设置方式和 :option:`-T` 一致，若不设置则默认 level 为从 0 开始的整数。

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-n.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_array.rst_

文件顺序
-------------

如果用户在命令行提供一系列的 2D 网格，并使用 :option:`-Z` 分配各自的 level，
则用户必须确保输入的 2D 网格顺序和 :option:`-Z` 分配的 level 顺序相匹配。
除非文件名是按照词典顺序排列，否则应谨慎使用通配符来列举所有网格 (e.g., \*.nc)。

时间坐标
--------

GMT 可以识别 netCDF 网格文件中的时间坐标。网格文件中变量的 **unit** 属性会被解析以
确定网格文件中时间坐标的起算点和单位。这些时间坐标值会被进一步根据
:term:`TIME_UNIT` 和 :term:`TIME_EPOCH`
转换为 GMT 内部时间值。输出时，默认以相对时间的形式输出，也可以使用 :doc:`/option/f`
指定以绝对时间方式输出。

创建序列
---------

:option:`-S` 选项涉及表格的读取和输出，因此 **grdinterpolate**
模块也可以使用和表格输入输出相关的标准选项，例如
:doc:`/option/binary` ，:doc:`/option/io` 等。
由于使用 :option:`-S` 提供的点位坐标不要求正好位于网格节点，
本模块内部会使用 :doc:`grdtrack` 模块对每个layer做采样，
故 :doc:`/option/n` 也可使用。

示例
------

从 cube 文件 `temperature.nc` 中使用三次样条插值提取一个 level=3400 的新 layer::

    gmt grdinterpolate temperature.nc -T3400 -Fc -Gtemp_3400.nc

从一系列的 2D 网格文件 `layers_*.nc` 中使用线性插值提取一个 level=3400 的新 layer，
其中每个网格文件对应的 level 值按照 `z.txt` 文件分配::

    gmt grdinterpolate layers_*.nc -Zz.txt -T3400 -Fl -Gtemp_3400.nc

从 cube 文件 `temperature.nc` 中使用 Akima 样条对所有 level 重新采样，输出一个新 cube ，
其中新 level 从 1500 到 2500，间隔 50::

    gmt grdinterpolate temperature.nc -T1500/2500/50 -Gtemperature_1500_2500.nc -Fa

与上面相同，但是每个 level 输出为一个单独的 2D 网格::

    gmt grdinterpolate temperature.nc -T1500/2500/50 -Gtemperature_%4.0f.nc -Fa

从一系列的 2D 网格文件 `deformation_*.nc` 提取出一个点位的时间序列（此处 level 为时间），
其中每个网格文件对应的时间点按照 `dates.txt` 文件分配，在输出序列的段头添加 “Some like it hot”::

    gmt grdinterpolate deformation_*.nc -Zdates.txt -S115W/33N+h"Some like it hot" > record.txt

从 cube 文件 `S362ANI_kmps.nc` 中提取穿过夏威夷热点的垂直切片，采样 vs（各向同性剪切波速度），
测线起始点位于同一纬度，测线距离以经度度数表示::

    gmt grdinterpolate S362ANI_kmps.nc?vs -E180/20/220/20+i1d+g+p -T25/500/25 -Gslice.nc


相关模块
--------
:doc:`grdedit`,
:doc:`grdcut`,
:doc:`project`
