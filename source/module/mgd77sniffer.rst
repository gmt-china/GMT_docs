.. index:: ! mgd77sniffer
.. include:: common_SYN_OPTs.rst_

mgd77sniffer
============

:官方文档: :doc:`gmt:supplements/mgd77/mgd77sniffer`
:简介: MGD77 沿轨质量控制

**mgd77sniffer** 对旧的（pre-Y2K）以及新的 ASCII MGD77 文件进行逐点健全性检查，包括
沿轨的梯度以及观测数据与重力和测深模型之间的差异。默认情况下，检测到的数据问题通常会
导致每个扫描记录出现多条消息。使用计算机可解析的格式（见 `E77 误差格式`_ ）可选择输
出数据中存在的问题（ **-De** 选项）。默认误差阈值来自 1952 年到 2006 年 1 约期间收集
的所有 MGD77 地球物理数据的直方图。使用 |-L| 选项可以调整阈值。

语法
----

**gmt mgd77sniffer** *GEODAS-ids* [ |-A|\ *fieldabbrev*,\ *scale*,\ *offset* ]
[ |-C|\ *maxspd* ]
[ |-D|\ **d**\|\ **e**\|\ **E**\|\ **f**\|\ **l**\|\ **m**\|\ **s**\|\ **v**\ [**r**] ]
[ |-E| ]
[ |-G|\ *fieldabbrev*,\ *imggrid*,\ *scale*,\ *mode* or |-G|\ *fieldabbrev*,\ *grid* ]
[ |-H| ]
[ |-I|\ *fieldabbrev*,\ *rec1*,\ *recN* ]
[ |-L|\ *custom-limits-file* ]
[ |-M| ]
[ |-N| ]
[ |SYN_OPT-R| ]
[ |-S|\ **d**\|\ **s**\|\ **t** ]
[ |-T|\ *gap* ]
[ |SYN_OPT-V| ]
[ |-W|\ **c**\|\ **g**\|\ **o**\|\ **s**\|\ **t**\|\ **v**\|\ **x** ]
[ |-Z|\ *level* ]
[ |SYN_OPT-bo| ]
[ |SYN_OPT-do| ]
[ |SYN_OPT-n| ]
[ |SYN_OPT--| ]

必选选项
--------

.. include:: explain_ncid.rst_

可选选项
--------

.. _-A:

**-A**\ *fieldabbrev*,\ *scale*,\ *offset*
    将缩放因子和 DC 偏移量添加到指定的字段。注意：在对数据调整前必须仔细检查数据，
    是否能应用于所有测线

.. _-C:

**-C**\ *maxspd*
    以 m/s 为单位设置最大船速，或使用 |-N| 选项设置使用节作为速度单位。默认船速
    超过10 m/s (~ 20 节)即被标记为超过最大船速。

.. _-D:

**-D**\ **d**\|\ **e**\|\ **E**\|\ **f**\|\ **l**\|\ **m**\|\ **s**\|\ **v**\ [**r**]
    抑制默认的警告输出并且仅逐行输出数据值、梯度以及观测值与网格的差、E77 错误总结以及
    新创建的列等。追加 **r** 表示包含所有的数据，默认省略存在导航错误的数据。

    - **-Dd** 输出观测值和网格数据的差值，需要 |-G| 选项，数据信息包括为
      ``lat lon dist cruiseZ gridZ diff [cruiseZ2 gridZ2 diff2 …]``
      
      注：从观测值中减去网格值，因此正值意味着观测值大于网格值，对于多个网格，以命令行
      的顺序展示结果。

    - **-De** 输出 E77 误差分类格式。误差输出被分为头部信息和数据记录，头部信息包含所有
      应用到该测线的信息；数据记录为错误记录。**mgd77sniffer** 将 E77 写入到 <geodas_id.e77>
      文件中，见下面的 `E77 误差格式`_

    - **-DE** 与 **-De** 相同，但是不进行回归测试

    - **-Df** 输出 delta Z 以及 delta S，分别为观测值的差值以及距离的差值。距离的差值对
      不同的观测值来说通常是不同的，因为他们的仪器采样率不同，输出格式信息包括：
      ``d[twt] ds d[depth] ds d[mtf1] ds d[mtf2] ds d[mag] ds d[diur] ds d[msd] ds d[gobs] ds d[eot] ds d[faa] ds``

    - **-Dl** 显示 mgd77sniffer 的限制，该选项的输出可以为 |-L| 选项提供参考。不需要额外
      的参数，数据信息包括 ``fieldabbrev min max maxSlope maxArea``

    - **-Dm** 以符合 Y2K MGD77 格式输出 MGD77 数据

    - **-Dn** 每条记录输出到海岸线的距离。需要 **-Gnav** 选项，输出信息包括：
      ``lat lon dist distToCoast``

    - **-Ds** 输出速度以及地球物理观测的梯度。梯度的类型与 |-S| 设置结果一致（默认为空间梯度），
      输出信息包括
      ``speed d[twt] d[depth] d[mtf1] d[mtf2] d[mag] d[diur] d[msd] d[gobs] d[eot] d[faa]``

    - **-Dv** 显示每个 MGD77 数据记录的十二个字段，顺序为
      ``lat lon twt depth mtf1 mtf2 mag diur msens gobs eot faa``

