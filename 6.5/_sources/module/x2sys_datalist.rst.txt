.. index:: !x2sys_datalist
.. include:: common_SYN_OPTs.rst_

x2sys_datalist
==============

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_datalist`
:简介: 提取轨迹观测数据

**x2sys_datalist** 读取一个或多个文件沿轨观测数据，根据一定规则，
提取满足规则的数据。

语法
----

**gmt x2sys_datalist** *track(s)* **-T**\ *TAG*
[ |-A| ]
[ |-E| ]
[ |-F|\ *name1*,\ *name2*,... ]
[ |-I|\ [*list*] ]
[ |-L|\ [*corrections*] ]
[ |SYN_OPT-R| ]
[ |-S| ] [
[ |SYN_OPT-V| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT--| ]


必选选项
--------

*tracks*
    可以是一个或者多个 ASCII，二进制或 COARDS netCDF 1-D 沿轨数据文件。
    如果输入的沿轨数据文件很多，可以把所有的文件名放在一个轨迹列表文件中，
    然后使用 = 后紧跟轨迹列表文件名的形式，例如，如果轨迹列表文件名为
    tracks.lis，即为 =tracks.lis 。如果 tracks.lis 中的轨迹文件名不包含
    后缀， gmt 将自动根据 TAG 添加后缀。gmt 将首先在当前文件夹下搜索这些
    轨迹文件，如果设置了 **$X2SYS\_HOME**/*TAG*/*TAG*\ \_paths.txt 的话，然后在
    该文件中包含的路径中查找。如果没有设置 **$X2SYS_HOME** ，默认设置为
    **$GMT_SHAREDIR**\/x2sys。

.. note::

    对于 MGD77 格式的轨迹数据，同时还在 **MGD77_HOME**\/mgd77_paths.txt 
    中的路径和位于 \*.gmt 中的 **$GMT_SHAREDIR**\/mgg/gmtfile_paths 中查找
    轨迹数据。

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init` 

可选选项
--------

.. _-A:

**-A**
    通过轨迹的权重来消除两个轨迹在交叉点的不符值

.. _-E:

**-E**
    输出两个轨迹的信息作为头部信息 [默认不写入这些头部信息]

.. _-F:

**-F**\ *name1*,\ *name2*,...
    指定要输出的变量列表，每个变量以逗号分隔[默认输出所有列]

.. _-I:

**-I**\ [*list*]
    *list* 为轨迹列表文件名，其中包含若干轨迹文件名，这些轨迹将不参与计算
    [默认包含所有的轨迹]

.. _-L:

**-L**\ [*corrections*]
    如果存在改正值，对观测量进行最优改正，*corrections* 为改正表，该改正表可以由 :doc:`x2sys_solve` 生成
    [默认使用位于 **$X2SYS_HOME**/*TAG* 文件夹中的 TAG_corrections.txt]
    对于改正表文件的格式，见 `Corrections`_

.. include:: explain_-R.rst_

.. _-S:

**-S**
    使用该选项后，所有的列均为 NaN 的行将不输出 [默认输出所有行]

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-h.rst_

.. include:: explain_help.rst_


示例
----

从老格式的 MGG 文件 :file:`c2104.gmt` 中提取所有数据::

    gmt x2sys_datalist c2104.gmt -TGMT > myfile

为在其他模块中使用 :file:`track.lis` 文件中包含的所有轨迹，这些轨迹的
TAG 为 TRK，只输出指定范围，并设置为二进制::

    gmt x2sys_datalist =tracks.lis -TTRK -Flon,lat,depth -R40/-30/25/35 -bo > alltopo_bin.xyz

Corrections
-----------

改正值文件是一个 ASCII 文件，其中包含了改正必须的系数和参数。
该文件通常由 :doc:`x2sys_solve` 模块生成，可以使用 # 进行注释，
所有改正值的格式为 ::

    trackID observation correction

其中 *trackID* 是轨迹名称，*observation* 是某个观测量，
*correction* 由一个或多个空格分隔的项 *term* ，观测量输出的时候会减去这些量。
*term* 的语法为 ::

    *factor*\ [\*[*function*]([*scale*](\ *abbrev*\ [-*origin*]))[^\ *power*]]

括号中的项是可选的（必须严格按照指示使用括号）。除了 *term* 之间的空格，
其他部分不能有多余的空格。
*factor* 是基本函数的尺度，可选的基本函数包括 sin，cos 或者 exp。
可选的 *scale* 和 *origin* 可以用来转换参数。
*abbrev* 是 TAG 中指定的某列的缩写，也可以是其他三种 *terms* 。
包括：

    **dist** 沿轨距离

    **vel**  沿轨速度

    **azim** 沿轨方位角

如果 *origin* 指定为 **T** , 这意味着应该使用缩写的值替换第一列（通常
为时间）。如果第一列的值为 NaN ，将 *origin* 置为 0。
*power* 和 *factor* 分别表示对表达式进行幂运算和缩放运算。
下面是对一个名称为 ABC 的轨迹进行改正的例子。
假设 **z** 需要校正线性漂移，**OBS** 需要校正纬度依赖的变化，
**weight** 需要进行常数校正（常数为 1，所以改正值为 -1），
**fule** 需要进行一定的缩放::

    ABC z 7.1 1e-4*((time-T))
    ABC obs 0.5*exp(-1e-3(lat))^1.5
    ABC weight -1
    ABC fuel 0.02*((dist))

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
