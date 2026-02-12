.. index:: ! talwani2d
.. include:: common_SYN_OPTs.rst_

talwani2d
=========

:贡献者: |周茂|
:最近更新日期: 2022-06-21

----

:官方文档: :doc:`gmt:supplements/potential/talwani2d`
:简介: 使用 Talwani 方法计算二维实体形成的位异常

**talwani2d** 读取一个多段表文件（或标准输入）。该文件包含一个或多个二维实体
的横截面，横截面为多边形。每段的头部信息中必须包含密度参数：*density*，为该
实体的密度（单个实体的密度可以被 |-D| 选项设置的密度常数覆盖）。GMT 可通过
设置 |-T| 计算位于某等距格网的异常，或者使用 |-N| 计算点上的异常值。
计算的异常可包括，自由空气重力异常，垂直重力梯度异常或者大地水准面异常。同时
可以使用选项控制轴的单位和方向。

语法
----

**gmt talwani2d** [ *table* ]
[ |-A| ] [ |-D|\ *density* ] ]
[ |-F|\ **f**\|\ **n**\ [*lat*]\|\ **v** ]
[ |-M|\ [**h**]\ [**v**] ]
[ |-N|\ *trackfile* ]
[ |-T|\ *min*\ /*max*\ /\ *inc*\ [**+i**\|\ **n**]\ \|\ *file*\|\ *list* ]
[ |-Z|\ *level*\ [*ymin*\ /*ymax*] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]

必选选项
--------

*table*
    一个或者多个 ASCII 文件，用来描述一个或者多个实体的横截面多边形。如果
    多边形没有闭合，GMT 讲自动闭合并删除重复的多边形顶点。每段的头部信息中
    必须包含密度参数，单位为 kg/m^3 或 g/cm^3，见 |-D| 选项。如果不指定
    文件，就从标准输入中读取数据。

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
      默认为 45

    - **v** 垂直梯度重力异常

.. _-M:

**-M**\ [**h**]\ [**v**]
    设置距离单位。**h** 表明水平距离单位为 km [m]。**z** 表明垂直距离单位为
    km [m]

.. _-N:

**-N**\ *trackfile*
    设置计算异常值的点的位置。当使用该选项时，禁用 **-T** 选项。计算结果将输
    出到标准输出。

.. _-T:

**-T**\ *min*\ /*max*\ /\ *inc*\ [**+i**\|\ **n**]\ \|\ *file*\|\ *list*
    指定一个等距的网格，在该网格计算异常值。见 `生成一维数组`_

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ *level*\ [*ymin*\ /*ymax*]
    设置水准面常数 *level* ，默认为 0。对于重力异常 **-Ff** ，可以追加 2.5 维
    实体的限制范围。

.. include:: explain_-bi.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_core.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

.. include:: explain_array.rst_

示例
----

计算 2-D 实体在一个等距剖面形成的重力异常，其横截面文件为 :file:`body2d.txt`
，相对密度为 1700 km/m^3 （该相对密度为地壳平均密度和海水密度之差），
所有距离的单位设置为常数::

    gmt talwani2d -T-200/200/2 body2d.txt -D1700 -Ff > 2dgrav.txt

使用同样的实体，计算其在给定 :file:`crossing.txt` 测线上的垂直重力梯度异常::

    gmt talwani2d -Ncrossing.txt body2d.txt -D1700 -Fv > vgg_crossing.txt

使用同样的实体，计算大地水准面异常，平均纬度设置为 60N ::

    gmt talwani2d -Ncrossing.txt body2d.txt -D1700 -Fn60 > n_crossing.txt

注意事项
--------

The 2-D geoid anomaly is a logarithmic potential and thus has no natural reference
level. We simply remove the most negative (if density contrast is positive) or
positive (if density contrast is negative) computed value from all values, rendering
the entire anomaly positive (or negative). You can use :doc:`gmtmath` to change the
zero level to suit your needs

参考文献
--------

Rasmussen, R., and L. B. Pedersen (1979), End corrections in potential field modeling,
*Geophys. Prospect., 27*, 749-760.

Chapman, M. E., 1979, Techniques for interpretation of geoid anomalies,
*J. Geophys. Res., 84(B8)*, 3793-3801.

Kim, S.-S., and P. Wessel, 2016, New analytic solutions for modeling vertical
gravity gradient anomalies, *Geochem. Geophys. Geosyst., 17*,
`https://doi.org/10.1002/2016GC006263 <https://doi.org/10.1002/2016GC006263>`_.

Talwani, M., J. L. Worzel, and M. Landisman, 1959, Rapid gravity computations for
two-dimensional bodies with application to the Mendocino submarine fracture zone,
*J. Geophys. Res., 64*, 49-59.

相关模块
--------

:doc:`talwani3d`,
:doc:`gravfft`,
:doc:`gmtgravmag3d`,
:doc:`grdgravmag3d`

