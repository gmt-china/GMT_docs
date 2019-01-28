.. index:: ! grdvolume

grdvolume
=========

:官方文档: :doc:`gmt:grdvolume`
:简介: 计算网格数据中某个等值线所包围的表面积和体积

该命令读取一个2D网格文件，通过指定某条等值线确定某个Z值平面，并计算由该等值线
约束的区域网格表面积、网格表面到该平面所包围的体积，以及最大平均高度（体积/面积）。
也可以指定一系列等值线，此时该命令会分别计算每个等值线范围内的表面积和体积。

必选选项
---------

``<grdfile>``
    输入的2D网格文件名

可选选项
--------

``-C``
    指定等值线（Z值平面），以计算由该等值线所决定的表面积、体积以及平均高度。
    若不使用该选项，则返回整个网格文件的表面积、体积和平均高度。

    该选项有四种不同的语法：

    - ``-C<cval>`` 指定单个等值线
    - ``-C<low>/<high>/<delta>`` 指定多条等间距的等值线
    - ``-Cr<low>/<high>`` 计算两个Z值平面之间的体积
    - ``-Cr<cval>`` 指定网格最小值和 ``z=<cval>`` 两条等值线

``-L<base>``
    同时也计算从等值线到 ``<base>`` 的体积

``-S[<unit>]``
    对于地理网格，默认会将角度转换为 “Flat Earth” 下的距离，默认单位为米。
    使用 ``-S`` 选项以指定其他的单位，则输出的表面积单位为此 ``<unit>^2`` ，
    而输出的体积单位则是 ``<unit>^2 * z_unit`` 。

``-T[c|h]``

    - ``-Th`` 确定最大平均高度所对应的等值线
    - ``-Tc`` 确定最大曲率（高度vs等值线值）所对应的等值线

``-Z<fact>[/<shift>]``
    将数据减去 ``<shift>`` 再乘以比例因子 ``<fact>`` 。

示例
----

计算网格表面之下的体积，网格数据的单位是km，结果的单位为km^3::

    gmt grdvolume hawaii_topo.nc -Sk

计算网格表面与等值线Z=250m之间的体积::

    gmt grdvolume peaks.nc -Se -C250

在等值线100到300范围内，以10为间隔，计算所有等值线所约束的表面积和体积::

    gmt grdvolume peaks.nc -Sk -C100/300/10 > results.d

在等值线100到300范围内，以10为间隔，搜索最大平均高度（即体积与表面积的比）所对应的等值线值::

    gmt grdvolume peaks.nc -Sk -C100/300/10 -Th > results.d

计算湖内从表面到300米深度范围内水的体积::

    gmt grdvolume lake.nc -Cr-300/0

引用
----

如果本命令对你非常有用，可以引用如下文章:

Wessel, P., 1998, An empirical method for optimal robust regional-residual
separation of geophysical data, *Math. Geol.*, **30**\ (4), 391-408.
