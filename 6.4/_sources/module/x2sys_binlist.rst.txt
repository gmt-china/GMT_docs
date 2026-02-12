.. index:: ! x2sys_binlist
.. include:: common_SYN_OPTs.rst_

x2sys_binlist
=============

:贡献者: |周茂|

----

:官方文档: :doc:`gmt:supplements/x2sys/x2sys_binlist`
:简介: 使用沿轨观测文件创建网格索引列表

**x2sys_binlist** 读取一条或者多条沿轨数据文件，生成一个多段 ASCII
轨迹网格索引文件（tbf），索引文件中，轨迹数据文件名作为头部信息，
每个轨迹经过的网格都为一个数据记录；数据记录包括 *lon*，*lat*，*index*，
*flags*\ [, *dist*]，其中 *lon* 和 *lat* 是网格中心坐标，*index* 是网格在
一维排列下的序号，*flags* 是一个标志，描述了在当前网格中包含了哪几种观测数据。
可选的 *dist* 信息需要 |-D| 选项。输入的轨迹数据文件可以是任意格式，但必须使用
|-T| 选项指定 TAG 以便 gmt 能识别这种格式。网格的索引列表仅能粗略地表示轨迹的
走向并用于建立轨迹数据库以便各种查询。在使用本命令前，必须已经使用
:doc:`x2sys_init` 进行了初始化。

语法
----

**gmt x2sys_binlist** *track(s)* |-T|\ *TAG*
[ |-D| ]
[ |-E| ]
[ |SYN_OPT-V| ]
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

.. _-D:

**-D**
    计算每个和轨迹相交的网格的累积距离。距离的输出位于 *flags* 后。
    距离的单位和 TAG 中的设置一致，见 :doc:`x2sys_init` 中的 |-N| 选项 

.. _-E:

**-E**
    在确定网格索引前，将地理坐标转换为圆柱等面积投影坐标。gmt 会使用
    **-JY**\ *lon0*/37:04:17.166076/360 进行投影，其中 *lon0* 为当前区域
    的中央经度。当轨迹文件为全球/半球区域的地理坐标时，需要 |-D| 选项。
    |-E| 选项在轨迹密度统计时非常有用，但在只构建网格索引时不应该使用。

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

使用 MGD77 文件 :file:`01030061.mgd77` 创建网格索引文件， *TAG* 为 MGD77 ::

    gmt x2sys_binlist 01030061.mgd77 -TMGD77 > 01030061.tbf

使用当前文件夹中所有的 MGD77+ 文件创建网格索引文件，*TAG* 为 MGD77+ ::

    gmt x2sys_binlist *.nc -TMGD77+ -D > all.tbf

相关模块
--------

:doc:`x2sys_init`,
:doc:`x2sys_datalist`,
:doc:`x2sys_get`,
:doc:`x2sys_list`,
:doc:`x2sys_put`,
:doc:`x2sys_report`,
:doc:`x2sys_solve`,
:doc:`x2sys_cross`,
:doc:`x2sys_merge`
