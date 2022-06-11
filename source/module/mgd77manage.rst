.. index:: ! mgd77manage
.. include:: common_SYN_OPTs.rst

mgd77manage
===========

这里首先介绍 mgd77 整个包：

mgd77 模块
----------

本模块主要用来管理和处理美国 NGDC (National Geophysical Data Center，现为
National Centers for Environmental Information，NCEI) 机构下的海洋地球物理
数据。在不同的时期，针对上述数据，NCEI 开发了多种数据格式，MGD77 格式为
1977 年针对沿测线重力，磁，测深以及地震等观测开发的格式，目前已经成为国际
数据交换的标准，并在某个版本中加入了制表符分隔的 MGD77T 格式。目前 **mgd77**
主要包括下面 9 个命令：

- :doc:`mgd77magage` 管理 MGD77+ 文件

- :doc:`mgd77convert` 将 MGD77 数据转换为其他格式

- :doc:`mgd77header` 从 A77 文件创建 MGD77 头部信息

- :doc:`mgd77info` 提取 MGD77 文件信息

- :doc:`mgd77list` 提取 MGD77 文件中的数据

- :doc:`mgd77magref` 计算 IGRF 或 CM4 磁场模型

- :doc:`mgd77path` 返回 MGD77 测线路径

- :doc:`mgd77sniffer` MGD77 测线沿轨质量控制

- :doc:`mgd77track` 绘制 MGD77 测线轨迹

下面将做整体介绍：

**1. 前言**

mgd77 模块的主要功能为

- 改进原本的 mgg 工具集有限的功能

- 实现对数据文件增加新的数据列

- 添加新的格式，即 NetCDF 格式，称为 MGD77+ 或 MGD77+ NetCDF 格式

下面介绍维护文件需要的信息和步骤。

**2. 介绍**

**数据位置** ：**$MGD77_HOME** 环境变量为 mgd77 模块的主要目录，其中包含
一个名为 mgd77_paths.txt 的文件，文件内容为不同的路径，这些路径即为
mgd77 数据文件的位置。如果未设置该环境变量，则默认为设置为
**$GMT_SHAREDIR**/mgd77。

**3. 转换**

使用 :doc:`mgd77convert` 可以将 MGD77 文本文件（.mgd77）转换为 MGD77+ 
NetCDF 格式（.nc）。使用下面的命令可以实现批量转换 ::

    mgd77convert =cruises.lis -Fa -Tc -V -Lwe+l > log.txt

cruises.lis 文件中包含了所有需要转换的文件名。新生成的 nc 文件也可以放在
一个或者多个单独的文件夹中，将其路径列在 mgd77_paths.txt 文件中。建议将
\*.nc 文件夹的路径放在 \*.mgd77 路径之前。使用 **-I** 选项可以选择特定
后缀的文件。

**4. 添加新列**

**mgd77manage** 允许用户添加新数据列到 nc 文件中，包括文本字符串，或从
其他网格模型沿轨采样的点等。最大支持 32 个新数据列。数据提取工具，例如
:doc:`mgd77list` 可用于提取数据列以及用户添加的新列。

**5. 误差源**

在讨论改正 MGD77 数据的误差前，这里首先分析各种观测误差:

#. 头部信息中某些字段不符合 MGD77 规范或缺少该字段时，将会导致错误。
   :doc:`mgd77convert` 在使用较高级别的 **-V** 选项会提示这些错误。
   这些错误通常不会影响数据。

#. 尽管遵循 MGD77 规范，但当特定的数据列编码不正确时，会导致系统误差。
   通常情况下会导致一个固定常数缩放因子，比如，10 或者 0.1，在将 fathom
   转换为 m 时甚至可能出现 1.8288 的因子。

#. 当记录数据或者处理数据时，由于沿轨的纬度、航向或者其他和时间相关的
   因素可能会导致未知的系统误差。这种误差有时可以通过后期的数据分析解决，
   例如沿轨和跨轨的检查，通过数据分析可生成改正项，并应用到数据中改正
   这些误差的影响。但这些改正项在新出现观测数据后可能会变化，因此是
   一种短时间的改正，需要随着数据的加入不断更新。

#. 单个数据或者数据序列可能会超出数据实际范围或者在其他方面突破
   某种限制，这种数据是不符合实际的。此外，即使在实际范围内，也存在
   连续数据突变的情况，这同样是不符合实际的。因此，可以对每个数据点
   生成一个 GOOD 或者 BAD 的标志来标记这些数据。

对于上述误差，目前的策略为，第 1，2 和 4 种误差将通过在 \*.nc 文件
中在元数据提供信息来改正，第 3 种误差的改正则单独保存在改正表中，因为
这些改正通常是不断变化的。

**6. 误差定位**

**mgd77sniffer** 可用来对原始的 MGD77 ASCII 文件进行彻底的沿轨完整性
检查，并生成对应的 \*.e77 错误日志。所有发现的问题都会记录在错误日志
中，如果需要，还会给出建议的改正项。后续专业人员可以验证这些改正项是
否有效。编辑其中的错误并修正改正项，并通过相关的的代码 key 值激活（
请见 :doc:`mgd77sniffer` ）。**mgd77manage** 可以读取这些错误日志，
根据日志中的建议修正错误的头部记录，在读取某些列的时候应用改正项。
如果用户在后续发现其他问题，请重新运行这一步骤，因为所有的 E77 设置
或标志都是根据最新的 E77 文件重新创建的。

