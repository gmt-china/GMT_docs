.. index:: ! gmtconvert
.. include:: common_SYN_OPTs.rst_

gmtconvert
===========

:贡献者: |周茂|
:最近更新日期: 2022-06-30

----

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
#. 根据数据段中数据记录个数输出相匹配的段

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
    对输入输出进行水平合并 [默认使用垂直合并]。所有文件的数据段数以及每个数据段内的行数
    必须是相同的。对于二进制文件输入，则所有文件必须具有相同的列数；对于 ASCII 文件输入，
    则数据列数可以不同。

.. _-C:

**-C**\ [**+l**\ *min*][**+u**\ *max*][**+i**]
    仅输出记录数与给定条件匹配的数据段。以下的子选项含义分别为：

    - **+l**\ *min* 数据段中的数据个数大于 *min* [默认为 0]
    - **+u**\ *max* 数据段中的数据个数小于 *max* [默认为无穷大]
    - **+i** 对选择进行反转

.. _-D:

**-D**\ [*template*\ [**+o**\ *orig*]]
    对于多段数据，将每个段输出到一个单独的文件中 [默认输出到一个单独的文件]。*template*
    为输出文件的格式模版，该模版由 C 语言格式定义：%d 为整数，%08d 为 8 位整数，位数
    不够则在前面补 0。默认输出模版为 gmtconvert_segment_%d.{txt|bin}。
    **+o**\ *orig* 表示从 *orig* 开始编号而不是从 0 开始编号。或者可以使用带有两个 C 语
    言格式说明符的模版，分别为表数据的编号以及段数据的编号。**+o**\ *torig*\ /*sorig*
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
    - **p** 在每组数据中以参考点和每个点组成单独的线段
    - **n** 将每组数据中的点都互相连接构成网
    - **v** 将每组数据中的点构成向量，以方便 :doc:`plot` **-Sv+s** 选项使用

    数据分组的方式包括：

    - **a** 忽略所有段头信息，直接将所有数据段合并，将参考点设置为第一个
      文件的第一个点
    - **t** 将同一个文件中的所有数据段合并，参考点设置为每个组的第一个点
    - **s** 每个数据段都作为一个单独的组，参考点为第一个点
    - **r** 与 **s** 相同，但是参考点设置为每个点

    除上述的参考点设置方式外，还可指定一个参考点 *refpoint* 替换程序内部参考点。

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
    只输出指定的编号的数据段。该选项不能和 |-S| 选项同时使用。*selection* 的语法
    为 *range*\ [,\ *range*,...] ，其中 *range* 是单个段号或者为一个
    *start*\ [:*step*:]\ :*stop* 格式指定的一系列段号，*step* 为增量，是可选的，
    在不指定的情况下默认为 1。**~** 表示反转选择。还可使用 **+f**\ *file* 指定
    一个段号文件，其中每行均包含一个段号。

.. _-S:

**-S**\ [**~**]\ *"search string"*\|\ **+f**\|\ *file*\ [**+e**] \| |-S|\ [**~**]/\ *regexp*/[**i**][**+e**]
    只输出头段记录中包含指定字符串的数据段，使用 **~** 可以用来反转选择，即输出
    不包含指定字符串的数据段。如果指定的字符串刚好以 ~ 开头，则需要使用反斜杠
    进行转义。该选项不能和 |-Q| 选项同时使用。对于 OGR/GMT 格式的文件，可以使用
    *varname*\ =\ *value* 的形式提取数据段。 
    如果存在多个字符串，可使用 **+f**\ *file* 选项，将字符串存放在一个文件 *file*
    中，每行均为一个单独的字符串。
    **注** ：如果数据段的属性为多边形，且多边形中间有孔，则输出时会同时输出孔。
    该选项还可使用正则表达式 *regrexp* 提取数据段，为与字符串提取的方式区别，
    正则表达式必须置于斜杠中。**i** 选项表示匹配时不区分大小写。
    **+e** 字符串表示完全匹配字符串，即字符串完全相等，而不包括作为子字符串匹配
    的结果 [默认包含子字符串的结果]。

