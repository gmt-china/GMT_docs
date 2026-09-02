:author: 田冬冬, 陈箫翰
:date: 2026-01-02

.. index:: ! grdpaste
.. program:: grdpaste

grdpaste
========

:官方文档: :doc:`gmt:grdpaste`
:简介: 将两个网格文件沿着其共同边界拼接成一个文件

**grdpaste** 沿着共同边界将 *file_a.nc* 和 *file_b.nc* 拼接在一起，将它们合并为一个网格文件 *outfile.nc*。
文件 *file_a.nc* 和 *file_b.nc* 必须有相同的网格间距和配准方式，并且必须有一条共同的边界。
可以使用 :doc:`grdinfo` 查看两个网格文件是否满足条件。
若不满足，则需要使用 :doc:`grdcut` 或 :doc:`grdsample` 命令对网格数据做处理再拼接。
对于地理网格数据而言，可能需要使用 **-f** 选项以正确处理经度的周期性。
若要拼接多个网格文件，请参阅 :doc:`grdblend`。

语法
----

**gmt grdpaste**
*file_a.nc file_b.nc*
:option:`-G`\ *outfile.nc*
[ :option:`-S` ]
[ :option:`-V`\ [*level*] ]
[ :option:`-f`\ *flags* ]
[ :doc:`--PAR=value </conf/overview>` ]

输入数据
--------

*file_a.nc* *file_b.nc*
    要进行拼接的两个网格文件名

必须选项
--------

.. option:: -G

**-G**\ *outfile.nc*
    拼接后生成的网格文件名

可选选项
--------

.. option:: -S

**-S**
    仅打印一个代码编号以及网格粘贴处的边界描述，不执行实际上的拼接操作， :option:`-G` 会被忽略。
    此选项对于想要重新实现 **grdpaste** 工具的外部接口（例如 Julia 和 GMTMEX）非常有用。

.. include:: explain_-V.rst_

.. include:: explain_-f.rst_

.. include:: explain_help.rst_

示例
----

假如 file_a.nc 的范围为 150E - 180E 和 0 - 30N，file_b.nc 的范围为 150E - 180E 和 -30S - 0，
则使用如下命令拼接得到的 outfile.nc 的范围为 150E - 180E 和 -30S - 30N::

    gmt grdpaste file_a.nc file_b.nc -Goutfile.nc

相关模块
--------

:doc:`grdblend`,
:doc:`grdclip`,
:doc:`grdcut`,
:doc:`grdinfo`,
:doc:`grdsample`
