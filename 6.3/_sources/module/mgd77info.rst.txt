.. index:: ! mgd77info
.. include:: common_SYN_OPTs.rst_

mgd77info
=========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77info`
:简介: 提取 mgd77 文件信息

**mgd77info** 读取 xxx.[mgd77|nc] 文件，并提取其中每条测线的相关信息，包括：起止时间，
以 km 为单位的测线长度，经纬度范围，观测个数。并可通过选项指定查看 MGD77 头部数据还是
其成员信息。

使用 x2sys 模块（见 :doc:`x2sys_init` ）可获得哪些轨迹穿过给定区域以及可用的观测类型等信息。

**mgd77** 文件格式相关信息见 `参考文献`_

语法
----

**gmt mgd77info** *GEODAS-ids*
[ |-C|\ [**m**\|\ **e**] ]
[ |-E|\ [**m**\|\ **e**] ]
[ |-I|\ **a\|c\|m\|t** ]
[ |-M|\ **f**\ [*item*]\|\ **r**\|\ **e**\|\ **h** ]
[ |-L|\ [**v**] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

可选选项
--------

.. _-C:

**-C**\ [**m**\|\ **e**]
    列出 MGD77[+] 文件中所有列的缩写。使用 **m** 和 **e** 选项表示仅列出 MGD77 文件或
    MGD77+ 文件

.. _-E:

**-E**\ [**m**\|\ **e**]
    为每条测线输出单行的总结。
    **m** 选项只对每个 MGD77 字段中非 NaN 值计数，
    **e** 选项对其他字段中非 NaN 值计数

.. _-I:

**-I**\ **a\|c\|m\|t**
    忽略某些数据格式的文件。**a\|c\|m\|t** 分别表示忽略 MGD77 ASCII、MGD77+ NetCDF、
    MGD77T ASCII 、tab 分隔的普通文本文件。该选项可以重复使用以忽略多个格式

.. _-L:

**-L**\ [**v**]
    不显示测线信息。只输出 GEOSAR 机构 2 个字符代码以及其名称列表。
    **v** 选项可同时显示每个机构测量船的 4 个字符代码列表。由于上述两列表均十分长，
    影响阅读体验，因此这里不给出列表，请用户自己运行命令查看。

.. _-M:

**-Mf**\ [*item*]\|\ **r**\|\ **e**\|\ **h**
    列出每条测线的头部信息和 MGD77+ 历史记录。
    
    - **f** 选项用于展示格式，每行输出一个记录，包括参数和值，可以对该输出结果使用
      Unix 文本工具进行搜索。或者，可以追加特定参数的名称 *item* ，或者使用参数的编号。
      
    - **r** 选项用于展示原始的，punchcard 格式的 MGD77 头部信息

    - **e** 选行用于展示 MGD77+ E77 状态

    - **h** 选项用于展示 MGD77+ 历史记录

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

从 01010047.mgd77 和 01010008.mgd77 观测数据中提取单行的总结 ::

    gmt mgd77info 01010047 01010008 -E > listing.lis

查看 01010047.mgd77 观测数据中原始 MGD77 头部信息 ::

    gmt mgd77info 01010047 -Mr

查找 01010047.mgd77 中所有和 Gravity 相关的参数 ::

    gmt mgd77info 01010047 -Mf | grep Gravity

查找 01010047.mgd77 中磁采样率 Magnetics_Sampling_Rate 的信息 ::

    gmt mgd77info 01010047 -MfMagnetics_Sampling_Rate

查看 MGD77+ 格式文件 01010047.nc 中所有列 ::

    gmt mgd77info 01010047 -C

查看 Hawaii 大学（代码 08）搜集的 MGD77+ 格式数据中的 E77 状态 ::

    gmt mgd77info 08 -Ia -Me

参考文献
--------

MGD77 (Marine Geophysical Data Exchange Format) 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77manage`,
:doc:`mgd77path`,
:doc:`mgd77track`,
:doc:`mgd77sniffer`,
:doc:`mgd77track`,
:doc:`x2sys_init`
