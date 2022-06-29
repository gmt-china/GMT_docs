.. index:: ! gmtconvert
.. include:: common_SYN_OPTs.rst_

gmtconvert
===========

:官方文档: :doc:`gmt:gmtconvert`
:简介: 对表数据进行格式转换，粘贴以及提取列等操作

**convert** 模块读取文件（或从标准输入读取）并将所需信息输出到标准输出。
该模块可完成如下任务及其组合：

#. 在二进制数据和 ASCII 数据之间转换

#. 将多个文件中的数据记录在水平方向合并（类似于类 Unix 系统下的 paste 命令）

#. 提取某些列

#. 在多段数据记录中，根据头段信息的匹配结果提取数据记录

#. 只列出段头信息，不显示数据记录

#. 提取每个数据段的第一个和/或最后一个数据记录

#. 将输出数据记录进行反转

#. 仅输出段编号的范围

#. 根据数据段中数据记录个数输出想匹配的段

输入以及输出都可能包含多个头部信息。

语法
----

**gmt convert** [ *table* ]
[ |-A| ]
[ |-C|\ [**+l**\ *min*][**+u**\ *max*][**+i**]]
[ |-D|\ [*template*\ [**+o**\ *orig*]] ]
[ |-E|\ [**f**\|\ **l**\|\ **m**\|\ **M**\ *stride*] ]
[ |-F|\ [**c**\|\ **n**\|\ **p**\|\ **v**][**a**\|\ **t**\|\ **s**\|\ **r**\|\ *refpoint*] ]
[ |-I|\ [**tsr**] ]
[ |-L| ]
[ |-N|\ *col*\ [**+a**\|\ **d**] ]
[ |-Q|\ [**~**]\ *selection*]
[ |-S|\ [**~**]\ *"search string"*\|\ **+f**\|\ *file*\ [**+e**] \| |-S|\ [**~**]/\ *regexp*/[**i**][**+e**] ]
[ |-T|\ [**h**][**d**\ [[**~**]\ *selection*]] ]
[ |SYN_OPT-V| ]
[ |-W|\ [**+n**] ]
[ |SYN_OPT-a| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-d| ]
[ |SYN_OPT-e| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-g| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-i| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-q| ]
[ |SYN_OPT-s| ]
[ |SYN_OPT-w| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_intables.rst_

可选选项
--------

.. _-A:

**-A**
    对输入输出进行水平合并；默认使用垂直合并。所有文件的数据段数以及每个数据段内的行数
    必须是相同的。对于二进制文件输入，则所有文件必须具有相同的列数；对于 ASCII 文件输入，
    则数据列数可以不同。

.. _-C:

**-C**\ [**+l**\ *min*][**+u**\ *max*][**+i**]
    仅输出记录数与给定条件匹配的数据段。以下的子选项含义分别为：

    - **+l**\ *min* 数据段中的数据个数大于 *min* ，默认为 0

    - **+u**\ *max* 数据段中的数据个数小于 *max* ，默认为无穷大

    - **+i** 对选择进行反转

.. _-D:

**-D**\ [*template*\ [**+o**\ *orig*]]
    对于多段数据，将每个段输出到一个单独的文件中 [默认输出到一个单独的文件]。*template*
    为输出文件的格式模版，该模版由 C 语言格式定义：%d 为整数，%08d 则为 8 位整数，位数
    不够则在前面补 0。默认输出模版为 gmtconvert_segment_%d.{txt|bin}。
    **+o**\ *orig* 表示从 *orig* 开始编号而不是从 0 开始编号。或者可以使用带有两个 C 语
    言格式说明书的模版，其中分别为表数据的编号以及段数据的编号。**+o**\ *torig*\ /*sorig*
    则用来设置表数据和段数据编号的起始值。

.. _-E:

**-E**\ [**f**\|\ **l**\|\ **m**\|\ **M**\ *stride*]
    仅提取选定的数据段的第一条和最后一条数据记录 [默认输出所有记录]。

    - **f** 只提取第一条数据记录

    - **l** 只提取最后一条数据记录

    - **m**\ *stride* 表示每 *stride* 个提取一个数据，如果为 **M** ，则还包括最后一个
      数据记录

.. _-F:

**-F**\ [**c**\|\ **n**\|\ **p**\|\ **v**][**a**\|\ **t**\|\ **s**\|\ **r**\|\ *refpoint*]
    改变点的连接方式以及数据分组的方式。点的连接方式分为：

    - **c** 每组数据都形成连续的线作为单独的数据段 [默认]

    - **n** 以参考点和

    - **p**

    - **v**

.. _-I:

**-I**\ [**tsr**]
    将 “item” 的顺序进行反转。

    - **t** 表示对输出的多个表文件进行反转

    - **s** 将每个表文件中数据段进行反转

    - **r** 将每个数据段中的数据记录反转 [默认]

.. _-L:

**-L**
    只输出所有段头信息，不输出数据记录（仅用于 ASCII 文件）

.. _-N:

**-N**\ *col*\ [**+a**\|\ **d**]
    每个数据段中的 *col* 列按数值大小进行排序。**+a** 升序 [默认]，**+d** 降序。
    |-N| 选项与 |-F| 选项不能同时使用，可与其他选项同时使用。与其他选项同时使用
    时， |-N| 选项将放在最后应用

.. _-Q:

**-Q**\ [**~**]\ *selection*


.. _-S:

**-S**\ [**~**]\ *"search string"*\|\ **+f**\|\ *file*\ [**+e**] \| |-S|\ [**~**]/\ *regexp*/[**i**][**+e**]


.. _-T:

**-T**\ [**h**][**d**\ [[**~**]\ *selection*]]

.. _-W:

**-W**\ [**+n**]

.. include:: explain_-V.rst_

.. include:: explain_-aspatial.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-d.rst_

.. include:: explain_-e.rst_

.. include:: explain_-f.rst_

.. include:: explain_-g.rst_

.. include:: explain_-h.rst_

.. include:: explain_-icols.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_-q.rst_

.. include:: explain_-s.rst_

.. include:: explain_-w.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

.. include:: explain_precision.rst_

示例
----

将二进制文件 :file:`test.b` （单精度）转换为 4 列的 ASCII 文件 ::

    gmt convert test.b -bi4f > test.dat

将多段 ASCII 表数据 :file:`test.txt` 转换为双精度二进制文件 ::

    gmt convert test.txt -bo > test.b



相关模块
--------

:doc:`gmtinfo`,
:doc:`gmtselect`