.. _-T:

**-T**\ [**h**][**d**\ [[**~**]\ *selection*]]
    禁止输出某些信息。

    - **h** 禁止输出段头 [默认]
    - **d** 对于重复的数据，只输出一次。

    上述两个子选项可以同时使用。
    默认情况下，两条记录的所有列都相同才被认为是重复的数据，但可通过 *selection*
    来设置只比较选定的列，若这些列相同，即被认为是重复的数据。*selection* 的格式
    为 *range*\ [,\ *range*,...]，*range* 可以为单独的列号，或者为 
    *start*\ [:*step*:]\ :*stop* 定义的一组列号，*step* 为步长，默认为 1。**~**
    用来反转选择。如果要考虑数据后的文本的比较，则在 *selection* 的最后添加 *t* ，
    如果不指定数字列，则只考虑最后的文本比较。

.. _-W:

**-W**\ [**+n**]
    将每个数据记录中最后的本文中的词转换为数字，并将这些数字追加到输出结果中。无法转换的
    词将设置为 NaN。使用 **+n** 可禁止输出包含 NaN 的数据行。

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

将 :file:`left.txt` （共两列）的第二列和 :file:`right.txt` 的第一列作为
坐标输入并绘制。这里的思路是：先使用 |-A| 选项将两个文件水平方向合并，在
合并后的结果中提取数据 ::

    gmt convert left.txt right.txt -A -o1,2 | gmt plot ...

在文件 :file:`big_file.txt` 中提取头段中包含字符串“RIDGE AXIS”的所有数据段 ::

    gmt convert big_file.txt -S"RIDGE AXIS" > subset.txt

在上述文件中提取头段中包含“Spitsbergen”的数据段，且必须完全匹配 ::

    gmt convert big_file.txt -SSpitsbergen+e > subset.txt

选区所有不存在以“profile”开头，且后面为整数和 g 到 l 的任意字符的段头的
数据段 ::

    gmt convert -S~"/^profile [0-9]+[g-l]$/"

对表数据文件中的段的顺序反转，但反转段中数据的顺序 ::

    gmt convert lots_of_segments.txt -Is > last_segment_first.txt

以 2 为步长，提取段号为 20 到 40，以及段号为 0 的数据段 ::

    gmt convert lots_of_segments.txt -Q0,20:2:40 > my_segments.txt

假定存在如下 OGR/GMT 格式的文件 ::

    # @VGMT1.0 @GPOINT
    ...
    # @NELEVATION|DISPX|DISPY
    # @Tdouble|double|double
    # FEATURE_DATA
    # @D4.945000|-106500.00000000|-32700.00000000
    -9.36890245902635 39.367156766570389

对上述文件，使用 |SYN_OPT-a| 提取属性 ELEVATION 的数据（下述两种等价） ::

    gmt convert file.gmt -a2=ELEVATION > xyz.dat
    gmt convert file.gmt -aELEVATION > xyz.dat

将文件 :file:`sensors.txt` 中的所有点与指定的远点 23.5/19 相连 ::

    gmt convert sensors.txt -F23.5/19 > lines.txt

将文件 :file:`A.txt` 与 :file:`B.txt` 中的所有数据段写到 profile_005000.txt，
profile_005001.txt ... 等单独的文件中::

    gmt convert A.txt B.txt -Dprofile_%6.6d.txt+o5000

从文件中提取 100-200 以及 500-600 行 ::

    gmt convert junk.txt -q100-200,500-600 > subset.txt

提取除了 1000-2000 行以外的所有行 ::

    gmt convert junk.txt -q~1000-2000 > good.txt

相关模块
--------

:doc:`gmtinfo`,
:doc:`gmtselect`
