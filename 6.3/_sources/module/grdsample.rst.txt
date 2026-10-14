.. index:: ! grdsample
.. include:: common_SYN_OPTs.rst_

grdsample
=========

:官方文档: :doc:`gmt:grdsample`
:简介: 对网格文件做重采样

**grdsample** 模块读取一个网格文件，并对其做插值以生成一个新的网格文件。
新旧网格文件可能的区别在于：

- 不同的配准方式（**-r** 或 **-T**）
- 不同的网格间隔或网格节点数（**-I**）
- 不同的网格范围（**-R**）

网格文件插值方式有多种，默认使用 bicubic 插值，可以使用 **-n** 选项设置其它插值方式。
该模块可以安全地将粗网格插值为细网格；反之，将细网格插值为粗网格时，则可能
存在混叠效应，因而需要在插值前使用 :doc:`gmt:grdfft` 或 :doc:`gmt:grdfilter`
对网格文件做滤波。

若省略 |-R| 选项，则输出网格与输入网格的区域范围相同；若省略 |-I| 选项，
则输出网格间距与输入网格间距相同。**-r** 和 |-T| 均可用于修改网格配准方式。
若省略这两个选项，则输出网格的配准方式与输入网格相同。

语法
----

**gmt grdsample** *in_grdfile* |-G|\ *out_grdfile*
[ |SYN_OPT-I| ]
[ |SYN_OPT-R| ]
[ |-T| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT-r| ]
[ |SYN_OPT-x| ]
[ |SYN_OPT--| ]

必选选项
--------

*in_grdfile*
    要重采样的2D网格文件

.. _-G:

**-G**\ *out_grdfile*
    输出的网格文件名

可选选项
--------

.. include:: explain_-I.rst_

.. include:: explain_-R.rst_
..

    若只使用 |-R| 选项，则等效于使用 :doc:`grdcut` 或 :doc:`grdedit` **-S**。

.. _-T:

**-T**
    交换网格文件的配准方式。即若输入是网格线配准，则输出为像素点配准；若输入
    是像素点配准，则输出为网格线配准。注意，转换配准方式会导致高频信息的丢失，
    详情见 :doc:`/grid/registration`。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_-n.rst_

.. include:: explain_nodereg.rst_

.. include:: explain_core.rst_

.. include:: explain_help.rst_

注意事项
--------

- 网格插值过程中可能会导致插值后的值出现失真或意外值。例如，使用样条插值可能会导致
  插值后的数据的最大最小值超过原始数据的最大最小值。若这一结果不可接受，可以通过
  给 **-n** 选项加上 **+c** 以对超过原始数据最值的部分做裁剪。
- 若某个插值点不在输入数据的网格节点上，则插值时若该节点周围的节点值为NaN，则
  该节点的值也会被插值为NaN。默认的bicubic插值算法会生成连续的一阶导数但需要
  周围4x4个节点。bilinear插值算法只需要周围的2x2个节点，但其只是零阶连续。
  若光滑性很重要，则使用bicubic算法；若需要尽量避免NaN值的传播，则使用bilinear算法。
- 除了插值之外，还可以使用 :doc:`grd2xyz` 将网格数据转换为表数据，然后
  将输出交给 :doc:`surface` 或 :doc:`gmt:greenspline` 重新网格化。

示例
----

将5x5分的数据采样成1x1分::

    gmt grdsample @earth_relief_05m -R0/20/0/20 -I1m -Gtopo_1m.nc

将网格线配准的网格文件修改为像素配准的网格文件::

    gmt grdsample @earth_relief_05m -T -Gpixel.nc

参考文献
--------

Marks, K. M., and W. H. F. Smith, 2007, Some remarks on resolving seamounts in satellite gravity,
*Geophys. Res. Lett., 34 (L03307)*, https://doi.org/10.1029/2006GL028857.

相关模块
--------

:doc:`grdedit`,
:doc:`gmt:grdfft`,
:doc:`gmt:grdfilter`,
:doc:`gmt:greenspline`,
:doc:`surface`
