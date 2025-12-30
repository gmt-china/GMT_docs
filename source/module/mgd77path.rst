:author: 周茂
:date: 2024-06-21

.. index:: ! mgd77path
.. program:: mgd77path
.. include:: common_SYN_OPTs.rst_

mgd77path
=========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77path`
:简介: 返回 MGD77 的路径和文件夹

**mgd77path** 返回一个或多个 MGD77 文件的完整路径名。
由于目录的变化，返回的路径名可能会随时间变化。

语法
----

**gmt mgd77path** *GEODAS-ids* [ :option:`-A`\ [**c**] ] [ :option:`-D` ]
[ :option:`-I`\ **a\|c\|m\|t** ]
[ :option:`-V`\ [*level*] ]
[ :doc:`--PAR=value </conf/overview>` ]

必选选项
--------

.. include:: explain_ncid.rst_

可选选项
--------

.. option:: -A

**-A**\ [**c**]
    显示每条测线的完整路径，**c** 选项将会只列出 ID

.. option:: -D

**-D**
    显示当前在搜索中的路径

.. option:: -I

**-I**\ **a\|c\|m\|t**
    忽略某些数据格式的文件。**a\|c\|m\|t** 分别表示忽略 MGD77 ASCII、MGD77+ NetCDF、
    MGD77T ASCII 、tab 分隔的普通文本文件。该选项可以重复使用以忽略多种格式

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

获取 01010008 和 01010007 路径名 ::

    gmt mgd77path 01010008 01010007

当 01010008 和 01010007 为 MGD77+ 格式时，返回路径名 ::

    gmt mgd77path 01010008 01010007 -Ia -It

查看可能储存 MGD77 文件的目录列表 ::

    gmt mgd77path -D

参考文献
--------

MDG77 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77manage`,
:doc:`mgd77info`,
:doc:`mgd77track`,
:doc:`mgd77sniffer`,
:doc:`mgd77track`
