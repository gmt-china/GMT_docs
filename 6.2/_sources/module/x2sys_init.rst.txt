.. index:: ! x2sys_init
.. include:: common_SYN_OPTs.rst_

x2sys_init
==========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_init`
:简介: 初始化 x2sys 数据库

x2sys
-----

**交叉点分析** ：在船测、航测或卫星等手段观测的沿轨数据中，
多次观测的轨迹存在一定的交叉，在交叉点处，
对于不存在时变或时变较小的重力异常、海深、地形或海面高等观测量，
由于其位置相同，因此理论上是相等的。
但由于系统误差的影响，在交叉点处的观测值通常存在一定的差距（称为交叉点不符值）。
交叉点分析的主要作用为通过计算交叉点，并对交叉点的不符值进行处理以削弱系统误差。

**x2sys**\（Track Crossover Analysis Tools, 沿轨交叉点分析包）
即是一套用于寻找沿轨观测数据之间交叉点并进行分析的工具集。
其中，沿轨观测数据可以是二维笛卡尔坐标或地理坐标，
交叉点可以为不同轨迹或同一轨迹之间的相交的点。
工具集主要包括交叉点计算、交叉点不符值统计、交叉点平差（削弱系统误差）等相关分析功能。
x2sys 基于 x_system，不同之处在于，x2sys 使用了新的寻找交叉点的算法，
并且能处理多种格式的沿轨观测数据，例如 NetCDF 格式。
目前，x2sys 随 GMT 一同发布，其主要功能均包含在 GMT 中，分为多个命令。 

**x2sys** 包括的命令：

- x2sys_init 用于初始化特定的沿轨观测数据库，是使用整个 x2sys 包中其他命令的基础。
  使用 **x2sys_init** 命令指定的标签 TAG 是后续命令中必须的关键参数。
- :doc:`supplements/x2sys/x2sys_binlist` 将创建一个粗略的列表，
  用于表示每个轨迹数据的位置以及观测数据个数等信息
- :doc:`supplements/x2sys/x2sys_put` 用于更新轨迹数据库
- :doc:`supplements/x2sys/x2sys_get` 用于寻找在给定区域内的轨迹
- :doc:`supplements/x2sys/x2sys_cross` 计算给定轨迹列表中的轨迹的交叉点
- :doc:`supplements/x2sys/x2sys_report` 统计交叉点信息
- :doc:`supplements/x2sys/x2sys_list` 筛选交叉点
- :doc:`supplements/x2sys/x2sys_solve` 基于 x2sys_cross 确定的交叉点进行交叉点平差
- :doc:`supplements/x2sys/x2sys_datalist` 提取交叉点平差后的改正值，以便后续分析
- :doc:`supplements/x2sys/x2sys_merge` 合并交叉点列表

.. note::

    使用 x2sys_init 命令前，需首先设置环境变量 ``X2SYS_HOME`` 为某个拥有写权限的文件夹，
    以便 x2sys 可跟踪具体的设置。

语法
----

**gmt x2sys_init** 
*TAG* 
|-D|\ *fmtfile*
[ |-E|\ *suffix* ]
[ |-F| ]
[ |-G|\ **d**\|\ **g** ]
[ |-I|\ *dx*\ [/*dy*] ]
[ |-N|\ **d**\|\ **s**\ *unit* ]
[ |SYN_OPT-R| ]
[ |SYN_OPT-V| ]
[ |-W|\ **t**\|\ **d**\ *gap* ]
[ |SYN_OPT-j| ]
[ |SYN_OPT--| ]

必选选项
--------

*TAG*
    数据类型的标签，x2sys_init 将创建一个以 *TAG* 命名的文件夹来保存相关信息

.. _-D:

**-D**\ *fmtfile*
    *fmtfile* 文件定义了当前处理的数据文件的格式（见下文中的格式定义）。
    如果 *fmtfile* 不在当前文件夹下，则需要指定完整路径。
    如果 **-D** 选项没有指定，GMT 将自动使用 *TAG*\ .fmt，不管其是否存在。
    **注** ：已经弃用的 ``.def`` 后缀的文件可以正常工作，但不推荐使用，应该考虑改变后缀。

可选选项
--------

.. _-E:

**-E**\ *suffix*
    指定处理数据文件的后缀。如果不给定，GMT 将使用 **-D** 选项中的前缀作为后缀（见 **-D** 选项）。

.. _-F:

**-F**
    如果 **TAG** 文件夹存在，将强制创建新的文件夹 [默认存在旧的文件夹时，不创建新文件夹]。    

.. _-G:

**-Gd**\|\ **g**
    选择使用地理坐标。追加 **d** 表明经度范围为 -180 到 180 度。
    追加 **g** 表明经度范围为 0 到 360 度。

.. _-I:

**-I**\ *dx*\ [/*dy*]
    **-I** 选项主要用来指定在 :doc:`gmt:supplements/x2sys/x2sys_binlist` 
    模块中创建的网格的间隔，*dx* 为横向间隔，*dy* 为纵向间隔，*dy* 为可选的，
    不指定时，使用 *dx* 作为纵向间隔。
    追加 *m* 或 *s* 用来指定间隔在地理坐标中的单位为角分或角秒。

.. _-N:

**-Nd**\|\ **s**\ *unit*
    设置其他后续模块中需要使用的距离和速度的单位。
    **d** 表示距离，**s** 表示速度，然后可以分别指定距离和速度的单位。
    
    - **c** 表示笛卡尔坐标下的距离或速度
    - **e** m 或 m/s，
    - **f** feet 或 feet/s
    - **k** km 或 kms/hr
    - **m** miles 或 miles/hr
    - **n** nautical miles 或 knots
    - **u** survey feet 或 survey feet/s). 

    默认地，当使用了 **-G** 选项时，设置为 **-Ndk** **-Nse** （km 和 m/s），
    其他情况设置为 **-Ndc** 和 **-Nsc** 。

.. include:: explain_-R.rst_

.. include:: explain_-V.rst_

.. _-W:

**-Wt**\|\ **d**\ *gap*
    该选项主要用于考虑轨迹数据中的缺失点或观测间隔很大的点。
    **t** 设置最大的时间间隙 *gap* （使用用户定义的单位，通常为秒）；
    **d** 设置最大的距离间隙 *gap* （单位见 **-N** 选项）。
    若交叉点两侧的数据点之间的时间或距离大于 *gap* , 
    则认为当前轨迹数据存在缺失数据，不用来计算交叉点并平差。

.. include:: explain_distcalc.rst_

.. include:: explain_help.rst_

格式定义文件
------------

\*.fmt 文件定义了观测数据的格式，主要包括两个部分：(1) 头部信息；(2) 列信息。

头部信息
~~~~~~~~

所有的头部信息均以字符 ``#`` 开头，后面紧跟一个大写的指令。
如果指令可以接收一个参数，则指令和参数之间必须使用空格分隔。
在头部信息的末尾可以使用 ``#`` 添加额外的注释信息。
可识别的指令包括下面几个：

1. **ASCII** 用来表明该数据文件为 ASCII 格式
2. **BINARY** 表明该数据文件为二进制格式
3. **NETCDF** 表明该数据文件为 1-D netCDF 格式
4. **SKIP** 可接收一个参数，表示读取 ASCII 格式的数据文件时跳过的行数或
   读取二进制文件时跳过的字节数
5. **GEO** 表明数据文件的坐标为地理坐标，与 **-G** 的作用相同
6. **MULTISEG** 表明每个文件均包括多段数据，中间使用 GMT 段分隔符分开（不适用于 netCDF 格式）

列信息
~~~~~~

列信息中包含多行，其中每行表示不同的变量，每行都含有 7 列，每列均代表特殊的含义：

*name type NaN NaN-proxy scale offset oformat*

1. *name* 变量的名称。其中，坐标是必须的变量，且其名称只能为 *lon* 和 *lat* 
   （笛卡尔坐标时为 *x* 和 *y* ）。时间变量为可选的，*time* 表示绝对时间，
   *rtime* 表示相对时间，使用相对时间时，需确保 :term:`TIME_UNIT` 和 :term:`TIME_EPOCH`
   设置正确。无论使用的时间是绝对时间还是相对时间，输出结果中都使用绝对时间。
2. *type* 数据类型
       
    - **a** （ASCII 文件）数字
    - **c** （二进制文件）1 字节有符号整型
    - **u** （二进制文件）1 字节无符号整型
    - **h** （二进制文件）2 字节有符号整型
    - **i** （二进制文件）4 字节有符号整型
    - **f** （二进制文件）4 字节浮点型
    - **d** （二进制文件）8 字节浮点型
    - **d** （netCDF 文件）自动确定数据类型

3. *NaN* 是否使用某个数字代替 NaN，若是，则为 *Y*，否则为 *N*
4. *NaN-Proxy* 用来代替 NaN 的数字，若使用 99999.0 代替 NaN，则 *NaN* 为 *Y*，
   *NaN-Proxy* 为 99999.0
5. *scale* 设置对数据使用的缩放倍数
6. *offset* 设置对数据使用的偏移量
7. *oformat* 使用 C 语言格式的字符串指定数据的格式，如果该项设置为 ``-`` ，
   则使用 GMT 的格式机制，相关的设置参数包括 :term:`FORMAT_FLOAT_OUT` ，
   :term:`FORMAT_GEO_MAP` ，:term:`FORMAT_DATE_MAP` ，:term:`FORMAT_CLOCK_MAP`

内置格式定义文件
~~~~~~~~~~~~~~~~

GMT 内置了一些格式定义文件，包括：

- mgd77  普通 mgd77 ASCII 文件
- mgd77+ 增强型的 mgd77+ netCDF 文件
- gmt  旧的 mgg 二进制文件
- xy   普通的 x,y ASCII 表文件
- xyz  与 *xy* 相同，但包括 z 值
- geo  普通的经纬度 ASCII 文件
- geoz 与 *geo* 相同，但包含 z 值

如果用户的轨迹数据文件为上述类型中的某一种，例如为普通的 magd77 ASCII 文件，
可以之间使用 **-Dmgd77** ，无需手动编写格式定义文件。
以上格式定义文件均可在 **GMT_SHAREDIR** 目录下的 x2sys 文件夹中找到。

示例
----

这里将给出使用 x2sys 管理大量沿轨观测文件的步骤。

**ASCII 文件**

假定观测数据文件的格式为：2 行头部信息，然后为观测数据，共 6 列，分别为
lat，lon，time，obs1，obs2，obs3，后缀为 .trk 。

（1）首先创建一个用来定义数据格式的文件 :file:`line.fmt` ，其内容为::

    # Format define file for the line format
    #SKIP 2
    #GEO
    #name   type    NaN     NaN-proxy   scale   offset  oformat
    lat     a       N       0           1       0       %9.5f
    lon     a       N       0           1       0       %10.5f
    time    a       N       0           1       0       %7.1f
    obs1    a       N       0           1       0       %7.2f
    obs2    a       N       0           1       0       %7.2f
    obs3    a       N       0           1       0       %7.2f

（2）接下来，创建 TAG 和数据库。假定数据均为地理坐标，使用 1x1 度的网格来
为这些沿轨观测文件建立索引，并计算沿轨距离，单位为 km，速度单位为节::

    gmt x2sys_init LINE -V -G -Dline -Rg -je -Ndk -Nsn -I1/1 -Etrk

这里设置 TAG 为 LINE。当 x2sys 试图读取观测数据时，将首先在当前文件夹中寻找数据，
然后在 :file:`LINE_paths.txt` 中查找其他的目录列表。因此，这里创建 :file:`LINE_paths.txt`
文件，内容为完整的数据所在的路径。

所有的 TAG 相关的文件，包括格式定义文件，TAG 文件以及创建的数据库等将保存在
**$X2SYS_HOME**\ /*TAG* 文件夹中，此处为 **$X2SYS_HOME**\ /LINE。
**x2sys_init** 将会复制 **-D** 选项设置的 \*.fmt 到该文件夹下，以便后续的 x2sys 命令使用。

（3）创建 tbf 文件。使用 **x2sys_init** 创建数据库以后，可以使用下面两步填充数据库。
首先运行 :doc:`gmt:supplements/x2sys/x2sys_binlist` ，使用沿轨观测文件创建一个或多个多段
轨迹网格索引文件（track bin-index file，tbf）。文件中的信息包括：每个轨道经过哪些
1x1 度（见 **-I** ）的网格，以及含有哪些观测（这里为 obs1，obs2，obs3，
但并非所有的轨迹都含有这 3 种观测）。
例如：如果用于将所有的数据文件名保存在 :file:`tracks.lis` ，则可以运行::

    gmt x2sys_binlist -V -TLINE =tracks.lis > tracks.tbf

（4）更新索引数据库。填充数据库的第二步即为更新索引数据库。使用
:doc:`gmt:supplements/x2sys/x2sys_put` 将 tbf 文件中的信息插入到 TAG 数据库中::

    gmt x2sys_put -V -TLINE tracks.tbf

（5）查找数据。使用 :doc:`gmt:supplements/x2sys/x2sys_get` 可以查找位于指定范围内的轨迹，
并且可以限制特定的观测值组合的轨迹，例如，寻找所有同时包含 obs1 和 obs3 并位于某一区域的轨迹::

    gmt x2sys_get -V -TLINE -R20/40/-40/-20 -Fobs1,obs3 > tracks.tbf

**MGD77[+] 文件**

GMT 已经自带了 MGD77，MGD77+ 以及 mgg 观测数据的格式定义文件。
对于这些数据，设置 **-j** 和 **-N** 将默认使用大圆距离，单位为 km，速度单位为 m/s。
由 NCEI 创建的 MGD77 数据可使用下面命令初始化::

    gmt x2sys_init MGD77 -V -Dmgd77 -Emgd77 -Rd -Gd -Nsn -I1/1 -Wt900 -Wd5

这里设置轨迹中相邻观测超过 15 分钟（即 900 秒）或者大于 5 km 即认为存在数据缺失；设置速度为节。

**二进制文件**

假定用户的观测文件中有 128 个字节的头部信息，接下来为数据记录，其中 lon，lat，time 为双精度数，
另有三种观测量为 2 字节整数，且需要乘以 0.1 。前两种观测量使用 -32768 表示没有获得观测值。
因此，可以定义一个 :file:`line.fmt` 为::

    # Format define file for the binary line format
    #BINARY
    #SKIP 128
    #GEO
    #name   type    NaN     NaN-proxy   scale   offset  oformat
    lat     d       N       0           1       0       %9.5f
    lon     d       N       0           1       0       %10.5f
    time    d       N       0           1       0       %7.1f
    obs1    h       Y       -32768      0.1     0       %6.1f
    obs2    h       Y       -32768      0.1     0       %6.1f
    obs3    h       N       0           0.1     0       %6.1f

**1-D netCDF 文件**

最后，假定用户的观测文件为 netCDF 格式，且符合 COARDS 约定，含有同样的观测数据，即
lon，lat，time，obs1，obs2，obs3，则格式定义文件为::

    # Format define file for the netCDF COARDS line format
    #NETCDF
    #GEO
    #name   type    NaN     NaN-proxy   scale   offset  oformat
    lat     d       N       0           1       0       %9.5f
    lon     d       N       0           1       0       %10.5f
    time    d       N       0           1       0       %7.1f
    obs1    d       N       0           1       0       %6.1f
    obs2    d       N       0           1       0       %6.1f
    obs3    d       N       0           1       0       %6.1f

netCDF 观测文件通常不需要设置 scale 以及 NaN，因为这些都包含在 netCDF 自己的格式描述中。

废弃用法
--------

格式定义文件过去使用 .def 作为后缀，由于 GMT 的符号文件也使用该后缀，因此目前已经弃用该扩展名，
现在使用的后缀为 .fmt，但 .def 仍然可以正常工作。

相关模块
--------

:doc:`gmt:supplements/x2sys/x2sys_binlist`,
:doc:`gmt:supplements/x2sys/x2sys_datalist`,
:doc:`gmt:supplements/x2sys/x2sys_get`,
:doc:`gmt:supplements/x2sys/x2sys_list`,
:doc:`gmt:supplements/x2sys/x2sys_put`,
:doc:`gmt:supplements/x2sys/x2sys_report`,
:doc:`gmt:supplements/x2sys/x2sys_solve`,
:doc:`gmt:supplements/x2sys/x2sys_cross`,
:doc:`gmt:supplements/x2sys/x2sys_merge`