.. _-E:

**-E**
    反转导航质量标志。在某些情况下，大多数的导航标志被错误设置，这种情况通常发生
    在测量船的第一批观测中。注意，要非常谨慎使用该选项

.. _-G:

**-G**\ *information*
    将船的测量数据和网格数据比较。可食用的格式包括：

    - **-G**\ *fieldabbrev*,\ *imggrid*,\ *scale*,\ *mode* 将测量数据与 Sandwell/
      Smith 网格数据 img 网格数据比较。*fieldabbrev* 为字段的缩写，见 `Mgd77 字段信息`_ ，
      然后为网格文件名 *imggrid* ，网格文件的缩放系数 *scale* ，以及 mode。mode 可
      以为如下值：

      - 0 img 文件不含约束代码，返回所有数据

      - 1 img 文件有约束代码，返回所有数据

      - 2 img 文件有约束代码，只返回在约束处的数据，其他地方设置为 NaN

      - 3 img 文件有约束代码，在约束处返回 1，其他位置返回 0

    - **-G**\ *fieldabbrev*,\ *grid* 将测量数据与其他 GMT 可识别的网格数据比较。
      *fieldabbrev* 为字段缩写，*grid* 为网格文件名。

    该模块同时支持和多个网格比较，只需多次使用 |-G| 选项即可。

    网格比较会激活几种错误检查：

    - 使用船测数据与网格数据进行重新加权最小二乘回归分析确定斜率和偏移。当斜率
      和偏移不为 1 和 0 时，说明船测数据和网格存在一定的差异，可能为船测数据中
      存在不正确的单位或者仪器漂移等。

    - 沿轨迹计算累计的网格和船测数据之间的偏差，并格努 *maxArea* 阈值标记超限
      的值。

    需要注意的是，网格收到测深数据的限制，因此两者之间并不一定是独立的。同时，
    船测测深以及网格测深同时激活了 “navigation crossing over land” 检查。

.. _-H:

**-H**
    只能与 |-G| 选项同时使用。设置计算船测数据与网格数据之间偏差的时机，默认
    情况下，只有在比较了完整的观测数据集后，然后才能通过最小二乘分析得到得到
    可靠的估计。

    - **-Hb** 同时分析临时的结果以及完整数据集的结果，并报告两者中间的优者

    - **-Hd** 不进行临时数据分析，等价于 **-H**

    - **-Hf** 进行临时数据分析

.. _-I:

**-I**\ *fieldabbrev*,\ *rec1*,\ *recN*
    将某个字段 *fieldabbrev* 从 *rec1* 到 *recN* 的数据记录标记为 BAD，可以
    多次使用。

.. _-L:

