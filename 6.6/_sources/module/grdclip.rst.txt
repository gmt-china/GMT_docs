:author: 田冬冬, 陈箫翰
:date: 2025-12-31

.. index:: ! grdclip
.. program:: grdclip

grdclip
========

:官方文档: :doc:`gmt:grdclip`
:简介: 对网格文件的 Z 值进行截断

**grdclip** 将把小于 *low* 的值设为 *below*，且/或将大于 *high* 的值设为 *above*。
还可以指定一个或多个区间，将区间内的所有值都设为 *between*，或者替换特定的单个值。
在图像处理中，当希望整个大陆或海洋呈现为单一颜色或灰度色调、需要裁剪数据值的范围或对数据值进行重新分类时，这些操作非常有用。
*above* 、 *below* 、 *between* 、 *old* 和 *new* 可以是任何数值，甚至是 NaN（非数字）。
必须至少选择一个 :option:`-S` 选项。使用 :option:`-R` 仅提取 *ingrid* 文件的某个范围内的数据。

语法
----

**gmt grdclip**
*ingrid*
:option:`-G`\ *outgrid*
[ :option:`-R`\ *region* ]
[ :option:`-S`\ **a**\ *high/above*\ [**+e**] ]
[ :option:`-S`\ **b**\ *low/below*\ [**+e**] ]
[ :option:`-S`\ **i**\ *low/high/between* ]
[ :option:`-S`\ **r**\ *old/new* ]
[ :option:`-V`\ [*level*] ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

.. include:: explain_grd_in.rst_

必须选项
--------

.. include:: explain_grd_out.rst_

可选选项
--------

.. include:: explain_-R.rst_
..

    指定要截取的网格区域。若该选项指定的范围超过了网格文件的边界，则仅提取二者
    公共的区域。

.. option:: -S

**-Sa**\ *high/above*\ [**+e**]
    将所有大于 *high* 的值设置为 *above* 。使用 **+e** 则表示大于等于。

**-Sb**\ *low/below*\ [**+e**]
    将所有小于 *low* 的值设置为 *below* 。使用 **+e** 则表示小于等于。

**-Si**\ *low/high/between*
    将所有在 *low* 和 *high* 范围内的值设置为 *between*。该选项可多次使用。
    注意区间边界为小于等于和大于等于。

**-Sr**\ *old/new*
    将所有等于 *old* 的值设置为 *new*。该选项可以多次使用

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

将所有大于0的值设置为NaN，并将小于0的值设置为0::

    gmt grdclip @AFR.nc -Gnew_AFR.nc -Sa0/NaN -Sb0/0 -V

将所有25到30范围内的值设置为99，35到39范围内的值设置为55，将17换成11，将所有
小于10的值设置为0::

    gmt grdclip classes.nc -Gnew_classes.nc -Si25/30/99 -Si35/39/55 -Sr17/11 -Sb10/0 -V

相关模块
--------

:doc:`grdfill`,
:doc:`grdlandmask`,
:doc:`grdmask`,
:doc:`grdmath`,
:doc:`grd2xyz`,
:doc:`xyz2grd`
