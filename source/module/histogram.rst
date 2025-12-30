:author: 田冬冬, 王亮
:date: 2022-05-05
.. index:: ! histogram
.. program:: histogram
.. include:: common_SYN_OPTs.rst_

histogram
=========

:官方文档: :doc:`gmt:histogram`
:简介: 统计并绘制直方图

**histogram** 模块会读取数据中的一列，对其进行统计，并绘制直方图或累积直方图。

语法
----

**gmt histogram** [ *table* ]
:option:`-J`\ **x**\|\ **X**\ *parameters*
:option:`-T`\ [*min/max*\ /]\ *inc*\ [**+n**] \|\ :option:`-T`\ *file*\|\ *list*
[ :option:`-A` ]
[ :option:`-B`\ [**p**\|\ **s**]\ *parameters* ]
[ :option:`-C`\ *cpt* ]
[ :option:`-D`\ [**+b**][**+f**\ *font*][**+o**\ *off*][**+r**] ]
[ :option:`-F` ]
[ :option:`-G`\ *fill* ]
[ :option:`-J`\ **z**\|\ **Z**\ *parameters* ]
[ :option:`-I`\ [**o**\|\ **O**] ]
[ :option:`-L`\ **l**\|\ **h**\|\ **b**] ]
[ :option:`-N`\ [*mode*][**+p**\ *pen*] ]
[ :option:`-Q`\ **r** ]
[ :option:`-R`\ *region* ]
[ :option:`-S` ]
[ :option:`-U`\ [*stamp*] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-W`\ *pen* ]
[ :option:`-X`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*xshift*] ]
[ :option:`-Y`\ [**a**\|\ **c**\|\ **f**\|\ **r**][*yshift*] ]
[ :option:`-Z`\ [*type*][**+w**] ]
[ :option:`-bi`\ *binary* ]
[ :option:`-di`\ *nodata*\ [**+c**\ *col*] ]
[ :option:`-e`\ *regexp* ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-i`\ *flags* ]
[ :option:`-p`\ *flags* ]
[ :option:`-qi`\ *flags* ]
[ :option:`-t`\ *transp* ]
[ :doc:`--PAR=value </conf/overview>` ]

必选选项
--------

.. option:: -J

**-J**\ **x**\|\ **X**\ *parameters*
    指定直方图的宽度和高度

.. option:: -T

**-T**\ [*min/max*\ /]\ *inc*\ [**+n**] \|\ **-T**\ *file*\|\ *list*
    指定统计直方

    有多种方式可以指定统计直方：

    - **-T**\ *min/max/inc* 指定统计区间的最小值、最大值和直方间隔
    - **-T**\ *inc* 只指定统计直方的间隔。统计区别最大和最小值由 :option:`-R` 选项决定


可选选项
--------

.. option:: -A

**-A**
    绘制水平直方图，默认绘制垂直直方图

.. include:: explain_-B.rst_

.. option:: -C

**-C**\ *cpt*
    指定CPT文件，将每个直方的中间值作为Z值查询CPT中的颜色

.. option:: -D

**-D**\ [**+b**][**+f**\ *font*][**+o**\ *off*][**+r**]
    为每个直方（bar）添加标注，其内容是每个直方的统计数目

    - **+b** 将标注放在直方的底部（默认为顶部）
    - **+f**\ *font* 设置标注的字体
    - **+o**\ *offset* 修改标注与直方的距离（默认值为6p）
    - **+r** 将标注从水平方向旋转为垂直方向

.. option:: -F

**-F**
    center bin on each value（默认是左边界）

    假设数据范围是0到100，长条的宽度为10。默认情况下，会将0到10作为第一个bin，
    10到20作为第二个bin，以此类推。若使用该选项，则第一个bin以0为中心，即0到5
    是第一个bin，5到15是第二个bin，以此类推。

.. option:: -G

**-G**\ *fill*
    设置直方的填充色

.. option:: -I

**-I**\ [**o**\|\ **O**]
    返回计算结果不绘图。

    - :option:`-I` 返回 *xmin xmax ymin ymax*，即数据的最小值、最大值和统计数量的最小值、最大值
    - **-Io** 输出各个直方的的X值和Y值
    - **-IO** 输出各个直方的的X值和Y值，即使Y=0

.. option:: -L

**-Ll**\|\ **h**\|\ **b**
    设置超过统计范围的数据的处理方式。

    - **-Ll** 小于第一个直方的统计范围的数据算入第一个直方
    - **-Lh** 大于最后一个直方的统计范围的数据算入最后一个直方
    - **-Lb** 小于第一个直方的统计范围的数据算入第一个直方，
      并且大于最后一个直方的统计范围的数据算入最后一个直方

.. option:: -N

**-N**\ [*mode*][**+p**\ *pen*]
    绘制等效的正态分布曲线

    *mode* 用于设定正态分布的中间位置及比例：

    - mode=0：平均值和方差 (默认)
    - mode=1：平均值和 L1 范数
    - mode=2：最小二乘

    *pen* 用于指定曲线的属性。该选项可以使用多次以绘制多条曲线。

.. option:: -Q

**-Q**\ **r**
    绘制累计直方图，**r** 绘制反向的累计直方图

.. include:: explain_-R.rst_

.. include:: explain_-Rz.rst_

.. option:: -S

**-S**
    绘制阶梯状直方图，并且不包含直方内部的线条。

.. include:: explain_-U.rst_

.. include:: explain_-V.rst_

.. option:: -W

**-W**\ *pen*
    设置直方边框的画笔属性

.. include:: explain_-XY.rst_

.. option:: -Z

**-Z**\ [*type*][**+w**]
    选项直方图的种类

    - type=0：数量（默认值）
    - type=1：百分比
    - type=2：e为底对数 (1.0 + 数量)
    - type=3：e为底对数 (1.0 + 百分比)
    - type=4：10为底对数 (1.0 + 数量)
    - type=5：10为底对数 (1.0 + 百分比)

    若要使用第二列数据而不是count数作为权重，可以加上 ``+w`` 选项。

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_perspective.rst_

.. include:: explain_-t.rst_

.. include:: explain_help.rst_

示例
----

访问 :doc:`/tutorial/histogram/index` 以查看更多示例。
