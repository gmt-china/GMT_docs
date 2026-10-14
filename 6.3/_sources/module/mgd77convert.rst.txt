.. index:: ! mgd77convert
.. include:: common_SYN_OPTs.rst_

mgd77convert
============

:官方文档: :doc:`gmt:supplements/mgd77/mgd77convert`
:简介: 将 MGD77 数据转换为其他格式

**mgd77convert** 用于实现数据格式转换，支持 pre- 和 post-Y2K MGD77 格式。

语法
----

**gmt mgd77convert** *GEODAS-ids* |-F|\ **a**\|\ **c**\|\ **m**\|\ **t**
|-T|\ **a**\|\ **c**\|\ **m**\|\ **t**\ [**+f**]
[ |-C| ]
[ |-D| ]
[ |-L|\ [**w**][**e**][**+l**] ]
[ |SYN_OPT-V| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

.. _-F:

**-Fa**\|\ **c**\|\ **m**\|\ **t**
    指定输入文件格式:

    - **a** 标准 MGD77 ACSII 格式，后缀为 .mgd77

    - **c** MGD77+ NetCDF 格式，后缀为 .nc

    - **m** MGD77T 格式，后缀为 .m77t

    - **t** tab 分隔的 ASCII 格式，后缀为 .dat

    使用 **-FC** 可以从 MGD77+ 文件中恢复原始的 MGD77 设置 [默认应用 E77 改正]

.. _-T:

**-T**\ **a**\|\ **c**\|\ **m**\|\ **t**\ [**+f**]
    指定输出文件格式:

    - **a** 标准 MGD77 ACSII 格式，后缀为 .mgd77

    - **c** MGD77+ NetCDF 格式，后缀为 .nc

    - **m** MGD77T 格式，后缀为 .m77t

    - **t** tab 分隔的 ASCII 格式，后缀为 .dat

    如果已经存在相应格式的输出文件，GMT 将不会覆盖， **+f** 选项强制覆盖

可选选项
--------

.. _-C:

**-C**
    将 NCEI 的 two-file 数据集中的 \*.h77，\*.a77 转换为单文件的 \*.mgd77。除 |-V| 外，不能和
    其他选项同时使用。输入文件为一个或多个 \*.h77，\*.a77 或者文件名（可不带后缀）。

.. _-D:

**-D**
    默认情况下，MGD77+ netCDF 文件中使用的存储类型远超过 ASCII MGD77 格式的精度。对于
    **faa**，**eot**，**mag**，**diur** 和 **msd** 5 种观测，使用 2 字节整数，表明在
    MGD77 格式中精度为 0.1 mGal，0.1 nTesla 和 1 m。在某些情况下，这些观测可能使用 4 字节
    整数，对应的精度为 10 nGal、10 fTesla 和 0.01 mm。该 |-D| 选项即表明观测为 4 字节整数。

.. _-L:

**-L**\ [**w**][**e**][**+l**]
    设置 verification 报告的级别以及输出的位置，默认不设置该报告，如果设置，默认位置为
    标准错误流。**w** 表示警告，**e** 表示报错，**+l** 选项表示将输出位置改为标准输出。

.. include:: explain_-V.rst_

.. include:: explain_help.rst_

示例
----

将 a77 和 h77 文件对转换为对应的 mgd77 文件::

    gmt mgd77convert -C *.h77

将 01010047.mgd77 和 01010008.mgd77 转换为新的 netcdf 格式，并且输出报告 ::

    gmt mgd77convert 01010047 01010008 -Fa -Tc -V -Lew+l > log.lis

将 01010047.nc 转换为 MGD77 ASCII 格式，并确保与最初的文件相同 ::

    orig=`gmt mgd77path 01010047 -Ic`
    gmt mgd77convert 01010047 -Fc -Ta -V
    diff $orig 01010047.mgd77

将 01010047.nc 转换为普通 ASCII 表数据格式用于手动编辑，并覆盖已经存在的文件 ::

    gmt mgd77convert 01010047 -Fc -Tt+f -V

从 01020051.nc 恢复最初的 NCEI MGD77 版本，并忽略所有的 E77 改正 ::

    gmt mgd77convert 01020051 -FC -Ta -V

文件格式
--------

**mgd77convert** 可用于处理 4 种不同的格式

#. NCEI 目前开始使用 tab 分隔的 MGD77 数据格式，即 MGD77T。除了 MGD77 中所有的信息，MGD77T
   还包括重力，磁以及测深观测的质量标志。

#. MGD77+ NetCDF 格式用于满足科学家的需求发展而来。该格式包含 MGD77 格式中的所有信息，但是
   该格式文件大小为原本格式的 30%，并且数据处理也快很多。

#. MGD77 ASCII 格式即为最初 NCEI 用于分发地球物理数据的标准，但现在已经被 MGD77T 取代。通常，
   只有测量船操作人员和 Cruise PI 可能会参与发送给 NCEI 的 MGD77 SCII 文件制作；用户则不参与
   创建，通常只是读取。

#. 普通 ASCII 格式，使用 tab 分隔，需要手动编辑文件的用户可以使用该格式。这种 tab 分隔列的格式
   显然比 MGD77 punch-card 中将所有列挤到一起更加容易处理。

其他工具
--------

MGD77+ NetCDF 文件符合 CF 1.0 和 COARDS 标准，可以使用 ncBrowse 和 ncView 等
通用工具查看文件信息。

参考
-----

ncBrowse 见 `<https://www.pmel.noaa.gov/epic/java/ncBrowse/>`_

ncView 见 `<https://cirrus.ucsd.edu/~pierce/software/ncview/index.html>`_

MGD77 (Marine Geophysical Data Exchange Format) 格式见
`<https://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`_

相关模块
--------

:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77manage`,
:doc:`mgd77path`,
:doc:`mgd77track`,
:doc:`mgd77sniffer`,
:doc:`mgd77track`,
:doc:`x2sys_init`
