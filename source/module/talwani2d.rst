:author: 周茂
:date: 2026-01-12

.. index:: ! talwani2d
.. program:: talwani2d

talwani2d
=========

:官方文档: :doc:`gmt:supplements/potential/talwani2d`
:简介: 使用 Talwani 方法计算二维物体形成的位异常

**talwani2d** 读取一个多段表文件（或标准输入）。该文件包含一个或多个二维物体
的横截面，横截面为多边形。每段的头部信息中必须包含密度参数：*density*，为该
物体的密度（单个物体的密度可以被 :option:`-D` 选项设置的密度常数覆盖）。GMT 可通过
设置 :option:`-T` 计算位于某等距格网的异常，或者使用 :option:`-N` 计算点上的异常值。
计算的异常可包括，自由空气重力异常，垂直重力梯度异常或者大地水准面异常。同时
可以使用选项控制轴的单位和方向。

语法
----

**gmt talwani2d**
[ *table* ]
[ :option:`-A` ]
[ :option:`-D`\ *density* ]
[ :option:`-F`\ **f**\|\ **n**\ [*lat*]\|\ **v** ]
[ :option:`-M`\ [**h**]\ [**v**] ]
[ :option:`-N`\ *trackfile* ]
[ :option:`-T`\ *min*\ /*max*\ /\ *inc*\ [**+i**\|\ **n**]\ \|\ *file*\|\ *list* ]
[ :option:`-Z`\ *level*\ [*ymin*\ /*ymax*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-d`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-o`\ *flags* ]
[ :option:`-x`\ [[-]n] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*table*
    一个或者多个 ASCII 文件，用来描述一个或者多个物体的横截面多边形。如果
    多边形没有闭合，GMT 将自动闭合并删除重复的多边形顶点。每段的头部信息中
    必须包含密度参数，单位为 kg/m^3 或 g/cm^3，见 :option:`-D` 选项。如果不指定
    文件，就从标准输入中读取数据。

可选选项
--------

.. option:: -A

**-A**
    设置 *z* 轴向上为正方向 [默认朝下为正]

.. option:: -D

**-D**\ *density*
    设置一个固定的相对密度 *density* ，该设置将覆盖文件中的密度设置，单位
    为 kg/m^3 或 g/cm^3

.. option:: -F

**-F**\ **f**\|\ **n**\ [*lat*]\|\ **v**
    指定要计算哪种异常。

    - **f** 自由空气重力异常 [默认]

    - **n** 大地水准面异常，可以在后面追加平均纬度 *lat* 以计算正常重力，
      默认为 45

    - **v** 垂直梯度重力异常

.. option:: -M

**-M**\ [**h**]\ [**v**]
    设置距离单位。**h** 表明水平距离单位为 km [m]。**z** 表明垂直距离单位为
    km [m]

.. option:: -N

**-N**\ *trackfile*
    设置计算异常值的点的位置。当使用该选项时，禁用 :option:`-T` 选项。计算结果将输
    出到标准输出。

.. option:: -T

**-T**\ *min*\ /*max*\ /\ *inc*\ [**+i**\|\ **n**]\ \|\ *file*\|\ *list*
    指定一个等距的点列，在这些位置计算异常值。见 `生成一维数组`_

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**\ *level*\ [*ymin*\ /*ymax*]
    设置水准面常数 *level* ，默认为 0。对于重力异常 **-Ff** ，可以追加 2.5 维
    物体的限制范围。

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

计算 2-D 物体在一个等距剖面形成的重力异常，其横截面文件为 :file:`body2d.txt`
，相对密度为 1700 km/m^3 （该相对密度为地壳平均密度和海水密度之差），
所有距离的单位设置为米::

    gmt talwani2d -T-200/200/2 body2d.txt -D1700 -Ff > 2dgrav.txt

使用同样的物体，计算其在给定 :file:`crossing.txt` 测线上的垂直重力梯度异常::

    gmt talwani2d -Ncrossing.txt body2d.txt -D1700 -Fv > vgg_crossing.txt

使用同样的物体，计算大地水准面异常，平均纬度设置为 60N ::

    gmt talwani2d -Ncrossing.txt body2d.txt -D1700 -Fn60 > n_crossing.txt

注意事项
--------

二维大地水准面异常（geoid anomaly）属于对数位（logarithmic potential），因此没有天然的参考基准面。
我们只需从所有计算值中减去最小负值（如果密度对比为正）或最大正值（如果密度对比为负），从而使整个异常变为正值（或负值）。
您可以利用 :doc:`math` 根据需要更改零水平基准。

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
:doc:`gravmag3d`,
:doc:`grdgravmag3d`
