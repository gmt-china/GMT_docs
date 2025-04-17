.. index:: ! mgd77magref
.. include:: common_SYN_OPTs.rst_

mgd77magref
===========

:官方文档: :doc:`gmt:supplements/mgd77/mgd77magref`
:简介: 计算 IGRF 或 CM4 地磁参考场模型值

**mgd77magref** 在特定的时间和位置计算 IGRF 或 CM4 地磁参考场模型值。

语法
----

**gmt mgd77magref** [ *inputfile* ]
[ |-A|\ [**+a**\ *alt*\ ][**+t**\ *date*\ ][**+y**] ]
[ |-C|\ *cm4file* ]
[ |-D|\ *Dstfile* ]
[ |-E|\ *f107file* ]
[ |-F|\ *flags* ]
[ |-G| ]
[ |-S|\ **c**\|\ **l**\ *low/high* ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-b| ]
[ |SYN_OPT-f| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT-o| ]
[ |SYN_OPT-:| ]
[ |SYN_OPT--| ]

可选选项
--------

*inputfile*
    输入文件，其中包含时间和空间信息，前两列必须为经纬度，正常情况下，第三列第四列必须
    是海拔（km）和时间，但如果这两个参数对所有数据都是恒定的，则可以通过 **-A** 选项
    指定，这时输入文件中就不包含对应的列。如果没有输入文件，则从标准输入中读取数据。

    关于 CM4 的说明：CM4 的核心场的有效期为 1960-2002.5，但电离层和磁层场是在 *Dst*
    和 *F10.7* 系数文件之后计算的。GMT 最初将这些系数文件扩展到 2006 年，GMT 4.5.3 版本
    后将这些系数扩展到 2009 年，但后面的部分可能不可靠。新的索引文件可以从下面网址下载

    - *Dst* 系数 ftp://ftp.ngdc.noaa.gov/STP/GEOMAGNETIC_DATA/INDICES/DST/
      ftp://ftp.ngdc.noaa.gov/STP/GEOMAGNETIC_DATA/INDICES/EST_IST/
      上述网址已经停止更新，最新的数据可从下面的网址下载
      http://wdc.kugi.kyoto-u.ac.jp/dstae/index.html

    - *F10.7* 索引文件 http://umbra.nascom.nasa.gov/sdb/yohkoh/ys_dbase/indices_flux_raw/Penticton_Absolute/monthly/MONTHPLT.ABS
      上述网址已经停止更新，最新的数据可以从下面网址下载
      ftp://ftp.ngdc.noaa.gov/STP/space-weather/solar-data/solar-features/solar-radio/noontime-flux/penticton/penticton_absolute/listings/listing_drao_noontime-flux-absolute_monthly.txt

.. _-A:

**-A**\ [**+a**\ *alt*\ ][**+t**\ *date*\ ][**+y**]
    指定输入文件被解析的形式。**+a** 用来设置固定的海拔 *alt* (km)，[默认使用数据的
    第三列作为海拔]，**+t** 用来设置固定时间 *data*，[默认使用数据的第四列作为时间]，
    **+y** 表示所有的时间都为小数年的形式 [默认为 *dateTcolck* 格式，见 :term:`TIME_EPOCH`]

.. _-C:

**-C**\ *cm4file*
    指定备用的 CM4 参数文件 [umdl.CM4]

.. _-D:

**-D**\ *Dstfile*
    指定备用文件，其内容为 CM4 小时平均的 *Dst* 索引 [Dst_all.wdc].
    也可以指定单个索引，用于所有的数据

.. _-E:

**-E**\ *f107file*
    指定备用文件，其中包含 CM4 absolute F10.7 solar radio flux [F107_mon.plt].
    也可以指定单个索引用于所有的数据

.. _-F:

**-F**\ *flags*
    选择输出项，*flags* 包含一个或者多个字符：

    **r** means output all input columns before adding the items below

    **t** means list total field (nT).

    **h** means list horizontal field (nT).

    **x** means list X component (nT, positive north).

    **y** means list Y component (nT, positive east).

    **z** means list Z component (nT, positive down).

    **d** means list declination (deg, clockwise from north).

    **i** means list inclination (deg, positive down).

    追加数字可以表明磁场模型的贡献：

    **0** means IGRF field (no combinations allowed)

    **1** means CM4 Core field

    **2** means CM4 Lithospheric field

    **3** means CM4 Primary Magnetospheric field

    **4** means CM4 Induced Magnetospheric field

    **5** means CM4 Primary ionospheric field

    **6** means CM4 Induced ionospheric field

    **7** means CM4 Toroidal field

    **9** means Core field from IGRF and other contributions from CM4.

    **注** ：不要同时使用 **0** 和 **9** 。
    将上述数字（1-7）并列可以得到组合效果，例如 **-Ft**/**12** 将计算 Core field 和 
    Lithosoheric 产生的总场。**-Ft**/**934** 为使用 IGRF 的 Core field 和 CM4 的 
    Primay 和 Induced Magetospheric field 相加的结果。输出数据的格式与字符出现的顺序
    有关，默认为 **-Frthxyzdi**/**1** ，也可以使用 **-o** 选项进一步筛选。

.. _-G:

**-G**
    指定坐标为地心坐标，默认为大地坐标

.. _-L:

**-L**
    计算外部源的 J field vector.

    **r** means output all input columns before adding the items below (all in Ampers/m).

    **t** means list magnitude field.

    **x** means list X component.

    **y** means list Y component.

    **z** means list Z or current function Psi.

    追加数字可以表明贡献：

    **1** means Induced Magnetospheric field.

    **2** means Primary ionospheric field.

    **3** means Induced ionospheric field.

    **4** means Poloidal field.

.. _-S:

**-Sc**\ *low/high*
    通过球谐系数的阶数来限制 core field（地核？）贡献的波长在给定的阶数范围内 [1/13]

**-Sl**\ *low/high*
    通过球谐系数的阶数来限制岩石圈贡献的波长在给定的阶数范围内 [14/65]

.. include:: explain_-V.rst_

.. include:: explain_-bi.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-h.rst_

.. include:: explain_-ocols.rst_

.. include:: explain_colon.rst_

.. include:: explain_help.rst_

时间设置
--------

如果输入文件为二进制，则绝对时间被保存为相对于选定的历元（某个时刻）的相对时间。但是由于
参考历元并没有保存在数据文件中，因此解码绝对时间可能会出现问题。这种情况下，MGD77 默认使
用 Unix 系统时间，因此，用户需要确保带时间的二进制数据使用相同的时间系统，见 
:term:`TIME_SYSTEM`

示例
----

在给定的点，十进制时间为 2000.0 时，计算除岩石圈和 toroidal field 外所有的贡献的 CM4 
Total field，偏角和倾角 ::

    echo -28 38 0 2000.0 | gmt mgd77magref -A+y -Ftdi/13456

与上例计算相同，但时间修改为 2001 年 5 月 1 日 12 点 ::

    echo -28 38 0 2001-05-01T12:00:00 | gmt mgd77magref -Ftdi/13456

参考
----

CM4 见 `<https://doi.org/10.1111/j.1365-246X.2004.02421.x>`__

IGRF 见 `<https://www.ngdc.noaa.gov/IAGA/vmod/igrf.html>`__

相关模块
--------

:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77manage`,
:doc:`mgd77path`,
:doc:`mgd77track`,
:doc:`mgd77sniffer`,
:doc:`mgd77track`
