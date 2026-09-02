.. index:: !x2sys_report
.. include:: common_SYN_OPTs.rst_

x2sys_report
============

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_report`
:简介: 对交叉点信息进行统计

**x2sys_report** 模块读取交叉点 ASCII 文件 *codebase.txt* （或者从标准输入读）
并输出每个轨迹的交叉点统计信息，包括：*n* ，*mean* ，*std* ，*rms* 和 
*weight* 。  

语法
----

**gmt x2sys_report** |-C|\ *column* |-T|\ *TAG* [ *coedbase.txt* ]
[ |-A| ]
[ |-I|\ [*list*] ]
[ |-L|\ [*corrections*] ]
[ |-N|\ *nx_min* ]
[ |-Q|\ **e**\|\ **i** ]
[ [ |SYN_OPT-R| ]
[ |-S|\ *track* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

*coedbase.txt*
    输入 ASCII 格式交叉点文件名，该文件使用 :doc:`x2sys_cross` 模块生成。
    如果不指定输入文件，将从标准输入中读取数据。

.. _-C:

**-C**\ *column*
    指定要处理的列，列名必须是已经在格式定义文件中存在的，见 :doc:`x2sys_init` 
    
.. _-T:
    
**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init`

可选选项
--------

.. _-A:

**-A**
    通过轨迹的权重来消除两个轨迹在交叉点的不符值；
    平差结果可用于 :doc:`x2sys_datalist` 模块中。
    平差后的文件名为 *track.cplumn.adj* ，位于 **$X2SYS_HOME**/*TAG*
    文件夹中。具体处理过程见 *Mittal* [1984] 。

.. _-I:

**-I**\ [*list*]
    *list* 为轨迹列表文件名，其中包含若干轨迹文件名，这些轨迹将不参与计算
    [默认包含所有的轨迹]。

.. _-L:

**-L**\ [*corrections*]
    对选择观测量进行最优改正，*corrections* 为改正表，该改正表可以由 :doc:`x2sys_solve` 生成
    [默认使用位于 **$X2SYS_HOME**/*TAG* 文件夹中的 TAG_corrections.txt]
    对于改正表文件的格式，见 :doc:`x2sys_datalist` 的 Corrections 章节

.. _-N:

**-N**\ *nx_min*
    只输出至少含有 *nx_min* 个交叉点的轨迹的交叉点信息 [默认为全部轨迹]

.. _-Q:

**-Qe**\|\ **i**
    **e** 表示外部交叉点，**i** 表示内部交叉点 [默认为外部交叉点]

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *track*
    指定单轨迹的名称，只输出和这条轨迹相关的交叉点的信息 
    [默认输出所有轨迹交叉点信息]

.. include:: explain_-V.rst_

.. include:: explain_help.rst_


示例
----

数据库 TAG 为 MGD77，交叉点文件为 :file:`COE_data.txt` ，
输出所有在指定区域的磁观测量的外部交叉点统计信息 ::

    gmt x2sys_report COE_data.txt -V -TMGD77 -R180/240/-60/-30 -Cmag > mag_report.txt

输出和测线 :file:`1234567` 相关的重力异常交叉点统计信息::

    gmt x2sys_report COE_data.txt -V -TMGD77 -Cfaa -S1234567 > faa_report.txt

参考文献
--------

Mittal, P. K. (1984), Algorithm for error adjustment of potential field
data along a survey network, *Geophysics*, **49**\ (4), 467-469.

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_init`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