**7. 误差改正**

数据提取命令 :doc:`mgd77list` 允许在数据提取时应用改正。过程为首先
剔除带有 BAD 标志的数据，然后应用系统误差改正项，最后，如果制定了改正表，
应用这种暂时的改正。所有这些步骤都需要头部数据，并且可以被用户调整。
此外，用户可以添加自己的标志作为单独的数据列，使用 :doc:`mgd77list`
的逻辑测试来确定输出哪些数据。

下面将介绍 :doc:`mgd77manage` 命令，其他命令见对应文档。

mgd77manage
===========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77manage`
:简介: 管理 MGD77+ 文件

**mgd77manage** 用来处理在 MGD77+ NetCDF 文件中的自定义列。用户可以删除列，增加列，
更新已经存在的列，或使用 e77 文件进行误差改正。新数据可以来自 ASCII 表文件，或基于
现有的列和理论表达式，或对网格进行沿轨采样得到。新数据将以自定义数据列的形式追加
到 MGD77+ 文件中具体见 `mgd77 模块`_ 。

语法
----

**gmt mgd77manage** *GEODAS-ids*
[ |-A|\ **a**\|\ **c**\|\ **d**\|\ **D**\|\ **e**\|\ **E**\|\ **g**\|\ **i**\|\ **n**\|\ **t**\|\ **T**\ *fileinfo*\ [**+f**]\ ]
[ |-D|\ *abbrev1*,\ *abbrev2*,...) ]
[ |-E|\ *empty* ]
[ |-F| ]
[ |-I|\ *abbrev*/*name*/*unit*/**c**/*scale*/*offset*/*comment* ]
[ |-N|\ *unit* ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-bi| ]
[ |SYN_OPT-di| ]
[ |SYN_OPT-j| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

可选选项
--------

.. _-A:

**-A**\ **a**\|\ **c**\|\ **d**\|\ **D**\|\ **e**\|\ **E**\|\ **g**\|\ **i**\|\ **n**\|\ **t**\|\ **T**\ *fileinfo*\ [**+f**]
    添加新的数据列。如果文件中已经存在相同名称的列，则无法添加。**+f** 选项可以
    强制覆盖，但是在某些情况下，这种强行覆盖会失败，需要先删除对应的列，然后再
    添加，出现这种情况时，会警告提示。新增的列时可以使用如下代码，其含义如下：

    - **a** 追加包含要添加的列的文件名。文件的行数必须与 MGD77+ 文件中相同。如果
      不指定文件名，则从标准输入中读取。

    - **c** 从现有的数据或者公式创建新列，用于改正或者作为参考场。其后可以再接一
      个字符，字符的含义如下：

      - **c** 从未改正的测深中减去 Carter 改正

      - **g** IGF 重力参考场（也称为“正常重力”）；使用头部信息中的代码确定计算的公
        式，如果未设置或者无效，则默认使用 IGF1980；代码含义如下：

        - 1 Heiskanen 1924

        - 2 International 1930

        - 3 IGF1967

        - 4 IGF1980

      - **m** IGRF 总磁场参考场

      - **r** 重新计算的磁异常 rmag = mtfx - IGRF，追加 1 或者 2 表示使用的字段

    - **d** 指定一个包含两列数据的文件名，第一列为沿轨距离，第二列为数值。如果
      不指定文件，则从标准输入中读取。MGD77+ 文件中有对应的距离则将被新值取代，
      在其他距离，设置为 NaN。 使用 **-N** 设置距离单位，通过 **-j** 选择距离
      计算方式。

    - **D** 与 **d** 功能类似，但在没有给定距离的点，内插得到其更新值

    - **e** 从当前路径或者 $MGD77_HOME/E77 路径中寻找 :doc:`mgd77sniffrer` 生成
      的 *GEODAS_ID.e77* E77 日志，使用该日志检查数据并修改头部信息，为某些系统
      误差提供改正项（例如缩放尺度和偏移量）
.. _-D:

**-D**\ *abbrev1*,\ *abbrev2*,...)

.. _-E:

**-E**\ *empty*

.. _-F:

**-F**

.. _-I:

**-I**\ *abbrev*/*name*/*unit*/**c**/*scale*/*offset*/*comment*
    

.. _-N:

**-N**\ *unit*
    指定距离单位（见 `距离单位`_ ）[默认为 **-Nk** （km）]。
    只在 **-Ag**\|\ **i** 使用时可用。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-di.rst_

.. include:: explain_distcalc.rst_

.. include:: explain_-n.rst_

.. include:: explain_help.rst_

.. include:: explain_distunits.rst_

示例
----

Credits
-------

IGRF 基于英国地质调查局的 Susan Macmilan 编写的 Fortran 程序，由 Algrave 大学的 Joaquim 通过
f2c 转换到 C 语言，最终 Paul Wessel 改成 GMT 风格。

参考
----

MDG77 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

IGRF 见 `<https://www.ngdc.noaa.gov/IAGA/vmod/igrf.html>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77info`,
:doc:`mgd77track`,
:doc:`mgdsniffer`,
:doc:`mgd77track`