**-L**\ *custom-limits-file*
    使用文件 *custom-limits-file* 覆盖默认的错误检查限制。字段信息如
    `Mgd77 字段信息`_ 所示。文件中每行均包含一个字段记录，可以包括
    最大值，最小值，最大梯度，最大面积等。最大梯度与 |-S| 选项中设置
    的梯度一致。|-G| 选项使用最大面积作为阈值。使用 **-Dl** 生成的
    信息可以确定该限制文件的具体值， ``mgd77sniffer -Dl -L<yourlimitsfile>`` 。

    下面展示了一个示例文件，其中 ``--`` 表示使用默认值。
    
    +--------------+--------+---------+------------+-----------+
    | # abbrev     | min    | max     | maxSlope   | maxArea   |
    +--------------+--------+---------+------------+-----------+
    | twt          | 0      | 15      | 1          | 0         |
    +--------------+--------+---------+------------+-----------+
    | depth        | 0      | 11000   | 500        | 5000      |
    +--------------+--------+---------+------------+-----------+
    | mag          | -800   | 800     | --         | --        |
    +--------------+--------+---------+------------+-----------+
    | faa          | -300   | 300     | 100        | 2500      |
    +--------------+--------+---------+------------+-----------+

.. _-M:

**-M**
    调整在陆地的导航阈值 [100]

.. _-N:

**-N**
    使用航海单位

.. include:: explain_-R.rst_

.. _-S:

**-S**\ **d**\|\ **s**\|\ **t**
    设置沿轨数据梯度的检查。

    - **-Sd** 计算沿轨数值的差分结果，输出单位为原本数据的单位

    - **-Ss** 计算空间梯度，输出单位为原本数据单位除以 km

    - **-St** 计算时间梯度，输出单位为原本数据单位除以 second [默认]

.. _-T:

**-T**\ *gap*
    对于沿轨数据中的 gap 进行处理。默认情况下，跳过大于 5 km 的数据间隙。
    设置为 0 时则停用跳过间隙

.. _-W:

**-W**\ **c**\|\ **g**\|\ **o**\|\ **s**\|\ **t**\|\ **v**\|\ **x**
    仅打印详细错误信息中的某些警告类型。逗号分隔上述子选项可实现任意组合：

    - **c** 代码警告

    - **g** radient 超出范围

    - **o** 网格偏移，需要 **-G**\|\ **g**

    - **s** 速度超出范围

    - **t** 时间警告

    - **v** 值超出范围

    - **x** 警告的总结

    默认情况下输出所有警告信息。该选项与 |-D| 选项不兼容

.. _-Z:

**-Z**
    标志的回归统计超过指定的置信水平，即 **-Z**\ 5 指出系数 m，b，rms 和 r 超过
    95% 执行水平

.. include:: explain_-V.rst_

.. include:: explain_-bo.rst_

.. include:: explain_-do.rst_

.. include:: explain_-n.rst_

.. include:: explain_help.rst_

Mgd77 字段信息
--------------

+-------------+------------------+-------------+
| *Field*     | *Abbreviation*   | *Units*     |
+-------------+------------------+-------------+
| Two-way     | Travel           | Time        |
+-------------+------------------+-------------+
| Corrected   | Depth            | depth       |
+-------------+------------------+-------------+
| Mag         | Total            | Field1      |
+-------------+------------------+-------------+
| Mag         | Total            | Field2      |
+-------------+------------------+-------------+
| Residual    | Magnetic         | mag         |
+-------------+------------------+-------------+
| Diurnal     | Correction       | diur        |
+-------------+------------------+-------------+
| Mag         | Sensor           | Depth/Alt   |
+-------------+------------------+-------------+
| Observed    | Gravity          | gobs        |
+-------------+------------------+-------------+
| Eotvos      | Correction       | eot         |
+-------------+------------------+-------------+
| Free        | Air              | Anomaly     |
+-------------+------------------+-------------+

网格文件信息
------------

对于 |-G| ，网格必须使用 Sandwell&Smith img 网格文件或者 GMT 支持的任何网格类型，
img 文件为没有头部信息的球墨卡托 2 字节网格。

E77 误差格式
------------

**头部信息**
    
与测量船有关的信息，如 NCEI 和调查机构的识别代码，测量时间，双向传递时间的校正信息，
数据精度警告，以及从全球网格比较中得到的系统缩放信息，DC 偏移以及相关系数等信息。

