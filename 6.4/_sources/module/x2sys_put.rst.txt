.. index:: !x2sys_put
.. include:: common_SYN_OPTs.rst_

x2sys_put
=========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_put`
:简介: 从已有的网格索引列表更新 TAG 轨迹数据库

**x2sys_put** 接受一个由 :doc:`x2sys_binlist` 创建的轨迹网格索引文件（tbf），
并把索引文件中包含的信息更新到 TAG 数据库。
**-F** 选项可以使用给定的 tbf 覆盖 TAG 数据库中已经存在的轨迹的旧信息。
**-D** 选项可用于删除 TAG 数据库中的某些轨迹。
被更新的数据的 *TAG* 必须和编码在 tbf 文件中的 TAG 一致。
查询数据库中的轨迹，可以使用 :doc:`x2sys_get` 。

语法
----

**gmt x2sys_put** [ *info.tbf* ] |-T|\ *TAG* [ |-D| ] [ |-F| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

*info.tbf*
    轨迹索引文件名，如果不指定，将从通过标准输入获取

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init`

可选选项
--------

.. _-D:

**-D**
    在 TAG 数据库中删除给定的轨迹索引文件中所有的轨迹 [默认为添加作为新的轨迹]

.. _-F:

**-F**
    用在轨迹索引文件中存在的轨迹信息替换 TAG 数据库已经存在的旧信息
    [默认不替换]

.. include:: explain_-V.rst_

.. include:: explain_help.rst_


示例
----

将储存在 :file:`latest.tbf` 中的轨迹信息添加到以 MGD77 为 TAG 的轨迹数据中，
并且替换已经存在的轨迹的信息::

    gmt x2sys_put latest.tbf -F -V -TMGD77

x2sys 数据库
------------

**x2sys_put** 添加新的信息到 x2sys TAG 数据库。
这个过程涉及到两个文件，第一个文件包含所有的轨迹的列表，为 ASCII 格式，
命名为 *TAG*\ \_tracks.d；
第二个文件的名字为 *TAG*\ \_index.b，是一个二进制文件，其中包含哪条轨迹经过
哪些网格等信息，在经过该网格时，有哪些观测量。网格是由 :doc:`x2sys_init`
模块在 *TAG* 初始化时，使用 |-R| 和 |-I| 选项生成的。
所有的数据库文件都储存在 **$X2SYS_HOME**/*TAG* 文件夹中。
禁止用户手动编辑这些文件。

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_init`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
