.. index:: ! grdedit
.. include:: common_SYN_OPTs.rst_

grdedit
=======

:官方文档: :doc:`gmt:grdedit`
:简介: 修改网格文件的头段或内容

**grdedit** 模块具有如下功能：

- 从2D网格文件中读入头段信息，并使用命令行中的值替换头段信息
- 对全球地理网格文件沿着东西方向旋转
- 可以用 *x y z* 值替换网格文件中特定节点的值

语法
----

**gmt grdedit** *grid* [ |-A| ] [ |-C| ]
[ |-D|\ [**+x**\ *xname*][**+y**\ *yname*][**+z**\ *zname*][**+s**\ *scale*][**+o**\ *offset*][**+n**\ *invalid*][**+t**\ *title*][**+r**\ *remark*] ]
[ |-E|\ [**a**\|\ **h**\|\ **l**\|\ **r**\|\ **t**\|\ **v**] ]
[ |-G|\ *outgrid* ]
[ |-J|\ *parameters* ]
[ |-L|\ [**+n**\|\ **p**] ]
[ |-N|\ *table* ]
[ |SYN_OPT-R| ]
[ |-S| ] [ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必须选项
--------

*grid*
    要修改的2D网格文件

可选选项
--------

.. _-A:

**-A**
    如有必要，则对网格间隔做微调使得其与数据的范围相兼容。仅用于处理 GMT 3.1
    之前版本生成的网格文件。

.. _-C:

**-C**
    清除网格文件头段区中生成该网格所使用的命令历史

.. include:: explain_-D_cap.rst_

.. _-E:

**-E**\ [**a**\|\ **h**\|\ **l**\|\ **r**\|\ **t**\|\ **v**]
    对网格做变换。该选项与除 |-G| 外的其它选项不兼容

    - **-Ea** 旋转180度
    - **-Eh** 水平翻转网格（从左到右）
    - **-Ev** 垂直旋转网格（从上到下）
    - **-El** 逆时针将网格旋转90度
    - **-Er** 顺时针将网格旋转90度
    - **-Et** 对网格进行转置（想象成一个二维矩阵），默认使用该变换

    下图展示了不同变换的具体效果：

    .. gmtplot:: grdedit/grdedit_-E.sh
       :show-code: false

.. _-G:

**-G**\ *outgrid*
    默认情况下，**grdedit** 模块会直接修改并覆盖原始网格文件。
    使用该选项则将修改后的网格写到新的文件中。

.. include:: explain_-J.rst_
..

    使用 |-J| 选项则将地理相关信息以 CF-1 兼容的元数据形式（可被GDAL识别）保存
    到 netCDF 文件中。

.. _-L:

**-L**\ [**+n**\|\ **p**]
    调整地理网格文件的经度

    默认情况下会调整 *west* 和 *east* 使得 *west*>=-180 或 *east* <= 180。
    **+n** 则强制经度为负值，**+p** 则强制经度为正值。

.. _-N:

**-N**\ *table*
    从文件 *table* 中读入XYZ数据，并用这些XYZ数据替换网格中对应节点的值。

.. include:: explain_-R.rst_
..

    修改网格文件的范围。同时，网格间隔会做相应修改。

.. _-S:

**-S**
    将网格沿着经度范围整体偏移，使得其满足 |-R| 定义的新范围。仅用于全球地理网格数据。

    例如，原数据范围是 **0/360/-72/72**，现将数据整体偏移180度使得数据范围是
    **-180/180/-72/72**::

        gmt grdedit world.nc -R-180/180/-72/72 -S

.. _-T:

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

.. include:: explain_help.rst_

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
:doc:`grdinfo`
:doc:`xyz2grd`
