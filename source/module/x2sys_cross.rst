.. index:: !x2sys_cross
.. include:: common_SYN_OPTs.rst_

x2sys_cross
===========

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_cross`
:简介: 计算轨迹之间的交叉点 

**x2sys_cross** 用来确定轨迹之间所有的交叉点，并输出时间，
位置，沿轨距离，朝向，速度以及交叉点不符值和所有观测的平均值。
默认地，**x2sys_cross** 会同时计算内部和外部的交叉点。

语法
----

**gmt x2sys_cross** *track(s)* |-T|\ *TAG* [ |-A|\ *pairs* ]
[ |-C|\ [*runtimes*] ]
[ |-D|\ [**S**\|\ **N**] ]
[ |-I|\ **l**\|\ **a**\|\ **c** ]
[ |-Q|\ **e**\|\ **i** ]
[ |-S|\ **l**\|\ **u**\|\ **h**\ *speed* ]
[ |SYN_OPT-V| ]
[ |-W|\ *size* ] [ |-Z| ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT--| ]


必选选项
--------

*tracks*
    可以是一个或者多个 ASCII，二进制或 COARDS NetCDF 1-D 沿轨数据文件。
    如果输入的沿轨数据文件很多，可以把所有的文件名放在一个轨迹列表文件中，
    然后使用 = 后紧跟轨迹列表文件名的形式，例如，如果轨迹列表文件名为
    tracks.lis，即为 =tracks.lis 。如果 tracks.lis 中的轨迹文件名不包含
    后缀， gmt 将自动根据 TAG 添加后缀。gmt 将首先在当前文件夹下搜索这些
    轨迹文件，如果设置了 **$X2SYS\_HOME**/*TAG*/*TAG*\ \_paths.txt 的话，然后在
    该文件中包含的路径中查找。如果没有设置 **$X2SYS_HOME** ，默认设置为
    **$GMT_SHAREDIR**\/x2sys。

.. _-T:

**-T**\ *TAG*
    指定 x2sys TAG，参见 :doc:`x2sys_init`

可选选项
--------

.. _-A:

**-A**\ *pairs*
    只处理 *pairs* 文件中包含的轨迹对 [默认对所有的轨迹对计算交叉点]。
    *pairs* 可以使用 :doc:`x2sys_get` 的 |-L| 选项生成。

.. _-C:

**-C**\ [*runtimes*]
    将每个轨迹对的计算时间添加到进程信息中，使用 *runtimes* 文件来保存这些
    信息。此选项的目的是通过所有的计算时间来将其分配到子进程中，使用多进程
    加速计算。参见 x2sys 源码中的 MATLAB 函数 *split_file4coes.m*

.. _-D:

**-D**\ [**S**\|\ **N**]
    控制地理坐标的处理方式（笛卡尔坐标不受影响）。
    默认地，GMT 确定离数据最近的极点，然后，使用圆柱极转换来避免经度跳变带来的问题。
    用户可以使用 |-D| 选项来关闭这个设置，这样就会使用原始的数据计算（GMT 有
    经度跳变保护）。但是，用户也可以自己选择极点，**S** 或者 **N** 分别代表
    南极和北极。之所以使用这种转换是因为 GMT 的交叉点寻找算法是继承自笛卡尔
    坐标的，这种算法在高纬度地区有较大的经度范围分布的数据计算时可能会出问题。

.. _-I:

**-Il**\|\ **a**\|\ **c**
    设置计算交叉点上的值使用的内插算法：

    **l** 线性插值 [默认]

    **a** Akima 样条插值

    **c** 三次样条插值

.. _-Q:

**-Qe**\|\ **i**
    **e** 表示只计算外部交叉点，**i** 表示只计算内部交叉点 
    [默认计算所有的交叉点]

.. include:: explain_-R.rst_

.. _-S:

**-Sl**\|\ **u**\|\ **h**\ *speed*
    定义速度窗口，如果速度超过该窗口范围，就不计算交叉点：

    **-Sl** 设置低速限

    **-Su** 设置高速限

    **-Sh** 不限制速度，但是设置一个较低的速度，如果低于该速度，
    就不计算朝向（即设置为 NaN）[默认计算朝向，不计算速度]

.. _-W:

**-W**\ *size*
    指定在计算交叉点上的观测值时使用样条插值在任一侧的最大数据点数 [默认为 3 ]

.. _-Z:

**-Z**
    只输出在交叉点处每个测线的值 [默认输出每个测线的值和平均值]

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_help.rst_

其他
----

交叉点不符值会以 ASCII 格式（除非设置了 **-bo** ）输出到标准输出。
输出数据的第一行为 TAG，第二行为运行的命令，
第三行为每列的名称。这三个记录作为头部信息，前面都有 # 。
对于每对轨迹，将另有注释信息用来记录两个轨迹文件的名称，
起始/结束/距离信息，如果观测文件中有时间，起始/结束为绝对时间，
如果没有，设置为 NaN；距离为整个轨迹的长度。
下一行为交叉点数据记录，包括两个轨迹的 x 坐标，y 坐标，时间，距离，
朝向，速度，接下来是选择的观测量。
内插算法建议使用 Akima 样条内插，这种算法对离群值敏感度较小。

符号传统
--------

如果 track_a 和 track_b 按此顺序被输入到命令中，则交叉点不符值为
Value(track_a) - Value(track_b)。

精度和格式
----------

每列的输出格式通过 :term:`FORMAT_FLOAT_OUT` 控制，如果是地理坐标，则为
:term:`FORMAT_GEO_OUT` ，时间通过 :term:`FORMAT_DATE_OUT` 和
:term:`FORMAT_CLOCK_OUT` 控制。请确保这些设置可以满足精度需求。

示例
----

计算 :file:`2104.gmt` 文件的内部交叉点，TAG 设置为 GMT ::
    
    gmt x2sys_cross c2104.gmt -TGMT > c2104.txt

计算测深文件 :file:`A13232.mgd77` 和 :file:`A99938.mgd77` 之间的交叉点，
TAG 设置为 MGD77 ::

    gmt x2sys_cross A13232.mgd77 A99938.mgd77 -Qe -TMGD77 > crossovers.txt

参考文献
--------

Wessel, P. (2010), Tools for analyzing intersecting tracks: the x2sys
package. *Computers and Geosciences*, **36**, 348-354.

Wessel, P. (1989), XOVER: A cross-over error detector for track data,
*Computers and Geosciences*, **15**\ (3), 333-346.

相关模块
--------

:doc:`x2sys_binlist`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_init`,
:doc:`x2sys_merge`
