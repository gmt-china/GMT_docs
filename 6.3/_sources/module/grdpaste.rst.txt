.. index:: ! grdpaste
.. include:: common_SYN_OPTs.rst_

grdpaste
========

:官方文档: :doc:`gmt:grdpaste`
:简介: 将两个网格文件沿着其共同边界拼接成一个文件

**grdpaste** 用于将两个网格文件沿着共同的边界拼接为一个网格文件。
要合并的两个网格文件必须拥有相同的网格间隔以及一条共同的边。
可以使用 :doc:`grdinfo` 查看两个网格文件是否满足条件。
若不满足，则需要使用 :doc:`grdcut` 或 :doc:`grdsample` 命令对网格数据做处理再拼接。
对于地理网格数据而言，可能需要使用 **-f** 选项以正确处理经度的周期性。

语法
----

**gmt grdpaste**
*file_a.nc file_b.nc*
|-G|\ *outfile.nc*
[ |SYN_OPT-V| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT--| ]

必选选项
--------

*file_a.nc* *file_b.nc*
    要进行拼接的两个网格文件名

.. _-G:

**-G**\ *outfile.nc*
    拼接后生成的网格文件名

可选选项
--------

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

示例
----

假如 file_a.nc 的范围为150E-180E和0-30N，file_b.nc 的范围为 150E-180E和-30S-0，
则使用如下命令拼接得到的 outfile.nc 的范围为 150E-180E 和 -30S 到 30N::

    gmt grdpaste file_a.nc file_b.nc -Goutfile.nc

相关模块
--------

:doc:`grdblend`,
:doc:`grdclip`,
:doc:`grdcut`,
:doc:`grdinfo`,
:doc:`grdsample`
