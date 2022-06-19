.. index:: !x2sys_list
.. include:: common_SYN_OPTs.rst_

x2sys_list
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_list`
:简介: 从交叉点计算结果中提取数据

**x2sys_list** 读取交叉点 ASCII 文件 *coedbase.txt* （或标准输入），
并基于某些条件提取数据，输出结果可以为 ASCII 或二进制文件。该模块
输出结果可做为 :doc:`x2sys_solve` 交叉点平差的输入数据。

语法
----

**gmt x2sys_list** |-C|\ *column* |-T|\ *TAG* [ *coedbase.txt* ]
[ |-A|\ *asymm_max* ]
[ |-E| ]
[ |-F|\ *flags* ]
[ |-I|\ [*list*] ]
[ |-L|\ [*corrections*] ]
[ |-N|\ *nx_min*\ [**+p**] ]
[ |-Q|\ **e**\|\ **i** ]
[ |SYN_OPT-R| ]
[ |-S|\ *track*\ [**+b**] ]
[ |SYN_OPT-V| ]
[ |-W|\ [*list*] ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT--| ]

必选选项
--------

.. _-C:

**-C**\ *column*
    指定要处理的列，列名必须是格式定义文件中已有的列名，见 :doc:`x2sys_init`

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init`

*coedbase.txt*
    输入交叉点 ASCII 文件的名称，该文件可由 :doc:`x2sys_cross` 模块生成，
    也可从标准输入读取

可选选项
--------

.. _-A:

**-A**\ *asymm_max*
    指定相对于时间中点的交叉点分布的最大不对称性（如果没有时间，也可用距离）。
    不对称性的计算公式为 (n_right - n_left)/(n_right + n_left)。如果指定
    *asymm_max* 值，将会排除超过该截止值的轨迹 [默认值为 1，即不排除任何轨迹]。

.. _-E:

**-E**
    输出两个轨迹的名称和总的交叉点个数作为头部信息 [默认不写入这些头部信息]

.. _-F:

**-F**\ *flags*
    使用 **acdhiInNtTvwxyz** 的组合来设置输出。这些字符中不能包括空格，
    而且对大小写敏感。以下为字符的描述：

    **a** 小于 90 度的角度，该角度为轨迹的方位角

    **c** 指定的观测量的交叉点值（见 **-C**）
    
    **d** 沿轨距离

    **h** 轨迹朝向

    **i** 形成交叉点的两条轨迹在该点的有符号时间间隔

    **I** 和 **i** 相同，但是时间间隔是无符号的

    **n** 两条轨迹的名称

    **N** 两条轨迹的 ID number

    **t** 沿轨时间，格式为 date\ **T**\ clock （不含时间时，输出 NaN）

    **T** 从轨迹开始计算的时间 （不含时间时，设置为 NaN）

    **v** 沿轨速度

    **w** 轨迹的权重

    **x** x 坐标或者经度

    **y** y 坐标或纬度

    **z** 沿轨观测值，见 **-C**

    如果不使用 **-S**，**d**,\ **h**,\ **n**,\ **N**,\ **t**,\ **T**,\ **v**
    在每列包含两个输出，分别代表两个轨迹。否则，将只输出对应轨迹的结果
    （除 **n**,\ **N** ）。
    **c** 和 **i** 的符号是由 Value(track_one) - Value(track_two) 决定的。
    返回的时间间隔和 :term:`TIME_UNIT` 的设置有关。
    上面各元素输出的顺序和他们在 *flags* 中的顺序一致， **n** 除外，**n**
    选项将放在所有数字列的最后。

.. _-i:

**-I**\ [*list*]
    *list* 为轨迹列表文件名，其中包含若干轨迹文件名，这些轨迹将不参与计算
    [默认包含所有的轨迹]。

.. _-L:

**-L**\ [*corrections*]
    对选择观测量进行最优改正，*corrections* 为改正表，该改正表可以由 :doc:`x2sys_solve` 生成
    [默认使用位于 **$X2SYS_HOME**/*TAG* 文件夹中的 TAG_corrections.txt]。
    对于改正表文件的格式，见 :doc:`x2sys_datalist` 的 Corrections 章节

.. _-N:

**-N**\ *nx_min*\ [**+p**]
    只输出至少含有 *nx_min* 个交叉点的轨迹的交叉点信息，
    **+p** 为相反，即输出少于 *nx_min* 个交叉点的轨迹的信息
    [默认为全部轨迹]

.. _-Q:

**-Qe**\|\ **i**
    **e** 表示外部交叉点，**i** 表示内部交叉点 [默认为全部交叉点]

.. include:: explain_-R.rst_

.. _-S:

**-S**\ *track*\ [**+b**]
    指定单轨迹的名称，只输出和这条轨迹相关的交叉点的信息 
    [默认输出所有轨迹交叉点信息]。
    添加 **+b** 以输出包含该轨迹的轨迹对相关的信息。 

.. _-W:

**-W**\ [*list*]
    *list* 为文本文件，其中包含的信息为轨迹名称列表和用于计算交叉点处权重的
    权重列表 [默认权重设置为 1]

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_help.rst_

示例
----

在以 MGD77 为 TAG 的磁数据的交叉点文件 :file:`COE_data.txt` 中寻找
指定区域的数据，并返回位置，时间和交叉点的值::

    gmt x2sys_list COE_data.txt -V -TMGD77 -R180/240/-60/-30 -Cmag -Fxytz > mag_coe.txt

输出和测线 :file:`12345678` 相关的重力异常交叉点信息，
输出时间为以年初为起点的相对时间，使用二进制 double 类型精度::

    gmt x2sys_list COE_data.txt -V -TMGD77 -Cfaa -S12345678 -FTz -bod > faa_coe.b

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_init`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
