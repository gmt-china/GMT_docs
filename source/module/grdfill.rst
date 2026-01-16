:author: 田冬冬, 陈箫翰
:date: 2026-01-01

.. index:: ! grdfill
.. program:: grdfill

grdfill
=======

:官方文档: :doc:`gmt:grdfill`
:简介: 对网格文件中的空洞进行插值

**grdfill** 模块读入一个文件数据，并向数据中的“洞”填充数据。
“洞”通常指值为 NaN 的节点，但用户也可以使用 :option:`-N` 定义“洞”。有多种不同的算法可用于替换空洞值。
**注意**：必须提供 :option:`-A` 或 :option:`-L` 其中之一。如果未发现空洞，将输出原始未更改的网格文件。

语法
----

**gmt grdfill**
*ingrid*
[ :option:`-A`\ **c**\|\ **g**\|\ **n**\|\ **s**\ [*arg*]  ]
[ :option:`-G`\ *outgrid* ]
[ :option:`-L`\ [**p**] ]
[ :option:`-N`\ *value* ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-f`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

可选选项
--------

.. option:: -A

**-A**\ **c**\|\ **g**\|\ **n**\|\ **s**\ [*arg*]
    通过附加以下指令之一来指定要使用的空洞填充算法：

    - **c**：选择常数填充（并附加常数填充值 *value*）。
    - **g**：在构成空洞的节点处对（可能更粗略的）网格 *arg* 进行采样。
    - **n**：使用最近的非 NaN 值填充“洞”，默认的搜索半径为 :math:`r = \sqrt{n^2 + m^2}` ，其中 (*n,m*) 分别是X方向和Y方向的网格数目。
      也可以指定 *radius* 为搜索半径（单位是节点数）。
    - **s**：选择双三次样条插值（可附加张力参数 *tension* [默认无张力]）。

.. include:: explain_grd_out.rst_

.. option:: -L

**-L**\ [**p**]
    不填充“洞”，仅列出每个“洞”所处的子区域的范围。
    :option:`-G` 选项会被忽略。**-Lp** 表示输出每个子区域对应的闭合多边形。

.. option:: -N

**-N**\ [*nodata*]
    所有值等于 *nodata* 的节点都被认为为“hole”，默认值为 NaN 。

.. include:: explain_-R.rst_
..

   该选项定义了要处理的子区域范围。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

.. include:: explain_grd_coord.rst_

示例
----

检测网格文件中所有包含NaN的区域，并列出这些矩形区域的边界坐标::

    gmt grdfill data.grd -L > wesn_listing.txt

检测网格文件中所有包含NaN的区域，并以多段文件的形式输出这些矩形区域对应的闭合多边形::

    gmt grdfill data.grd -Lp > NaN_regions.txt

将网格文件中所有NaN值替换为999.0::

    gmt grdfill data.grd -Ac999 -Gno_NaNs_data.grd

将网格文件中所有NaN值用最近的非NaN值替代::

    gmt grdfill data.grd -An -Gno_NaNs_NN_data.grd

相关模块
--------

:doc:`grdcut`,
:doc:`grdclip`,
:doc:`grdedit`,
:doc:`grdinfo`
