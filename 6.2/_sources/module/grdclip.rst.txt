.. index:: !grdclip
.. include:: common_SYN_OPTs.rst_

grdclip
========

:官方文档: :doc:`gmt:grdclip`
:简介: 根据网格文件的Z值对网格进行裁剪

语法
----

**gmt grdclip** *ingrid*
|-G|\ *outgrid*
[ |SYN_OPT-R| ]
[ |-S|\ **a**\ *high/above* ]
[ |-S|\ **b**\ *low/below* ]
[ |-S|\ **i**\ *low/high/between* ]
[ |-S|\ **r**\ *old/new* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必须选项
--------

*ingrid*
    输入网格文件名

.. _-G:

**-G**\ *outgrid*
    输出网格文件名

可选选项
--------

.. include:: explain_-R.rst_
..

    指定要截取的网格区域。若该选项指定的范围超过了网格文件的边界，则仅提取二者
    公共的区域。

.. _-S:

**-Sa**\ *high/above*
    将所有大于 *high* 的值设置为 *above*

**-Sb**\ *low/below*
    将所有小于 *low* 的值设置为 *below*

**-Si**\ *low/high/between*
    将所有在 *low* 和 *high* 范围内的值设置为 *between*。该选项可多次使用

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
