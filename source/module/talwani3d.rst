.. index:: ! talwani3d
.. include:: common_SYN_OPTs.rst_

talwani3d
=========

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/talwani3d`
:简介: 使用 Talwani 方法计算三维实体形成的位异常

**talwani3d** 读取一个多段表文件（或标准输入）。该文件包含一个三维实体在不同的
高度 *z-level* 下的轮廓，每段均代表一个轮廓。每段的头部信息必须包括高度
*z-level* 和该高度处的密度 *desity* 这两个参数。（密度可以被 |-D| 选项设置的
密度常数覆盖）。可通过设置 |-R| 和 |-I| 确定网格，计算位于该格网的异常，
或者使用 |-N| 计算点上的异常值。计算的异常可包括，自由空气重力异常，
垂直重力梯度异常或者大地水准面异常。同时可以使用选项控制轴的单位和方向。

语法
----

**gmt talwani3d** [ *table* ]
[ |-A| ]
[ |-D|\ *density* ] ]
[ |-F|\ **f**\|\ **n**\ [*lat*]\|\ **v** ]
[ |-G|\ *outfile* ]
[ |SYN_OPT-I| ]
[ |-M|\ [**h**]\ [**v**] ]
[ |-N|\ *trackfile* ]
[ |SYN_OPT-R| ]
[ |-Z|\ *level*\|\ *obsgrid* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    该输入文件用来描述三维实体的水平横截面轮廓。如果多边形没有闭合，GMT 将自动闭合
    并删除重复的多边形顶点。每段的头部信息中必须包含高度（海洋中为深度）和相对密度
    参数，单位为 kg/m^3 或 g/cm^3，见 |-D| 选项。如果不指定文件，就从标准输入中
    读取数据。

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_

可选选项
--------

.. _-A:

**-A**
    设置 *z* 轴向上为正方向 [默认朝下为正]

.. _-D:

**-D**\ *density*
    设置一个固定的相对密度 *density* ，该设置将覆盖文件中的密度设置，单位
    为 kg/m^3 或 g/cm^3

.. _-F:

**-F**\ **f**\|\ **n**\ [*lat*]\|\ **v**
    指定要计算哪种异常。

    - **f** 自由空气重力异常 [默认]

    - **n** 大地水准面异常，可以在后面追加平均纬度 *lat* 以计算正常重力，
      默认正常重力为格网最中央位置（如果使用了 |-N| 为测线的中间）

    - **v** 垂直梯度重力异常

.. _-G:

**-G**\ *outfile*
    输出文件名。如果要计算的位置为一个网格，则该选项为必选选项，*outfile*
    为输出网格文件名。如果已经设置了 |-N| ，即计算测线处的异常，则可以使用
    **-G** 指定输出文件也可以输出到标准输出

.. _-M:

**-M**\ [**h**]\ [**v**]
    设置距离单位。**h** 表明水平距离单位为 km [m]。**z** 表明垂直距离单位为
    km [m]

.. _-N:

**-N**\ *trackfile*
    设置计算异常值的点的位置。如果输入文件中包含 3 列，就把最后一列作为观测
    高度，该高度可以被 |-Z| 选项覆盖

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ *level*\|\ *obsgrid*
    设置观测水准面常数 *level* ，默认为 0。可以设置为常数 *level* 或者网格
    *obsgrid* ，其中的每个值均为单独的 *level* 。如果设置为网格，输出结果也
    对应设置的网格。

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

计算某个三维实体（已形成高度轮廓文件 :file:`body3d.txt` ）在网格上的自动空气
重力异常，相对密度设置为 1700 kg/m^3，水平距离的单位为 km，垂直距离单位为 m
::

    gmt talwani3d -R-200/200/-200/200 -I2 -Mh -G3dgrav.nc body3d.txt -D1700 -Ff

另外，计算该实体在测线 :crossing.txt: 上形成的垂直重力梯度异常 ::

    gmt talwani3d -Ncrossing.txt -Mh body3d.txt -D1700 -Fv > vgg_crossing.txt

最后，计算该实体在该测线位置造成的大地水准面异常（平均纬度为 30S），输出结果到
:file:`n_crossing.txt` ::

    gmt talwani3d -Ncrossing.txt -Mh body3d.txt -D1700 -Fn-30 -Gn_crossing.txt

参考文献
--------

Kim, S.-S., and P. Wessel, 2016, New analytic solutions for modeling vertical
gravity gradient anomalies, *Geochem. Geophys. Geosyst., 17*,
`https://doi.org/10.1002/2016GC006263 <https://doi.org/10.1002/2016GC006263>`_.

Talwani, M., and M. Ewing, 1960, Rapid computation of gravitational attraction of
three-dimensional bodies of arbitrary shape, *Geophysics, 25*, 203-225.

相关模块
--------

:doc:`talwani2d`,
:doc:`grdmath`,
:doc:`gravfft`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`
