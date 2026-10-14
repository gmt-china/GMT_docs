.. index:: !x2sys_get
.. include:: common_SYN_OPTs.rst_

x2sys_get
=========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_get`
:简介: 从 TAG 数据库中查询轨迹

**x2sys_get** 将会从 TAG 数据库中查询满足需求的轨迹数据并返回。
查询条件可以是选定的区域，也可以是满足某些数据条件。
使用 |-L| 选项可列出所有可能存在的交叉点的测线对。

语法
----

**gmt x2sys_get** |-T|\ *TAG* [ |-C| ] [ |-F|\ *flags* ] [ |-G| ]
[ |-L|\ [*list*]\ [**+i**] ]
[ |-N|\ *flags* ] [
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]


必选选项
--------

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init` 

可选选项
--------

.. _-C:

**-C**
    不输出轨迹文件的名称，而是输出至少含有一个观测值的轨迹网格的坐标。

.. _-D:

**-D**
    只输出轨迹名称 [默认会输出观测值]

.. _-F:

**-F**\ *flags*
    给定用逗号分隔的列名称列表（如 :doc:`x2sys_init` 中格式定义文件中的描述）,
    列名称必须是已有的变量名称，筛选包含这些变量的轨迹 [默认输出所有的列]。

.. _-G:

**-G**
    输出整个沿轨观测数据的标志（Y 或者 N）而不是仅在 |-R| 区域内部的数据标志
    [默认]

.. _-L:

**-L**\ [*list*]\ [**+i**]
    交叉点模式。返回可能存在交叉点的轨迹对的列表。
    列表使用轨迹网格索引文件生成，其前提是，如果两条轨迹在同一个网格
    有观测数据，则两条轨迹可能存在交叉点。
    默认会返回所有的可能存在交叉点的轨迹对。
    *list* 为轨迹列表文件名，其中包含若干轨迹名称，
    即只输出必须至少包含列表中的某条轨迹的轨迹对。
    本选项的输出适用于 :doc:`x2sys_cross` 中的 |-A| 选项。
    默认地，只列出外部交叉点，即一条轨迹和另外一条轨迹的交叉点，**+i**
    选项会同时列出内部交叉点，即轨迹自身的交叉点。

.. _-N:

**-N**\ *flags*
    给定用逗号分隔的列名称列表（如 :doc:`x2sys_init` 中格式定义文件中的描述），
    列名称必须是已有的变量名称，筛选轨迹时，需要剔除不含这些变量的轨迹。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_help.rst_


示例
----

寻找所有以 MGD77 为 TAG 的数据库中的轨迹，轨迹必须在南太平洋中的某个区域，
并且，必须至少包括自由空气重力异常 faa 和海深 depth 观测::

    gmt x2sys_get -V -TMGD77 -R180/240/-60/-30 -Ffaa,depth

寻找所有含有海深但不含 wt 变量的轨迹::

    gmt x2sys_get -V -TMGD77 -Fdepth -Nwt

寻找所有可能相交的轨迹对，但要求轨迹对中必须包含 :file:`new.lis`
中的某条轨迹::

    gmt x2sys_get -V -TMGD77 -Lnew.lis > xpairs.lis

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_init`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
