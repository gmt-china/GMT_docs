:author: 何星辰
:date: 2025-10-19

.. index:: ! rotconverter
.. program:: rotconverter
.. include:: common_SYN_OPTs.rst_

rotconverter
=============

:官方文档: :doc:`gmt:supplements/spotter/rotconverter`  
:简介: 操纵总重建和阶段旋转


**rotconverter** 读取一个或多个存储在给定文件中的板块运动模型（阶段或总重建旋转）。
如果给出了多个板块运动模型，我们将按照它们被列出的顺序进行加法或减法。
减号表示我们应首先转置该旋转，然后将其与前一个旋转相加。
如果某个文件无法打开，我们将尝试将文件名解码为单个旋转，
其参数由斜杠分隔。

语法
--------

**gmt rotconverter** [ **±** ] *rotA* [ **±** *rotB* ] [ **±** *rotC* ] ...
[ |-A| ] [ |-D| ]
[ |-F|\ **s**\|\ **t** ]
[ |-G| ]
[ |-M|\ [*fact*] ]
[ |-N| ] [ |-S| ]
[ |-T| ] [ |-W| ]
[ |SYN_OPT-V| ]
[ |SYN_OPT-h| ]
[ |SYN_OPT--| ]

**注意**：选项标志和相关参数之间不允许有任何空格。

必选选项
------------------

*rotX*
    包含板块运动模型的文件名。用所需的运算符（+ 或 -）分隔多个文件。
    第一个文件也可以有前导减号运算符，表示转置。
    我们也识别形如 A-B 的文件名，其中 A 和 B 都是 GPlates 使用的大写板块缩写，
    表示我们应该在 GPlates 旋转文件中查找两个板块之间的旋转（例如，
    PAC-MBL）。如果任何指定的旋转模型无法作为文件打开，
    我们将尝试将文件名解码为
    *lon/lat/tstart*\ [*/tstop*]/\ *angle*，用于在命令行上给出的单个旋转。
    *tstop* 参数仅对阶段极点是必需的。
    对于没有任何时间信息的单个总重建旋转，
    仅给出 *lon/lat/angle*。

可选选项
------------------

.. _-A:

**-A**
    表明时间实际上只是张开角度 [时间单位为 Myr]。

.. _-D:

**-D**
    报告经度使用 -180/+180 范围 [默认为 0/360]。

.. _-F:

**-F**\ **s**\|\ **t**
    指定旋转的输出格式。 *out* 标志必须是
    **t** （总重建旋转）或 **s** （阶段旋转），
    分别地。[默认为 **-Ft** （输出包含总重建旋转）]。

.. _-G:

**-G**
    以 GPlates 使用的 Plates4 格式输出最终旋转 [默认为 spotter 格式]。

.. _-M:

**-M**\ [*fact*]
    输出时将张开角度缩放 *fact* 倍 [0.5]。
    通常用于获取流线所需的半速率。
    需要阶段极点输出（参见 |-F|）。

.. _-N:

**-N**
    将所有输出极点置于北半球 [默认报告正旋转角度]。

.. _-S:

**-S**
    将所有输出极点置于南半球 [默认报告正旋转角度]。

.. _-T:

**-T**
    转置最终结果，即改变旋转角度的符号。

.. _-W:

**-W**
    确保所有输出旋转具有负的张开角度 [默认报告正旋转角度]。

.. include:: explain_-V.rst_

.. include:: explain_-h.rst_

.. include:: explain_help.rst_

限制
--------

请注意，|-N|、|-S| 和 |-W| 只能同时使用一个。

示例
--------

要将文件 model\_total\_reconstruction.APM 中的总重建旋转转换为阶段极点，请运行::

    gmt rotconverter model_total_reconstruction.APM -Fs > model_stages.APM

要通过将纳斯卡相对于固定太平洋的运动添加到太平洋-热点参考模型 DC85\_stages.txt
来获得纳斯卡相对于太平洋热点的运动，并以北半球的总重建旋转极点报告结果，请尝试::

    gmt rotconverter DC85_stages.APM + Pac_Naz_stages.RPM -N -Ft > \
        Naz_HS_total reconstruction.APM

要添加最终旋转 ROT(150.1, 70.5, -20.3) 和 ROT (145.0, 40.0, 11.4)，请尝试::

    gmt rotconverter 150.1/70.5/-20.3 + 145/40/11.4

这将打印出 157.32, -80.44, 11.97。

要从相对板块运动模型 PL1-PL2.RPM 生成适用于生成流线（转换断层带）的阶段旋转，
假设对称扩张，请尝试::

    gmt rotconverter PL1-PL2.RPM -M -Fs > PL1-PL2_half.RPM
    gmt rotconverter - PL1-PL2.RPM -M -Fs > PL2-PL1_half.RPM

要基于 GPlates 旋转数据库，使用板块环路 India-Central Indian Basin-Antarctica-Africa，
计算印度相对于固定非洲的旋转，请尝试::

    gmt rotconverter IND-CIB CIB-ANT ANT-AFR > India_Africa.RPM

备注
--------

GMT 发布了 EarthByte 旋转模型 Global\_EarthByte\_230-0Ma\_GK07\_AREPS.rot。
要使用备用旋转文件，请创建一个名为
**GPLATES\_ROTATIONS** 的环境变量，指向备用旋转文件。

相关模块
--------

:doc:`backtracker`,
:doc:`grdrotater`,
:doc:`grdspotter`,
:doc:`pmodeler`,
:doc:`grdpmodeler`,
:doc:`grdrotater`,
:doc:`hotspotter`,
:doc:`originater`