下面为一个示例： ::

    # Cruise 08010039 ID 74010908 MGD77 FILE VERSION: 19801230 N_RECS: 3066
    # Examined: Wed Oct 3 16:30:13 2007 by mtchandl
    # Arguments: -De -Gdepth,/data/GRIDS/etopo5_hdr.i2
    N Errata table verification status
    # mgd77manage applies corrections if the errata table is verified (toggle ‘N’ above to ‘Y’ after review)
    # For instructions on E77 format and usage, see http://gmt.soest.hawaii.edu/mgd77/errata.php
    # Verified by:
    # Comments:
    # Errata: Header
    Y-E-08010039-H13-02: Invalid Magnetics Sampling Rate: (99) [ ]
    Y-W-08010039-H13-10: Survey year (1975) outside magnetic reference field IGRF 1965 time range (1965-1970)
    Y-I-08010039-depth-00: RLS m: 1.00053 b: 0 rms: 127.851 r: 0.973422 significant: 1 decimation: 0
    Y-W-08010039-twt-09: More recent bathymetry correction table available
    Y-W-08010039-mtf1-10: Integer precision
    Y-W-08010039-mag-10: Integer precision

**误差记录**

单个误差具有严格的格式。包括一个时间或者距离列，第二列为数据列，然后为一个格式化的
无误差代码字符串，最后为记录中检测到误差记录的描述。其中主要分为三种误差类型，见
下面的 误差代码描述。

格式：``<time/distance> <record number> <error code string> <description>``

示例：::

    # Errata: Data
    Y 08010039 1975-05-10T22:16:05.88 74 C-0-0 NAV: excessive speed

**误差代码描述**

三种误差由破折号分隔，并由字母字符或 0 组合描述，表示检测到问题或者未检测到问题

例如：NAV-VAL-GRAD

误差类型描述：

#. NAV(navigation)
    
    - 0 - fine
    - A - time out of range
    - B - time decreasing
    - C - excessive speed
    - D - above sea level
    - E - lat undefined
    - F - lon undefined

#. VAL(value)
    
    - 0 - fine
    - K - twt invalid
    - L - depth invalid
    - O - mtf1 invalid

#. GRAD(gradient)

    - 0 - fine
    - K - d[twt] excessive
    - L - d[depth] excessive
    - O - d[mtf1] excessive

导航误差 NAV 比较特殊，VAL 和 GRAD 则是按字母表顺序来排序 24 个数字字段的。

=============================================== ==============
X W V U T S R Q P O N M L K J I H G F E D C B A E77 Code
=============================================== ==============
n f e g m d m m m m b b d t p l l m h d m y t d F I
q a o o s i s a t t t c e w t o a i o a o e z r i D
c a t b d u e g f f c c p t c n t n u y n a t   e
s r n 2 1 t r t r                               l
s h h                                           d
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 Bit place
- G C G C C - G G G - - G G - - - T T T T T - - Bit type
=============================================== ==============

其中 Bit type 中

- G : 地球物理观测值

- C : 改正值

- T : 时间

示例
----

查找文件中多余的值 ::

    gmt mgd77sniffer 08010001

丢弃测线文件的梯度 ::

    gmt mgd77sniffer 08010001 -Ds

比较测线中实测深度与 ETOPO5 测深以及 Sanwell/Smith 2 分分辨率 11 版本的重力场 ::

    gmt mgd77sniffer 08010001 -Gdepth,/data/GRIDS/etopo5_hdr.i2 \
        -Gfaa,/data/GRIDS/grav.11.2.img,0.1,1

参考
----

MDG77 格式见
`http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt. <http://www.ngdc.noaa.gov/mgg/dat/geodas/docs/mgd77.txt>`__

相关模块
--------

:doc:`x2sys_init`,
:doc:`mgd77convert`,
:doc:`mgd77header`,
:doc:`mgd77list`,
:doc:`mgd77magref`
:doc:`mgd77info`,
:doc:`mgd77track`,
:doc:`mgd77manage`,
:doc:`mgd77track`
