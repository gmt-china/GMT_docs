:author: 田冬冬, 陈箫翰
:date: 2026-01-02

.. index:: ! grdproject
.. program:: grdproject

grdproject
==========

:官方文档: :doc:`gmt:grdproject`
:简介: 对网格数据做地图变换和逆变换

**grdproject** 根据是否设置了 :option:`-I` 选项来执行不同的操作。
如果已设置，它将通过在新节点处对表面进行重采样，将网格数据集从矩形坐标系转换为地理坐标系。
如果未设置，它将把地理网格数据集投影到矩形网格上。
为了获取每个新节点的值，其位置会被反向投影回输入网格，然后在周围的输入网格值之间进行插值。
默认使用双三次插值。通过同时对输入网格节点进行正向投影来避免混叠。
如果两个或更多节点被投影到同一个新节点上，它们的平均值将在新节点值的计算中起主导作用。
插值和混叠由 :option:`-n` 选项控制。可以通过指定网格间距、节点数量或分辨率等方式确定新节点间距。
未受输入数据约束的节点被设置为 NaN。

:option:`-R` 选项可用于选择比网格文件范围更大或更小的地图区域。

语法
--------

**gmt grdproject**
*ingrid*
:option:`-G`\ *outgrid*
:option:`-J`\ *parameters*
[ :option:`-C`\ [*dx/dy*] ]
[ :option:`-D`\ *xinc*\ [**+e**\|\ **n**][/\ *yinc*\ [**+e**\|\ **n**]] ]
[ :option:`-E`\ *dpi* ]
[ :option:`-F`\ [**c**\|\ **i**\|\ **p**\|\ **e**\|\ **f**\|\ **k**\|\ **M**\|\ **n**\|\ **u**] ]
[ :option:`-I` ]
[ :option:`-M`\ **c**\|\ **i**\|\ **p** ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-j`\ *flags* ]
[ :option:`-n`\ *flags* ]
[ :option:`-r`\ *reg* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

必须选项
--------

.. include:: explain_grd_out.rst_

.. include:: explain_-J.rst_

可选选项
--------

.. option:: -C

**-C**\ [*dx/dy*]
    让投影后的坐标相对于投影中心 [默认相对于左下角]。
    可以添加投影后坐标的偏移量 *dx/dy* [默认无偏移]。

.. option:: -D

**-D**\ *xinc*\ [**+e**\|\ **n**][/\ *yinc*\ [**+e**\|\ **n**]]
    设置新网格的网格间距。如果既未设置 :option:`-D` 也未设置 :option:`-E`，则选择与输入节点数量相同的输出节点。

    - **地理（度）坐标**：附加 **m** 表示弧分，或 **s** 表示弧秒。
      如果改为附加单位 **e**、 **f**、 **k**、 **M**、 **n** 或 **u** 之一，
      则分别以米、英尺、千米、英里、海里或美制测绘英尺为单位，并将其转换为该区域中间纬度处的等效经度。
      如果给出了 *y_inc* 但设置为 0，则它将被重置为等于 *x_inc*。否则它将被转换为纬度。
    - **所有坐标**：如果附加了 **+e**，则相应的最大 *x* （东）或 *y* （北）可能会稍作调整以精确适应给定的间距
      [默认情况下，增量可能会稍作调整以适应给定的范围]。可以不指定间距，而是通过在提供的整数参数后附加 **+n** 来指定所需的节点数量。
      随后将根据配准方式、节点数量和范围重新计算间距。
    
    **注意**：如果使用了 :option:`-R`\ *grdfile*，则会继承网格间距和配准方式。使用 :option:`-D` 和 :option:`-r` 可重新设置。

.. option:: -E

**-E**\ *dpi*
    设置新网格的分辨率，即每英寸的点数。

.. option:: -F

**-F**\ [**c**\|\ **i**\|\ **p**\|\ **e**\|\ **f**\|\ **k**\|\ **M**\|\ **n**\|\ **u**]
    强制 1:1 比例缩放，即输出数据（或输入，参见 :option:`-I`）的单位是真实的投影长度，以米为单位 [**e**]。

    若要指定其他单位，请附加 **f** （英尺）、 **k** （千米）、 **M** （法定英里）、 **n** （海里）、 **u** （美制测绘英尺）、 **i** （英寸）、 **c** （厘米）或 **p** （磅）。
    如果不使用本选项，输出（或输入，参见 :option:`-I`）将采用由 :term:`PROJ_LENGTH_UNIT` 指定的单位（参见 :option:`-M`）。

.. option:: -I

**-I**
    逆变换，将矩形区域变换成地理区域。

.. option:: -M

**-Mc**\|\ **i**\|\ **p**
    指定投影后的投影度量单位，附加 **c**、 **i** 或 **p** 表示厘米、英寸或磅 [默认值由 :term:`PROJ_LENGTH_UNIT` 控制]。
    不能与 :option:`-F` 一起使用。

.. include:: explain_-R.rst_
..

    可以指定一个更小的 *w/e/s/n* 范围，从而仅投影网格文件的一个子集 [默认值为网格文件给出的范围]。

.. include:: explain_-V.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-n.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_help.rst_

示例
--------

将远程地理网格 @earth_relief_05m 的一部分转换为比例尺为每度 0.25 英寸、分辨率为 300 dpi 的像素配准墨卡托网格::

    gmt grdproject @earth_relief_05m -R20/50/12/25 -Jm0.25i -E300 -r -Getopo5_merc.nc -Mi

将文件 topo_tm.nc 反投影回地理网格。topo_tm.nc 中的坐标必须是使用相同的投影参数创建的::

    gmt grdproject topo_tm.nc -R-80/-70/20/40 -Jt-75/1:500000 -I -D5m -V -Gtopo.nc

将文件 topo_utm.nc（单位为 UTM 米）反投影回地理网格，指定以米为度量单位的一比一映射::

    gmt grdproject topo_utm.nc -R203/205/60/65 -Ju5/1:1 -I -Gtopo.nc -V

将文件 data.nc（单位为墨卡托米，中央经线为格林威治，东伪偏移为 -4，且基于 WGS-72 椭球体生成）反投影回地理网格，指定以米为度量单位的一比一映射::

    gmt grdproject data.nc -Jm/1:1 -I -F -C-4/0 -Gdata_geo.nc -V --PROJ_ELLIPSOID=WGS-72

输出区域问题
----------------

投影（矩形）数据集的边界不一定产生矩形的地理边界（墨卡托投影是一个例外）。在这些情况下，某些节点可能不受约束（会设置为 NaN）。
为了获得完整的网格，输入网格文件可能需要覆盖比研究区域更大的范围。

.. include:: explain_ellipsoidal.rst_

相关模块
----------------

:doc:`mapproject`
