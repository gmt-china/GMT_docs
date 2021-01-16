.. index:: ! grdfill
.. include:: common_SYN_OPTs.rst_

grdfill
=======

:官方文档: :doc:`gmt:grdfill`
:简介:

**grdfill** 模块读入一个文件数据，并向数据中的“洞”填充数据。
“洞”通常指值为NaN的节点，但用户也可以使用其它准则指定“洞”。

语法
----

**gmt grdfill** *ingrid*
|-A|\ *mode*\ [*arg*]
|-G|\ *outgrid*
[ |SYN_OPT-R| ]
[ |-L|\ [**p**] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必须选项
--------

*ingrid*
    输入网格文件

.. _-A:

**-A**\ *mode*\ [*arg*]
    填充“洞”所使用的算法

    目前支持两种算法：

    - **c**\ *value* 使用某个常数填充“洞”
    - **n**\ [*radius*] 使用最近的非NaN值填充“洞”，默认的搜索半径为
      半径默认取 :math:`r^2 = \sqrt{X^2 + Y^2}`\ ，其中 X 和 Y
      分别是X方向和Y方向的网格数目。也可以指定 *radius* 为搜索半径
      （单位是节点数）。

.. _-G:

**-G**\ *outgrid*
    输出网格文件

可选选项
--------

.. _-N:

**-N**\ [*nodata*]
    所有值等于 *nodata* 的节点都被认为为“hole”，默认值为NaN

.. include:: explain_-R.rst_
..

   该选项定义了要处理了子区域范围。

.. _-L:

**-L**\ [**p**]
    不填充“洞”，仅列出每个“洞”所处的子区域的范围

    **-G** 选项会被忽略。\ **-Lp** 表示输出每个子区域对应的闭合多边形。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

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
