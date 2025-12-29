:author: 田冬冬, 朱邓达, 陈箫翰
:date: 2025-06-11
.. index:: ! grdconvert
.. program:: grdconvert
.. include:: common_SYN_OPTs.rst_

grdconvert
==========

:官方文档: :doc:`gmt:grdconvert`
:简介: 将网格文件转换为其它网格文件格式

语法
----

**gmt grdconvert** *ingrdfile* :option:`-G`\ *outgrdfile*
[ :option:`-N` ]
[ :option:`-R`\ *region* ]
[ :option:`-V`\ [*level*] ]
[ :option:`-Z`\ [**+s**\ *factor*][**+o**\ *offset*] ]
[ :option:`-f`\ *flags* ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_grd_in.rst_

.. include:: explain_grd_out.rst_


可选选项
--------

.. _-N:

**-N**
    在生成native二进制文件时，不将GMT网格文件头段写到文件中。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. _-Z:

**-Z**\ [**+s**\ *factor*][**+o**\ *offset*]
    在写网格文件前，从数据中减去 *offset* 并将结果乘以 *factor*。

    注意：该选项功能与 **+s** 和 **+o** 子选项的功能不同。
    使用 **+s** 和 **+o** 子选项，数据也会进行缩放和偏移，修改后的数据会被写入到
    网格文件中，但同时缩放因子和偏移量会写入到网格文件的元信息中。因而，在读取
    这些新生成的网格时，会自动根据元信息中的值恢复数据的原始值。
    而使用该选项则永久修改了网格文件中的数据值。

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

注意事项
--------

GMT默认只能读取并处理2D单变量网格。对于多变量、多维度网格文件，需要使用额外的语法
指定要读取的变量或维度，详情见 :doc:`/grid/read`。

.. include:: explain_float.rst_

示例
----

从一个含有红绿蓝三个波段数据的tif文件中分别抽出三个波段的数据::

    gmt grdconvert map.tif+b0 -Gred.nc
    gmt grdconvert map.tif+b1 -Ggreen.nc
    gmt grdconvert map.tif+b2 -Gblue.nc

将网格文件转换成四字节native浮点型网格::

    gmt grdconvert data.nc ras_data.b4=bf -V

将网格文件转换成二字节短整型文件，将其乘以10并减去32000，并设置无数据节点的值为-9999::

    gmt grdconvert values.nc shorts.i2=bs/10/-32000/-9999 -V

从一个三维网格文件中提取第二层数据::

    gmt grdconvert climate.nc?temp[1] temp.nc -V

相关模块
--------

:doc:`grdmath`
