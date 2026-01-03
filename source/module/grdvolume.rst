:author: 田冬冬, 周茂, 姚家园, 陈箫翰
:date: 2026-01-03

.. index:: ! grdvolume
.. program:: grdvolume

grdvolume
=========

:官方文档: :doc:`gmt:grdvolume`
:简介: 计算网格数据中某个等值线所包围的表面积和体积

**grdvolume** 模块读取一个2D网格文件，通过指定某条等值线确定一个Z值平面，并计算由该等值线
约束的区域网格表面积、网格表面到该平面所包围的体积，以及最大平均高度（体积/面积）。
也可以指定一系列等值线，此时该模块会分别计算每个等值线范围内的表面积和体积。

使用 :option:`-T` 选项，还会报告产生最大平均高度（或高度对等值线曲线的最大曲率）的等值线。
此功能可与 :doc:`grdfilter` 结合使用，以设计最优稳健分离器（Optimal Robust Separator）[*Wessel*, 1998; 2016]。

语法
----

**gmt grdvolume** 
*ingrid*
[ :option:`-C`\ *paras* ]
[ :option:`-D` ]
[ :option:`-L`\ *base* ]
[ :option:`-R`\ *region* ]
[ :option:`-S`\ [*unit*] ]
[ :option:`-T`\ [**c**\|\ **h**] ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ *fact*\ [/*shift*] ]
[ :option:`-f`\ *flags* ]
[ :option:`-h`\ *headers* ]
[ :option:`-o`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

可选选项
--------

.. option:: -C

**-C**\ *paras*
    指定等值线（Z值平面）以计算由该等值线所包含的表面积、体积以及平均高度（体积/面积）。
    若不使用该选项，则返回整个网格文件的表面积、体积和平均高度。

    该选项有四种不同的语法：

    - :option:`-C`\ *cval* ：指定单个等值线并计算等值线内的区域面积、体积和平均高度
    - :option:`-C`\ *low/high/delta* ：以 *delta* 为步长，报告从 *low* 到 *high* 的每条等距等值线所包含的区域面积、体积和平均高度
    - :option:`-C`\ **r**\ *low/high* ：计算介于 *low* 和 *high* 之间且在网格表面之上的面积、体积和平均高度。例如，使用此形式可以计算两个等值线之间的水体体积。
    - :option:`-C`\ **r**\ *cval* ：计算 *cval* 之下且在网格表面之上的面积、体积和平均高度。 **注意**：这定义了一个“外部”体积。

.. option:: -D

**-D**
    需要和 :option:`-C`\ *low/high/delta* 选项一起使用，计算由等值线定义的每个水平“切片”的面积和体积。
    报告的等值线值和面积值是指该切片的底部的对应值，而高度为 *delta* （所有切片的厚度相同）。

.. option:: -L

**-L**\ *base*
    计算体积时加上从 z=\ *base* 到等值线的体积。

.. option:: -S

**-S**\ [*unit*]
    对于地理网格，默认会将度转换为平面距离，默认单位为米。
    使用该选项指定其它长度单位，则输出的表面积单位为 *unit*\ :math:`^2`，
    输出的体积单位则是 z_unit * *unit*\ :math:`^2`。

.. option:: -T

**-T**\ [**c**\|\ **h**]
    找到最大平均高度所对应的等值线

    - **-Th** 找到最大平均高度（体积/面积）所对应的等值线
    - **-Tc** 找到最大曲率（高度vs等值线值）所对应的等值线（需要配合 :option:`-C` 使用）

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. option:: -Z

**-Z**\ *fact*\ [/*shift*]
    将数据减去 *shift* 再乘以比例因子 *fact* （ :option:`-C` 和 :option:`-L` 中的数值是指执行此缩放后的值）。

.. include:: explain_-f.rst_

.. include:: explain_-h.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_help.rst_

示例
----

计算夏威夷岛中所有陆地部分（高于0等值线）部分的面积（:math:`km^2`）、体积（:math:`km^3`）
和平均高度（km）::

    gmt grdvolume @earth_relief_05m -R190/210/15/25 -C0 -Sk -Z0.001

计算网格表面与等值线 :math:`Z=250m` 之间的体积::

    gmt grdvolume peaks.nc -Se -C250

在等值线100到300范围内，以10为间隔，计算所有等值线所约束的表面积和体积::

    gmt grdvolume peaks.nc -Sk -C100/300/10 > results.d

在等值线100到300范围内，以10为间隔，搜索最大平均高度（即体积与表面积的比）所对应的等值线值::

    gmt grdvolume peaks.nc -Sk -C100/300/10 -Th > results.d

计算湖内从表面到300米深度范围内水的体积::

    gmt grdvolume lake.nc -Cr-300/0

体积积分
--------

表面将使用每个由四个网格节点定义的网格框内的双线性表达式来近似 z 值：

.. math::
    z(x,y) = z_0 + z_x^{'}x + z_y^{'}y + z_{xy}^{''}xy

其中第一项是单元左下角的网格值（此处相对坐标为 x = y = 0）。带撇号的 z 值分别是 x 方向、y 方向以及两个方向上的导数。
在每个框内对该表达式进行解析积分，并允许直线等值线交点穿过网格框，从而影响积分域和限制。

注意事项
------------

#. **grdvolume** 的输出是一条或多条记录（如果设置了 :option:`-C` 来搜索多个等值线，则每个等值线对应一条记录），
   包含 *等值线 面积 体积 体积/面积*。这些记录将写入到标准输出。
#. 对于地理网格，会将度转换为以米为单位的“平地球”（Flat Earth）距离。可以使用 :option:`-S` 来选择另一种距离单位。
   面积将以该单位的平方报告，而体积将以 unit\ :sup:`2` * z_unit 的量报告。
#. **grdvolume** 区分网格线配准和像素配准的网格。在这两种情况下，面积和体积都计算到网格边界。
   这意味着在第一种情况下，边界上的网格单元仅贡献其一半的面积（和体积），而在第二种情况下，所有网格单元都被完全使用。
   唯一的例外是使用 :option:`-C` 时：由于等值线不会延伸到最外层网格点之外，因此这两种网格类型被同等对待。
   这意味着在使用 :option:`-C` 时，像素配准网格中的外缘会被忽略。

相关模块
--------

:doc:`grdfilter`,
:doc:`grdmask`,
:doc:`grdmath`

参考文献
--------

Wessel, P., 1998, An empirical method for optimal robust regional-residual
separation of geophysical data, *Math. Geol.*, **30**\ (4), 391-408.