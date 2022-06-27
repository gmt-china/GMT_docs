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
    仅输出记录数与给定条件匹配的数据段。

.. _-D:

**-D**\ [*template*\ [**+o**\ *orig*]]

.. _-E:

**-E**\ [**f**\|\ **l**\|\ **m**\|\ **M**\ *stride*]

.. _-F:

**-F**\ [**c**\|\ **n**\|\ **p**\|\ **v**][**a**\|\ **t**\|\ **s**\|\ **r**\|\ *refpoint*]

.. _-I:

**-I**\ [**tsr**]

.. _-L:

**-L**

.. _-N:

**-N**\ *col*\ [**+a**\|\ **d**]


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
