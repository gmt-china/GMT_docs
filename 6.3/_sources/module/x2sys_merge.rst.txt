.. index:: !x2sys_merge
.. include:: common_SYN_OPTs.rst_

x2sys_merge
===========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_merge`
:简介: 合并交叉点文件

**x2sys_merge** 读取两个交叉点文件，并进行合并。
其中第二个文件应该只包含第一个文件中不包含的数据。
该模块在重新计算某一部分轨迹的交叉点时会发挥作用。


语法
----

**gmt x2sys_merge** |-A|\ *main_COElist.txt* |-M|\ *new_COElist.txt*
[ |SYN_OPT--| ]

必选选项
--------

.. _-A:

**-A**\ *main_COElist.txt*
    指定主要的交叉点文件 *main_COElist.txt*

.. _-M:

**-M**\ *new_COElist.txt*
    指定新的交叉点文件 *new_COElist.txt*

可选选项
--------

示例
----

使用新的交叉点文件 :file:`COE_fresh.txt` 更新主要交叉点文件 
:file:`COE_data.txt` ::

    gmt x2sys_merge -ACOE_data.txt -MCOE_fresh.txt > COE_updated.txt

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_init`
