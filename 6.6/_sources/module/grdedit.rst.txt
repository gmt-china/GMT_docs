:author: 田冬冬, 陈箫翰
:date: 2026-01-01

.. index:: ! grdedit
.. program:: grdedit

grdedit
=======

:官方文档: :doc:`gmt:grdedit`
:简介: 修改网格文件的头段或内容

**grdedit** 模块具有如下功能：

- 从2D网格文件中读入头段信息，并使用命令行中的值替换头段信息
- 对全球地理网格文件沿着东西方向旋转
- 可以用 *x y z* 值替换网格文件中特定节点的值

**grdedit** 仅对包含网格文件头的文件进行操作。
**注意**：如果原始数据非常重要，则应使用 :option:`-G` 将修改后的网格保存到新文件中。

语法
----

**gmt grdedit** 
*ingrid*
[ :option:`-A` ] 
[ :option:`-C`\ **b**\|\ **c**\|\ **n**\|\ **p** ]
[ :option:`-D`\ [**+x**\ *xname*][**+y**\ *yname*][**+z**\ *zname*][**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*][**+t**\ *title*][**+r**\ *remark*] ]
[ :option:`-E`\ [**a**\|\ **e**\|\ **h**\|\ **l**\|\ **r**\|\ **t**\|\ **v**] ]
[ :option:`-G`\ *outgrid* ]
[ :option:`-J`\ *parameters* ]
[ :option:`-L`\ [**+n**\|\ **p**] ]
[ :option:`-N`\ *table* ]
[ :option:`-R`\ *region* ]
[ :option:`-S` ]
[ :option:`-T` ]
[ :option:`-V`\ [*level*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-w`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

可选选项
--------

.. option:: -A

**-A**
    必要时调整文件的 *x_inc* 和 *y_inc*，使其与其范围（或通过 :option:`-R` 设置的新范围）相兼容。
    旧版网格文件（即在 GMT 3.1 之前创建的文件）的 *x_inc* 和 *y_inc* 往往存在较大的偏差，需要进行调整。
    新版文件不存在类似问题。

.. option:: -C

**-C**\ **b**\|\ **c**\|\ **n**\|\ **p**
    通常输出网格会存储当前模块的命令行历史记录。使用 :option:`-C` 指定输出网格应包含哪些命令历史记录：
    
    - **b** 同时写入上一个模块和当前模块的命令历史记录
    - **c** 仅写入当前模块的命令历史记录
    - **n** 不保存任何历史记录 [默认]
    - **p** 仅保存之前的命令历史记录

.. include:: explain_-D_cap.rst_

.. option:: -E

**-E**\ [**a**\|\ **e**\|\ **h**\|\ **l**\|\ **r**\|\ **t**\|\ **v**]
    通过以下六种方式之一对网格做变换，对于 **l** \| **r** \| **t** 会交换 *x* 和 *y* 信息。
    该选项与除 :option:`-G` 外的其它选项不兼容。

    - **-Ea** 同时水平和垂直翻转网格（旋转180度）
    - **-Eh** 水平翻转网格（左右翻转）
    - **-Ev** 垂直翻转网格（上下翻转）
    - **-Ee** 交换 x（经度）和 y（纬度）
    - **-El** 逆时针将网格旋转90度
    - **-Er** 顺时针将网格旋转90度
    - **-Et** 对网格进行转置（想象成一个二维矩阵），默认使用该变换

    下图展示了不同变换的具体效果：

    .. gmtplot:: grdedit/grdedit_-E.sh
       :show-code: false

.. option:: -G

**-G**\ *outgrid*
    默认情况下，**grdedit** 模块会直接修改并覆盖原始网格文件。
    使用该选项则将修改后的网格写到新的文件中。

.. include:: explain_-J.rst_
..

    使用 :option:`-J` 选项则将地理相关信息以 CF-1 兼容的元数据形式（可被GDAL识别）保存
    到 netCDF 文件中。

.. option:: -L

**-L**\ [**+n**\|\ **p**]
    调整地理网格文件的经度

    默认情况下会调整 *west* 和 *east* 使得 *west*>=-180 或 *east* <= 180。
    **+n** 则强制经度为负值，**+p** 则强制经度为正值。

.. option:: -N

**-N**\ *table*
    从文件 *table* 中读入XYZ数据，并用这些XYZ数据替换网格中对应节点的值。

.. include:: explain_-R.rst_
..

    修改网格文件的范围，并在必要时调整 *x_inc* 和 *y_inc* 的值。
    **注意**：本选项不能用于选择输入网格的子区域，而是直接替换网格的范围。

.. option:: -S

**-S**
    将网格沿着经度范围整体偏移，使得其满足 :option:`-R` 定义的新范围。仅用于全球地理网格数据。

    例如，原数据范围是 **0/360/-72/72**，现将数据整体偏移180度使得数据范围是
    **-180/180/-72/72**::

        gmt grdedit world.nc -R-180/180/-72/72 -S

.. option:: -T

**-T**
    将一个网格线配准的文件变成像素配准的文件，或反之。

    使用该选项后，网格线配准的数据的范围将在四个方向上扩大半个网格间隔，
    像素点配置的数据的范围将在四个方向上缩小半个网格间隔。

    注意：修改网格配准方式会导致高频信息丢失，详情见 :doc:`/grid/registration`。

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-w.rst_

.. include:: explain_help.rst_

.. include:: explain_grd_coord.rst_

示例
----

假定数据文件data.nc的范围为300/310/10/30。下面的命令修改了其数据范围并修改了标题::

    gmt grdedit data.nc -R-60/-50/10/30 -D+t"Gravity Anomalies"

数据文件 world.nc 的范围为 0/360/-72/72，下面的命令对数据做了移动，使得数据范围为
-180/180/-72/72::

    gmt grdedit world.nc -R-180/180/-72/72 -S

GMT 4.1.3 之前的网格文件不包含足够的信息表明某个网格文件是地理网格。为了添加
这一信息，可以使用::

    gmt grdedit junk.nc -fg

将网格文件 oblique.nc 逆时针旋转90度，并输出到新文件::

    gmt grdedit oblique.nc -El -Goblique_rot.nc

为了确保文件 depths.nc 的经度始终为正值::

    gmt grdedit depths.nc -L+p

相关模块
--------

:doc:`grd2xyz`,
:doc:`grdfill`,
:doc:`grdinfo`,
:doc:`xyz2grd`
